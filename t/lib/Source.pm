use 5.38.0;

package Source {
    use simple::lexical::export;
    sub foo : export      { 'Source::foo' }
    sub baz : export(bar) { 'Source::baz' }
    sub cache :export lvalue  { state $val; $val }

    # must be state, my doesn't stick around long enough
    state sub priv :export { 'Source::private' }
}

1;
