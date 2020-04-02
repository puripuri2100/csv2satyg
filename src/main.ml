open Arg
open Csv

open OptionState
open Lexing
open Parse
open Lex
open Types


let rec take i lst =
  match lst with
  | []      -> []
  | x :: xs -> (
      if i < 0 then
        []
      else
        x :: (take (i - 1) xs)
  )

let raw_str data =
  data
  |> ShowSATySFiType.show_list 1 (ShowSATySFiType.show_list 2 ShowSATySFiType.to_string)

let type_str data config_lst =
  let f csv_lst =
    let rec sub config_lst csv_lst str =
      match (config_lst, csv_lst) with
      | (x::xs,[]) -> raise (Error.CSV_error "null")
      | ([],_) -> str
      | (x::[],y::ys) -> str ^ ShowSATySFiType.all x y
      | (x::xs,y::ys) -> sub xs ys (str ^ ShowSATySFiType.all x y ^ ", ")
    in
    "(" ^ sub config_lst csv_lst "" ^")"
  in
  data
  |> ShowSATySFiType.show_list 1 f

let get_csv_data path =
  Csv.load path


let write_str main_str output_file_name =
  let open_channel = Pervasives.open_out output_file_name in
  let () = Printf.fprintf open_channel "%s" main_str in
  let () = Pervasives.close_out open_channel in
  ()


let arg_version () =
  print_string "csv2saty version 0.0.1\n"


let arg_input_file curdir s =
  let path =
    if Filename.is_relative s then
      Filename.concat curdir s
    else
      s
  in
  OptionState.set_input_file path

let arg_output curdir s =
  let path =
    if Filename.is_relative s then
      Filename.concat curdir s
    else
      s
  in
  OptionState.set_output_file path

let arg_satysfi_type_str s =
  OptionState.set_satysfi_type_str s

let arg_import s =
  let slst = String.split_on_char ',' s in
  let main_str =
    slst
    |> List.map (fun s -> "@import: " ^ s ^ "\n")
    |> List.fold_left (^) ""
  in
  OptionState.set_import main_str

let arg_require s =
  let slst = String.split_on_char ',' s in
  let main_str =
    slst
    |> List.map (fun s -> "@require: " ^ s ^ "\n")
    |> List.fold_left (^) ""
  in
  OptionState.set_require main_str

let arg_spec curdir =
  [
    ("-v",        Arg.Unit(arg_version)  , "Prints version");
    ("--version", Arg.Unit(arg_version)  , "Prints version");
    ("-f",     Arg.String (arg_input_file curdir), "Specify CSV file");
    ("--file", Arg.String (arg_input_file curdir), "Specify CSV file");
    ("-o",       Arg.String (arg_output curdir), "Specify output file");
    ("--output", Arg.String (arg_output curdir), "Specify output file");
    ("-t",     Arg.String (arg_satysfi_type_str), "Specify SATySFi type");
    ("--type", Arg.String (arg_satysfi_type_str), "Specify SATySFi type");
    ("-i",       Arg.String (arg_import), "Specify import package list");
    ("--import", Arg.String (arg_import), "Specify import package list");
    ("-r",        Arg.String (arg_require), "Specify require package list");
    ("--require", Arg.String (arg_require), "Specify require package list");
  ]


let main =
  Error.error_msg (fun () ->
    let curdir = Sys.getcwd () in
    let () = Arg.parse (arg_spec curdir) (arg_input_file curdir) "" in
    let input_file_name =
      match OptionState.get_input_file () with
      | None -> raise (Error.Option_error "not file name")
      | Some(s) -> s
    in
    let raw_csv_data = get_csv_data input_file_name in
    let output_file_name =
      match OptionState.get_output_file () with
      | None -> raise (Error.Option_error "not file name")
      | Some(s) -> s
    in
    let output_fun_name =
      output_file_name |> Filename.basename |> Filename.chop_extension
    in
    let str =
      match OptionState.get_satysfi_type_str () with
      | None -> raw_str raw_csv_data
      | Some(s) ->
        s
        |> Lexing.from_string
        |> Parse.parse Lex.lex
        |> type_str raw_csv_data
    in
    let require_str =
      match OptionState.get_require () with
      | None -> ""
      | Some(s) -> s
    in
    let import_str =
      match OptionState.get_import () with
      | None -> ""
      | Some(s) -> s
    in
    let main_str =
      require_str ^ "\n" ^
      import_str ^ "\n" ^
      "let " ^ output_fun_name ^ " =\n" ^ str ^ "\n"
    in
      write_str main_str output_file_name
  )
