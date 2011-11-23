use inc::Module::Install;
use Module::Install::ReadmeFromPod;
use Module::Install::Repository;
name 'Test-TypeConstraints';
all_from 'lib/Test/TypeConstraints.pm';
readme_from 'lib/Test/TypeConstraints.pm';

# requires '';

tests_recursive 't';
author_tests 'xt';

build_requires 'Test::More', '0.98';
build_requires 'Test::LoadAllModules';
build_requires 'Test::Requires';
build_requires 'IO::Scalar';
build_requires 'Test::Tester';

requires 'Mouse::Util::TypeConstraints';
requires 'Test::More', '0.98';
requires 'Data::Dumper';
requires 'Test::Builder';
requires 'Scalar::Util';

auto_set_repository;
WriteAll;
