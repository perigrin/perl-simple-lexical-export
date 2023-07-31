# simple::lexical::export

This sets up a simple lexical exporter using the new
`builtin::export_lexically` and subroutine attributes to tag the functions we
want to export.

```perl
$ cat lib/Source.pm
use 5.38.0;
use warnings;

package Utils {
    use simple::lexical::export;
    sub frobnicate :export { ... }
    sub frazzle :export(fry) { ... }
}

$ cat foo.pl
class Foo {
    use Utils;
    method perform { frobincate() }
}
Foo->new()->perform;
````

A better example will come later I hope.
