open Str
open Range
open Types
open Error

val make_tab : int -> string

val to_string : string -> string

val to_bool : string -> string

val to_int : string -> string

val to_float : string -> string

val to_inline_text : string -> string

val to_block_text : string -> string

val to_block_text_pro : string -> string

val show_list : int -> ('a -> string) -> 'a list -> string

val show_tuple : ('a -> string) -> 'a list -> string

val all : Types.satysfiType -> string -> string
