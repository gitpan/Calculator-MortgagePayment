use strict;use warnings;
use Module::Build;

my $builder = Module::Build->new(
    sign              => 1,
    module_name       => 'Calculator::MortgagePayment',
    license           => 'perl',
    dist_author       => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from => 'lib/Calculator/MortgagePayment.pm',
    add_to_cleanup    => [ 'Calculator-MortgagePayment-*' ],    
    build_requires    => {
        'Moose'                        => '2.0006',
        'namespace::clean'             => '0.20',
        'Moose::Util::TypeConstraints' => '2.0006',
    },
);

$builder->create_build_script();