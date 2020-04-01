open Range

type satysfiType =
  | SATySFiFunction of Range.t
  | SATySFiString of Range.t
  | SATySFiBool of Range.t
  | SATySFiInt of Range.t
  | SATySFiFloat of Range.t
  | SATySFiLength of Range.t
  | SATySFiInlineText of Range.t
  | SATySFiBlockText of Range.t
  | SATySFiList of satysfiType

