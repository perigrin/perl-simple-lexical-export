package simple::lexical::export;
use 5.38.0;
use experimental 'builtin';
use builtin 'export_lexically';
use Sub::Util qw(subname);

sub import($class) {
    my $pkg = caller;
    my %exports = ();

    # TODO figure out how to clean this up after we're done
    no strict "refs";
    *{ $pkg.'::MODIFY_CODE_ATTRIBUTES' } = sub ($pkg, $ref, @attr) {
        my $name = ((subname $ref) =~ /::(.+)$/)[0];
        my @bad = ();
        for (@attr) {
            if (m/^export(?:\( ([^)]+) \))?/x) {
                $exports{$1 // $name} = $ref;
            } else {
                push @bad, $_;
            }
        }
        return @bad;
    };

    *{ $pkg.'::import' } = sub { export_lexically %exports };
}

