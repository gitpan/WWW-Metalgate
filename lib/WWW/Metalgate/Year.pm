package WWW::Metalgate::Year;

use warnings;
use strict;

use Moose;
use MooseX::Types::URI qw(Uri FileUri DataUri);
use Encode;
use IO::All;
use Text::Trim;

=head1 NAME

WWW::Metalgate::Year

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use WWW::Metalgate::Year;
    use XXX;

    my $year   = WWW::Metalgate::Year->new( year => 2003 );
    my @albums = $year->best_albums;
    YYY @albums;
    #---
    #album: EPICA
    #artist: KAMELOT
    #no: 1
    #year: 2003
    #---
    #album: DELIRIUM VEIL
    #artist: TWILIGHTNING
    #no: 2
    #year: 2003
    #---
    #... snip ...

=head1 FUNCTIONS

=head2 uri

=head2 year

=cut

has 'uri'  => (is => 'rw', isa => Uri, coerce  => 1);
has 'year' => (is => 'ro', isa => 'Int', required => 1);

=head2 BUILD

=cut

sub BUILD {
    my $self = shift;

    # http://www.metalgate.jp/best1992.htm
    $self->uri( sprintf("http://www.metalgate.jp/best%s.htm", $self->year) );
}

=head2 best_albums

=cut

sub best_albums {
    my $self = shift;

    my @albums;

    my $html = do {
        my $all = io($self->uri)->all;
        $all = decode("cp932", $all);
        $all =~ s/\015\012\s*//g;
        $all =~ m/(?:The Best 10 Albums of \d{4}|The Best Albums of The 1993)/g;
        $all =~ m/\G.*?<hr>/g;
        $all =~ m/\G(.*?)<hr>/g;
        $1;
    };

    return unless $html;

    my $no = 1;
    my $re = qr|>([^<>]*?) / ([^<>]*?)<|msi;
    while ($html =~ m/$re/g) {
        push @albums, {
            artist => trim($1),
            album  => trim($2),
            no     => $no,
            year   => $self->year,
        };
        $no++;
    }

    return @albums;
}

=head1 AUTHOR

Tomohiro Hosaka, C<< <bokutin at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008 Tomohiro Hosaka, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
