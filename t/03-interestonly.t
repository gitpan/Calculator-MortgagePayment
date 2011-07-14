#!perl

use strict; use warnings;
use Calculator::MortgagePayment;
use Test::More tests => 1;

my $calculator = Calculator::MortgagePayment->new(100000, 5, 240);;
is(411, $calculator->interestOnly());