open Range

exception Lexer_error_range of Range.t

exception Parser_error

exception Option_error of string

exception CSV_error of string

val error_msg : (unit -> unit) -> unit
