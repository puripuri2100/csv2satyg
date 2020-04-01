type state = {
  mutable input_file : string option;
  mutable output_file : string option;
  mutable satysfi_type_str : string option;
  mutable import : string option;
  mutable require : string option;
}


let state = {
  input_file = None;
  output_file = None;
  satysfi_type_str = None;
  import = None;
  require = None;
}

let set_input_file s =
  state.input_file <- Some(s)

let get_input_file () =
  state.input_file


let set_output_file s =
  state.output_file <- Some(s)

let get_output_file () =
  state.output_file


let set_satysfi_type_str s =
  state.satysfi_type_str <- Some(s)

let get_satysfi_type_str () =
  state.satysfi_type_str


let set_import s =
  state.import <- Some(s)

let get_import () =
  state.import


let set_require s =
  state.require <- Some(s)

let get_require () =
  state.require
