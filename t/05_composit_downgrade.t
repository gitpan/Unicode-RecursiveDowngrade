use strict;
use Test::More;
my $dummy = {
    foo  => 'ユー',
    bar  => 'ティー',
    baz  => 'エフ',
    qux  => 'エイト',
    quux => [
	'フラグ',
	'とやら',
	'僕は',
	'ぶっちゃけ',
	'あんま',
	'好きくない',
    ],
    corge => {
	grault => '日本人の',
	garply => '多くは',
	waldo  => '嫌い',
	fred   => 'なんじゃ',
	plugh  => [
	    'ない',
	    'の？',
	],
    },
};
eval {
    for my $key (qw(foo bar baz qux)) {
	utf8::upgrade($dummy->{$key});
    }
    for my $elem (@{$dummy->{quux}}) {
	utf8::upgrade($elem);
    }
    for my $key (qw(grault garply waldo fred)) {
	utf8::upgrade($dummy->{corge}{$key});
    }
    for my $elem (@{$dummy->{corge}{plugh}}) {
	utf8::upgrade($elem);
    }
};
if ($@) {
    plan skip_all => 'can not call utf8::upgrade';
}
else {
    plan tests => 33;
}
use_ok('Unicode::RecursiveDowngrade');
SKIP: {
    skip 'can not call utf8::is_utf8' if $] < 5.008001;
    for my $key (qw(foo bar baz qux)) {
	ok(utf8::is_utf8($dummy->{$key}), "is flagged variable");
    }
    for my $elem (@{$dummy->{quux}}) {
	ok(utf8::is_utf8($elem), "is flagged variable");
    }
    for my $key (qw(grault garply waldo fred)) {
	ok(utf8::is_utf8($dummy->{corge}{$key}), "is flagged variable");
    }
    for my $elem (@{$dummy->{corge}{plugh}}) {
	ok(utf8::is_utf8($elem), "is flagged variable");
    }
    my $rd = Unicode::RecursiveDowngrade->new;
    $dummy = $rd->downgrade($dummy);
    for my $key (qw(foo bar baz qux)) {
	ok(! utf8::is_utf8($dummy->{$key}), "is unflagged variable");
    }
    for my $elem (@{$dummy->{quux}}) {
	ok(! utf8::is_utf8($elem), "is unflagged variable");
    }
    for my $key (qw(grault garply waldo fred)) {
	ok(! utf8::is_utf8($dummy->{corge}{$key}), "is unflagged variable");
    }
    for my $elem (@{$dummy->{corge}{plugh}}) {
	ok(! utf8::is_utf8($elem), "is unflagged variable");
    }
}
