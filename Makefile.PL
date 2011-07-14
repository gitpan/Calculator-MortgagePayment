use strict;use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Calculator::MortgagePayment',
    AUTHOR        => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM  => 'lib/Calculator/MortgagePayment.pm',
    ABSTRACT_FROM => 'lib/Calculator/MortgagePayment.pm',
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'Calculator-MortgagePayment-*' },    
    PREREQ_PM     => {
        'Moose'                        => '2.0006',
        'namespace::clean'             => '0.20',
        'Moose::Util::TypeConstraints' => '2.0006',
    },
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
);