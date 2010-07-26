USING: accessors math s-exp.parser sequences xml.syntax ;
IN: s-exp.to-xml

GENERIC: s-exp>xml ( s-exp -- xml )

M: number s-exp>xml
    [XML <number><-></number> XML] ;

M: sequence s-exp>xml
    [ s-exp>xml ] map
    [XML <list><-></list> XML] ;

M: symbol s-exp>xml
    name>> [XML <symbol><-></symbol> XML] ;

: s-exps>xml ( s-exp -- xml )
    s-exp>xml <XML <s-exp><-></s-exp> XML> ;
