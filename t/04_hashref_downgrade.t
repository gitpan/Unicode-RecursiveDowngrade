use strict;
use Test::More;
my $dummy = {
    foo => 'ユー',
    bar => 'ティー',
    baz => 'エフ',
    qux => 'エイト',
};
eval {
    for my $key (keys %$dummy) {
	utf8::upgrade($dummy->{$key});
    }
};
if ($@) {
    plan skip_all => 'can not call utf8::upgrade';
}
else {
    plan tests => 9;
}
use_ok('Unicode::RecursiveDowngrade');
SKIP: {
    skip 'can not call utf8::is_utf8' if $] < 5.008001;
    for my $key (keys %$dummy) {
	ok(utf8::is_utf8($dummy->{$key}), "is flagged variable");
    }
    my $rd = Unicode::RecursiveDowngrade->new;
    $dummy = $rd->downgrade($dummy);
    for my $key (keys %$dummy) {
	ok(! utf8::is_utf8($dummy->{$key}), "is unflagged variable");
    }
}
