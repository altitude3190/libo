#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Pod::Usage qw/pod2usage/;
use File::Basename qw/basename/;

my $VERSION = '1.0.0';
my $LIC_TXT_DIR_PATH= './boilerplates';

my ($cmd, @args) = @ARGV;
pod2usage(verbose => 2, noperldoc => 1, exitval => 0) unless $cmd;

my $CMD_MAP = +{
    dump => sub {
        my $args = shift;

        for my $lic_name (@$args) {

            open my $fh, "< $LIC_TXT_DIR_PATH/$lic_name.txt" or die "no such a license: $lic_name";

            while (my $line = <$fh>) {
                chomp $line;
                print "$line\n";
            }

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

unless (exists $CMD_MAP->{$cmd}) {
    pod2usage(
        message => "Command not found\n",
        verbose => 2,
        noperldoc => 1,
        exitval => 1
    );
}

$CMD_MAP->{$cmd}(\@args);

__END__

=head1 NAME

  libo -- Easy access to license boilerplates

=head1 SYNOPSIS

  libo <command>

  Commands:
      dump <name1> [name2 ...]         Write boilerplate(s)
      list                             List available boilerplates
      search <string1> [stirng2 ...]   Search for available boilerplates with string(s)
      version                          Display current version of this script
      help                             Display help of this script

=cut
