open Range

exception Lexer_error_range of Range.t

exception Parser_error

exception Option_error of string

exception CSV_error of string

type t =
  | Lexer
  | Parser
  | Option
  | CSV


let print_error (t:t) str =
  let err_title =
    match t with
    | Lexer -> "Lexer"
    | Parser -> "Parser"
    | Option -> "Option"
    | CSV -> "CSV"
  in
  Printf.printf "![%sError]\n%s\n" err_title str

let error_msg t =
  try
    t ()
  with
    | Lexer_error_range(pos) ->
      let range = Range.to_string pos in
      print_error Lexer range
    | Option_error(msg) -> print_error Option msg
    | CSV_error(msg) -> print_error CSV msg
