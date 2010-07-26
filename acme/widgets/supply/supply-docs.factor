! Copyright (C) 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: help.markup help.syntax kernel math ;
IN: acme.widgets.supply

HELP: air-shipping
{ $var-description "" } ;

HELP: ground-shipping
{ $var-description "" } ;

HELP: send-widget-order
{ $values
    { "widget-count" integer } { "delivery-method" "a delivery method" }
}
{ $description "Send an order for more widgets using a super-complicated web service protocol." } ;

ARTICLE: "acme.widgets.supply" "acme.widgets.supply"
{ $vocab-link "acme.widgets.supply" }
;

ABOUT: "acme.widgets.supply"
