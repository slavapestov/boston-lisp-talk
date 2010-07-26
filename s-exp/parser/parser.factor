USING: arrays kernel math.parser memoize peg.ebnf strings ;
IN: s-exp.parser

TUPLE: symbol name ;

MEMO: <symbol> ( name -- symbol ) symbol boa ;

EBNF: parse-s-exp

Symbol = (([a-zA-Z-<>])+) => [[ >string <symbol> ]]
Digit = ([0-9])
Number = Digit+ => [[ string>number ]]
Space = (" " | "\t" | "\r" | "\n")
Term = List | Number | Symbol
Terms = (Space* Term:t => [[ t ]])*
List = "(" Terms:t Space* ")" => [[ t >array ]]

;EBNF
