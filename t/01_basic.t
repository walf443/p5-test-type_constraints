package Hoge;
use Mouse;

package main;
use strict;
use warnings;
use Test::TypeConstraints;
use Test::More;
use Mouse::Util::TypeConstraints qw(subtype as where);
use Test::Builder::Tester;
use IO::Scalar;

subtest "Mouse TypeConstraints name str ok" => sub {
    subtest "success" => sub {
        type_is_a_ok([1, 2, 3], "ArrayRef[Int]", "Mouse TypeConstraints name str ok");
    };
};

my $hoge = Hoge->new;

type_is_a_ok($hoge, "Hoge", "class name ok");

my $subtype = subtype 'HogeClass' => as 'Object' => where { $_->isa("Hoge") } ;
type_is_a_ok($hoge, $subtype, "Mouse TypeConstraints object ok");

done_testing();
