package Test::TypeConstraints;
use strict;
use warnings;
use 5.008001;
our $VERSION = '0.01';
use Exporter 'import';
use Test::More;
use Test::Builder;
use Mouse::Util::TypeConstraints ();
use Scalar::Util ();
use Data::Dumper;

our @EXPORT = qw/ type_is_a_ok /;

sub type_is_a_ok {
    my ($got, $type, $test_name) = @_;

    my $tc;
    # duck typing for (Mouse|Moose)::Meta::TypeConstraints
    if ( Scalar::Util::blessed($type) && $type->can("check") ) {
        $tc = $type;
    } else {
        $tc = Mouse::Util::TypeConstraints::find_or_create_isa_type_constraint($type);
    }
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my $ret = ok($tc->check($got), $test_name || ( $tc->name . " types ok" ) )
        or diag(sprintf('type: "%s" expected. but got %s', $tc->name, Dumper($got)));

    return $ret;
}

1;
__END__

=head1 NAME

Test::TypeConstraints - testing value with Data::Validator like validation.

=head1 SYNOPSIS

  use Test::TypeConstraints;

  Test::TypeConstraints::type_is_a_ok($got, "ArrayRef[Int]", "type should be ArrayRef[Int]");

=head1 DESCRIPTION

Test::TypeConstraints is for testing type check with Data::Validator like validation.

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 SEE ALSO

+<Data::Validator>, +<Mouse::Util::TypeConstraints>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
