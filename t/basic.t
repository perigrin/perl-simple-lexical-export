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
done_testing();
