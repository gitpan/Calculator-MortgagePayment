package Calculator::MortgagePayment;

use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean;

=head1 NAME

Calculator::MortgagePayment - Interface to Mortgage Payment Calculator.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 DESCRIPTION

A  very  lightweight  interface to calculate the mortgage payment with either the repayment or
interest only option.

=cut

type 'Amount' => where { ($_ =~ /^\d+$|^\d+\.\d+?$/) && ($_ > 0) };
type 'Rate'   => where { ($_ =~ /^\d+$|^\d+\.\d+?$/) && ($_ > 0) };
type 'Term'   => where { ($_ =~ /^\d+$/) && ($_ > 0) };

has 'amount' => (is => 'ro', isa => 'Amount', required => 1);
has 'rate'   => (is => 'ro', isa => 'Rate',   required => 1);
has 'term'   => (is => 'ro', isa => 'Term',   required => 1);

around BUILDARGS => sub
{
    my $orig  = shift;
    my $class = shift;

    if ((@_ == 1) && !ref($_[0]))
    {
        return $class->$orig(amount => $_[0]);
    }
    elsif ((@_ == 2) && !ref($_[0]))
    {
        return $class->$orig(amount => $_[0], rate => $_[1]);
    }
    elsif ((@_ == 3) && !ref($_[0]))
    {
        return $class->$orig(amount => $_[0], rate => $_[1], term => $_[2]);
    }
    else
    {
        return $class->$orig(@_);
    }
};

=head1 CONSTRUCTOR

The constructor expects three parameters i.e. amount, rate and term as specified below in the table.

    +-----------+------------------------------------------------+
    | Parameter | Meaning                                        |
    +-----------+------------------------------------------------+
    | amount    | The total loan amount without any comma in it. |
    | rate      | The interest rate.                             |
    | term      | The total number of months.                    |
    +-----------+------------------------------------------------+

    use strict; use warnings;
    use Calculator::MortgagePayment;

    my ($calculator);

    $calculator = Calculator::MortgagePayment->new(100000, 5.5, 360);
    # or
    $calculator = Calculator::MortgagePayment->new({amount => 100000, rate => 5.5, term => 360});

=head1 METHODS

=head2 repayment()

Returns the amount to be paid monthly with repayment option.

    use strict; use warnings;
    use Calculator::MortgagePayment;

    my $calculator = Calculator::MortgagePayment->new(100000, 5.5, 360);
    my $repayment  = $calculator->repayment();

=cut

sub repayment
{
    my $self = shift;
    my $i = $self->{rate}/12;
    my $x = sprintf("%.04f",1/(1+$i/100));
    return int($self->{amount} * ($x-1)/(($x ** ($self->{term}+1)) - $x));
}

=head2 interestOnly()

Returns the amount to be paid monthly with interest only option.

    use strict; use warnings;
    use Calculator::MortgagePayment;

    my $calculator   = Calculator::MortgagePayment->new(100000, 5.5, 360);
    my $interestOnly = $calculator->interestOnly();

=cut

sub interestOnly
{
    my $self = shift;
    my $i = $self->{rate}/12;
    my $x = sprintf("%.04f",1/(1+$i/100));
    return int(($self->{amount} - $self->{amount} * ($x ** $self->{term})) * ($x - 1)/(($x ** ($self->{term}+1) - $x)));
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-calculator-mortgagepayment at rt.cpan.org>
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Calculator-MortgagePayment>.
I will be notified and then you'll automatically be notified of progress on your bug as I make
changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Calculator::MortgagePayment

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Calculator-MortgagePayment>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Calculator-MortgagePayment>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Calculator-MortgagePayment>

=item * Search CPAN

L<http://search.cpan.org/dist/Calculator-MortgagePayment/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Mohammad S Anwar.

This  program  is  free  software; you can redistribute it and/or modify it under the terms of
either:  the  GNU  General Public License as published by the Free Software Foundation; or the
Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DISCLAIMER

This  program  is  distributed in the hope that it will be useful,  but  WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

__PACKAGE__->meta->make_immutable;
no Moose; # Keywords are removed from the Calculator::MortgagePayment package
no Moose::Util::TypeConstraints;

1; # End of Calculator::MortgagePayment