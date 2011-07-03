package Test::TypeConstraints;

use strict;
use warnings;
use 5.008001;
our $VERSION = '0.01';
use Exporter 'import';
use Test::More;
use Test::Builder;
use Data::Validator;
use Data::Dumper;

our @EXPORT = qw/ type_is_a_ok /;

sub type_is_a_ok {
    my ($got, $type, $test_name) = @_;

    my $rule = Data::Validator->new(
        got => +{
            isa => $type,
            coerce => 0,
        },
    )->with('NoThrow');
    my $args = $rule->validate(got => $got);
    local $Test::Builder::Level += 2;
    my $ret = ok(! $rule->has_errors, $test_name || "should not have type error");
    if ( ! $ret ) {
        my $dava_validator_msg = join "\n", map { $_->{message} } @{ $rule->clear_errors };
        $dava_validator_msg =~ s/with value (.+$)/with value @{[ Dumper($got) ]}/;
        diag($dava_validator_msg);
    }
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
