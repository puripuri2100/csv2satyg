%{
  open Range
  open Types
  open Error
%}

%token <Range.t>SATySFiFunction
%token <Range.t>SATySFiString
%token <Range.t>SATySFiBool
%token <Range.t>SATySFiInt
%token <Range.t>SATySFiFloat
%token <Range.t>SATySFiLength
%token <Range.t>SATySFiInlineText
%token <Range.t>SATySFiBlockText
%token <Range.t> SATySFiList
%token <Range.t>LPAREN
%token <Range.t>RPAREN
%token <Range.t>LBRAC
%token <Range.t>RBRAC
%token <Range.t>SemiColon
%token <Range.t>Comma
%token EOF

%start parse
%type <Types.satysfiType list> parse

%%

parse :
  | term EOF { $1 }
;
satysfiType_cont :
  | SATySFiFunction {SATySFiFunction($1)}
  | SATySFiString {SATySFiString($1)}
  | SATySFiBool {SATySFiBool($1)}
  | SATySFiInt {SATySFiInt($1)}
  | SATySFiFloat {SATySFiFloat($1)}
  | SATySFiLength {SATySFiLength($1)}
  | SATySFiInlineText {SATySFiInlineText($1)}
  | SATySFiBlockText {SATySFiBlockText($1)}
;
satysfiType :
  | satysfiType_cont SATySFiList {SATySFiList($1)}
  | satysfiType_cont {$1}
;
type_lstcont:
  | { [] }
  | satysfiType { [$1] }
  | satysfiType SemiColon type_lstcont { $1 :: $3 }
;
type_lst:
  | LBRAC type_lstcont RBRAC { $2 }
;
type_tuplecont:
  | { [] }
  | satysfiType { [$1] }
  | satysfiType Comma type_tuplecont { $1 :: $3 }
;
type_tuple:
  | LPAREN type_tuplecont RPAREN { $2 }
;
term:
  | type_lst {$1}
  | type_tuple {$1}
;
%%
