use inc::Module::Install;

name     'WWW-Metalgate';
all_from 'lib/WWW/Metalgate.pm';
author   'Tomohiro Hosaka <bokutin@cpan.org>';

requires 'Encode';
requires 'IO::All';
requires 'IO::All::LWP';
requires 'Moose';
requires 'MooseX::Types::URI';
requires 'Text::Trim';
requires 'Web::Scraper';

build_requires 'Test::More';
build_requires 'Test::UseAllModules';

auto_install;

WriteAll;
