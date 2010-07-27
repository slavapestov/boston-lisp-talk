USING: acme.widgets.supply combinators io kernel math namespaces ;
IN: acme.widgets.factory

SYMBOL: widgets

40 widgets set-global

: build-stuff ( -- )
    widgets [ 10 - ] change ;

: check-widget-supply ( -- )
    {
        { [ widgets get 20 < ] [ 20 ground-shipping send-widget-order ] }
        { [ widgets get 10 < ] [ 10 air-shipping send-widget-order ] }
        [ "Widgets are fully stocked" print ]
    } cond ;
