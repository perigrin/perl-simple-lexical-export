use Test::More;
use strict;

package Source {
    use simple::lexical::export;
    sub foo :export { 'Source::foo' }
    sub baz :export(bar) { 'Source::baz' }
}

sub foo { 'foo' }
sub bar { 'bar' }

is foo(), main::foo(), 'foo() is main::foo()';
is bar(), main::bar(), 'bar() is main::bar()';
{
    BEGIN { Source->import() }
    is foo(), 'Source::foo', 'foo() is Source::foo()';
    is bar(), 'Source::baz', 'bar() is Source::baz()';
}
is foo(), main::foo(), 'foo is main::foo() again';
is bar(), main::bar(), 'bar is main::bar() again';

done_testing();
