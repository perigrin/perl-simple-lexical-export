use Test::More;
use strict;
use lib 't/lib/';

sub foo { 'foo' }
sub bar { 'bar' }

{
    note "default scope";
    is foo(), main::foo(), 'foo is main::foo()';
    is bar(), main::bar(), 'bar is main::bar()';
}
{
    note "default import";
    use Source;
    is foo(), Source::foo(), 'foo() is Source::foo()';
    is bar(), Source::baz(), 'bar() is Source::baz()';
}
{
    note "default scope again";
    is foo(), main::foo(), 'foo is main::foo()';
    is bar(), main::bar(), 'bar is main::bar()';
}
{
    note "import only foo";
    use Source qw(foo);
    is foo(), Source::foo(), 'foo() is Source::foo()';
    is bar(), main::bar(),   'bar() is main::bar()';
}

{
    note "lvalue test";
    use Source qw(cache);
    is cache(), undef, 'cache initially 0';
    ok cache() = 1, 'cache = 1';
    is cache(), 1, "see new value of cache";
}

{
    note "lvalue test cont.";
    use Source qw(cache);
    is cache(), 1, 'cache initially 1';
}

{
    note "private exports";
    use Source qw(priv);
    main::ok(Source->can('cache'), 'Source can cache');
    main::ok(!Source->can('priv'), 'Source cannot priv');
    is priv(), 'Source::private', 'able to export state sub';
}

done_testing();
