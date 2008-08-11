use strict;
use warnings;

use Test::More tests => 13;

use_ok("WWW::Metalgate");
#WWW::Metalgate->year( 500 )->best_albums;
#my @years = WWW::Metalgate->years;
#for my $year (@years) {
#    warn $year->year;
#    XXX $year->best_albums;
#    last;
#}

{
    use_ok("WWW::Metalgate::Column");
    my $column = WWW::Metalgate::Column->new;
    #my $column = WWW::Metalgate::Column->new(uri=>URI->new("http://www.metalgate.jp/column.htm"));
    is($column->uri, "http://www.metalgate.jp/column.htm");
    isa_ok($column->uri, "URI");
    can_ok($column, "years");
    my @years = $column->years;
    is(0+@years, @{[1992 .. 2007]}, 'number of years');
}

{
    use_ok("WWW::Metalgate::Year");
    my $year = WWW::Metalgate::Year->new(year=>2000);
    ok($year, 'got instance');
    is($year->year, 2000);
    is($year->uri, "http://www.metalgate.jp/best2000.htm");
    isa_ok($year->uri, "URI");
    my @albums = $year->best_albums;
    is(0+@albums, 10);
}

ok(1, "last test");
