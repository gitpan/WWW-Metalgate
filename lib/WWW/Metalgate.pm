package WWW::Metalgate;

use warnings;
use strict;

use WWW::Metalgate::Column;
use WWW::Metalgate::Year;

=head1 NAME

WWW::Metalgate - parse http://www.metalgate.jp/.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use WWW::Metalgate;

    my @years  = WWW::Metalgate->years;
    my @albums = $years[0]->best_albums;

=head1 EXPORT

none.

=head1 FUNCTIONS

=head2 years

    my @years = WWW::Metalgate->years; # WWW::Metalgate::Year instances.

=cut

sub years {
    WWW::Metalgate::Column->new->years;
}

=head2 year

    my $year = WWW::Metalgate->year( year => 2000 ); # WWW::Metalgate::Year instance.

=cut

sub year {
    WWW::Metalgate::Year->new( year => $_[1] );
}

=head1 AUTHOR

Tomohiro Hosaka, C<< <bokutin at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008 Tomohiro Hosaka, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
