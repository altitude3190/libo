#!/usr/bin/perl
# I want to use /usr/bin/env perl, but I found out that it didn't run with perl >= 5.26.
# So, it runs with system perl whose version is probably 5.18.
use strict;
use warnings;
use utf8;

use FindBin;
use Pod::Usage qw/pod2usage/;
use File::Basename qw/basename/;

my $VERSION = '1.0.0';
my $LIC_TXT_DIR_PATH = "$FindBin::RealBin/boilerplates";

# treat arguments
my $author = `git config user.name` || '';
my $cmd = '';
my $args = [];
while (my $arg = shift @ARGV) {
    if ($arg eq '--author') {
        $author = shift @ARGV;
    } else {
        if ($cmd) {
            push $args, $arg;
        } else {
            $cmd = $arg;
        }
    }
}

pod2usage(verbose => 2, noperldoc => 1, exitval => 0) unless $cmd;

my $replace_map = +{
    yyyy => (localtime(time))[5] + 1900,
    author => $author,
};

my $cmd_map = +{
    dump => sub {
        my $args = shift;

        for my $lic_name (@$args) {
            open my $fh, "< $LIC_TXT_DIR_PATH/$lic_name.txt" or die "no such a license: $lic_name";

            my @lines = ();
            while (my $line = <$fh>) {
                while ($line =~ /s!(.*?)!(.*?)!/g) {
                    my $original = $1;
                    my $replace_type = $2;

                    if (my $replaced_word = $replace_map->{$replace_type}) {
                        $line =~ s/s!.*?!$replace_type!/$replaced_word/;
                    } else {
                        # Some licenses request information except for dates and author name.
                        # In the case, the information is given from stdin.

                        # I don't want to output this sentence to stdout
                        # because I assume usages like 'libo dump mit > LISENCE',
                        # so use warn.
                        warn "hey, input $original : \n";
                        my $stdin = <STDIN>;
                        chomp $stdin;
                        if ($stdin) {
                            $line =~ s/s!\Q$original\E!$replace_type!/$stdin/;
                        } else {
                            $line =~ s/s!\Q$original\E!$replace_type!/$original/;
                        }
                    }
                }
                push @lines, $line;
            }

            print @lines;
            close $fh;
            print "-" x 80, "\n" if scalar @$args > 1 && $lic_name ne $args->[-1];
        }
    },
    list => sub {
        print "$_\n" for map { basename($_, ".txt") } glob "$LIC_TXT_DIR_PATH/*";
    },
    search => sub {
        my $args = shift;
        for my $lic_file_name (map { basename($_, ".txt") } glob "$LIC_TXT_DIR_PATH/*") {
            for my $str (@$args) {
                if ($lic_file_name =~ /$str/i) {
                    print "$lic_file_name\n";
                    last;
                }
            }
        }
    },
    version => sub {
        print "version $VERSION\n";
    },
    help => sub {
        pod2usage(verbose => 2, noperldoc => 1, exitval => 0);
    },
};

unless (exists $cmd_map->{$cmd}) {
    pod2usage(
        message => "Command not found\n",
        verbose => 2,
        noperldoc => 1,
        exitval => 1
    );
}

$cmd_map->{$cmd}($args);

__END__

=head1 NAME

  libo -- short for 'license boilerplates'
  Enable to make license texts easily

=head1 SYNOPSIS

  libo <command>

  Commands:
      dump <license_name1> [license_name2 ...] [--author <name>]  Write boilerplate(s)
                                                                  --author is used for license text. If empty, git user name is used.
      list                                                        List available boilerplates
      search <string1> [stirng2 ...]                              Search for available boilerplates with string(s)
      version                                                     Display current version of this script
      help                                                        Display help of this script

=cut
