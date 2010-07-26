USING: definitions fry kernel parser random words ;
IN: dice

SYMBOL: +dice+

: define-dice ( word seq -- )
    [ +dice+ set-word-prop ]
    [ '[ _ random ] (( -- obj )) define-declared ] 2bi ;

SYNTAX: DICE:
    CREATE-WORD \ ; parse-until define-dice ;

PREDICATE: dice-word < word
    +dice+ word-prop >boolean ;

M: dice-word definer drop \ DICE: \ ; ;

M: dice-word definition +dice+ word-prop ;
