{
  open Parse
  open Error

  let get_pos lexbuf =
    let posS = Lexing.lexeme_start_p lexbuf in
    let posE = Lexing.lexeme_end_p lexbuf in
    let fname = posS.Lexing.pos_fname in
    let lnum = posS.Lexing.pos_lnum in
    let cnumS = posS.Lexing.pos_cnum - posS.Lexing.pos_bol in
    let cnumE = posE.Lexing.pos_cnum - posE.Lexing.pos_bol in
      Range.make fname lnum cnumS cnumE
}

let space = [' ' '\t' '\n' '\r']
let digit = ['0'-'9']
let alpha = ( ['a'-'z'] | ['A'-'Z'] )
let alnum = digit | alpha
let string = [^ ' ' '\t' '\n' '\r' '(' ')' '[' ']' ',' ';' '*' '"']

rule lex = parse
  | space+   { lex lexbuf }
  | "function" {
      let pos = get_pos lexbuf in
      SATySFiFunction(pos)
    }
  | "string" {
      let pos = get_pos lexbuf in
      SATySFiString(pos)
    }
  | "bool" {
      let pos = get_pos lexbuf in
      SATySFiBool(pos)
    }
  | "int" {
      let pos = get_pos lexbuf in
      SATySFiInt(pos)
    }
  | "float" {
      let pos = get_pos lexbuf in
      SATySFiFloat(pos)
    }
  | "length" {
      let pos = get_pos lexbuf in
      SATySFiLength(pos)
    }
  | "inline-text" {
      let pos = get_pos lexbuf in
      SATySFiInlineText(pos)
    }
  | "block-text" {
      let pos = get_pos lexbuf in
      SATySFiBlockText(pos)
    }
  | "list" {
      let pos = get_pos lexbuf in
      SATySFiList(pos)
    }
  | '(' {
      let pos = get_pos lexbuf in
      LPAREN(pos)
    }
  | ')' {
      let pos = get_pos lexbuf in
      RPAREN(pos)
    }
  | '[' {
      let pos = get_pos lexbuf in
      LBRAC(pos)
    }
  | ']' {
      let pos = get_pos lexbuf in
      RBRAC(pos)
    }
  | ';' {
      let pos = get_pos lexbuf in
      SemiColon(pos)
    }
  | ',' {
      let pos = get_pos lexbuf in
      Comma(pos)
    }
  | eof {EOF}
  | _  {
    let pos = get_pos lexbuf in
    raise (Error.Lexer_error_range pos)
  }
 