USING: formatting kernel ;
IN: acme.widgets.supply

SYMBOLS: ground-shipping air-shipping ;

: send-widget-order ( widget-count delivery-method -- )
    "Sent an order for %d widgets using %s.\n" printf ;
