#!perl

use strict; use warnings;
use Calculator::MortgagePayment;
use Test::More tests => 8;

my ($calculator);

eval { $calculator = Calculator::MortgagePayment->new(); };
like($@, qr/Attribute \(amount\) is required/);

eval { $calculator = Calculator::MortgagePayment->new(100000); };
like($@, qr/Attribute \(rate\) is required/);

eval { $calculator = Calculator::MortgagePayment->new(100000, 5.5); };
like($@, qr/Attribute \(term\) is required/);

eval { $calculator = Calculator::MortgagePayment->new({ amount => 100000 }); };
like($@, qr/Attribute \(rate\) is required/);

eval { $calculator = Calculator::MortgagePayment->new({ amount => 100000, rate => 5.5 }); };
like($@, qr/Attribute \(term\) is required/);

eval { $calculator = Calculator::MortgagePayment->new({ amount => -10, rate => 5.5, term => 12 }); };
like($@, qr/Attribute \(amount\) does not pass the type constraint/);

eval { $calculator = Calculator::MortgagePayment->new({ amount => 100000, rate => -5.5, term => 12 }); };
like($@, qr/Attribute \(rate\) does not pass the type constraint/);

eval { $calculator = Calculator::MortgagePayment->new({ amount => 100000, rate => 5.5, term => 1.2 }); };
like($@, qr/Attribute \(term\) does not pass the type constraint/);