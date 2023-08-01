package Source {
    use simple::lexical::export;
    sub foo : export      { 'Source::foo' }
    sub baz : export(bar) { 'Source::baz' }
}

1;
