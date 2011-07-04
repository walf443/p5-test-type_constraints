use strict;
use warnings;
use Test::More;
use Test::TypeConstraints qw(type_isa);
use Test::Builder::Tester;

test_out("not ok 1 - fail test case");
my $expected_err = <<'END_OF_ERR';
#   Failed test 'fail test case'
#   at t/02_failcase.t line 20.
# type: "ArrayRef[Int]" expected. but got $VAR1 = [
#           1,
#           2,
#           'abc'
#         ];
END_OF_ERR
chomp $expected_err;
test_err($expected_err);

type_isa([1, 2, "abc"], "ArrayRef[Int]", "fail test case");

test_test("testing");

done_testing;
