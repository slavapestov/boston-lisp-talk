USING: alien.data.map byte-arrays math math.vectors
math.vectors.conversion math.vectors.simd sequences
specialized-arrays typed kernel ;
FROM: alien.c-types => float ;
IN: specialized-array-example

: convert-image ( in -- out )
    [ 255 * >fixnum ] { } map-as ;

SPECIALIZED-ARRAYS: float float-4 uchar-16 ;

TYPED: convert-image-specialized ( in: float-array -- out: byte-array )
    [ 255 * >fixnum ] B{ } map-as ;

TYPED: convert-image-simd ( in: float-array -- out: byte-array )
    [
        [
            [ 255.0 v*n float-4 int-4 vconvert ] bi@
            int-4 short-8 vconvert
        ] 2bi@
        short-8 uchar-16 vconvert
    ] data-map( float-4[4] -- uchar-16 ) ;
