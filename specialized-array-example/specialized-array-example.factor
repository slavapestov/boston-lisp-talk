USING: alien.data.map byte-arrays math math.vectors
math.vectors.conversion math.vectors.simd sequences
specialized-arrays typed kernel tools.time random memoize ;
FROM: alien.c-types => float ;
IN: specialized-array-example

SPECIALIZED-ARRAYS: float ;

: len ( -- n ) 25 2^ ;

MEMO: image-data ( -- seq )
    len iota [ len /f ] float-array{ } map-as ;




: convert-image ( in -- out )
    [ 255 * >fixnum ] { } map-as ;

: benchmark-1 ( -- )
    image-data [ convert-image ] time drop ;





TYPED: convert-image-specialized ( in: float-array -- out: byte-array )
    [ 255 * >fixnum ] B{ } map-as ;

: benchmark-2 ( -- )
    image-data [ convert-image-specialized ] time drop ;




SPECIALIZED-ARRAYS: float-4 uchar-16 ;

: pack-floats ( a b c d -- result )
    [
        [ 255.0 v*n float-4 int-4 vconvert ] bi@
        int-4 short-8 vconvert
    ] 2bi@
    short-8 uchar-16 vconvert ; inline

TYPED: convert-image-simd ( in: float-array -- out: byte-array )
    [ pack-floats ] data-map( float-4[4] -- uchar-16 ) ;

: benchmark-3 ( -- )
    image-data [ convert-image-simd ] time drop ;
