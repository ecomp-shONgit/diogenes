#!/usr/bin/perl -w
use strict;
use Diogenes::Base;
use Diogenes::Browser;
use Diogenes::Search;
use Diogenes::Indexed;
my ($a, $aw, $b, $bw, $c, $cw, $d) = ('', '', '', '', '', '', '');
format COLS =
@<<<<<@<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$a, $b, $c, $d
.
format AUTHS =
@<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$a,     $b
~        ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        $b
.
format WORDS =
@<<< @<<<<<<<<<<<<<<<<<< @<<< @<<<<<<<<<<<<<<<<< @<<< @<<<<<<<<<<<<<<<<<<
$a, $aw,           $b, $bw,          $c, $cw
.
# my $q = new Diogenes::Base(-type=>"tlg", -encoding=>"UTF-8", -output_format=>"html");
my $q = new Diogenes::Base(-type=>"tlg", -encoding=>"UTF-8");


my %auths = %{ $q->select_authors('select_all' => 1) };
local $~ = 'AUTHS';
print "\n";
my %req;
for my $k (keys %auths)
{


  $a = "$k)";
  $b = "$auths{$k}";
  #write;
  #$req{author_nums} = [split /[\s,]+/, $k];
  #my @neww = $q->select_authors(%req);
  #print "\nSearching within the following texts: \n\n";
  #print "$neww[$_] \n" for (0 .. $#neww);

}
my $browser = new Diogenes::Browser(-type=>"tlg", -encoding=>"UTF-8");
#my $browser = new Diogenes::Browser(-type=>"tlg", -encoding=>"UTF-8");
#$browser->browse_works (%auths);
my %works;
foreach my $auth (sort keys %auths)
{
    print "$auth;$auths{$auth};;\n";
    my %all_works = $browser->browse_works ($auth);
    $browser->{browser_multiple} = 10000000000;
    my @target = (0) x 1000;
    foreach my $work ( sort keys %all_works ){
        print "$auth;$auths{$auth};$work;$all_works{$work}\n";
        $browser->seek_passage ($auth, $work, @target);
        $browser->begin_boilerplate;
        #if (grep {m/^0$/ or m/^$/} @target) {
        my $goone = 1;
        while($goone == 1){
          if( $browser->browse_forward ){
            $goone = 1;
          }
          else{
            $goone = 0;
          }
        }

            #$browser->browse_forward;
        #} else {
        #    $browser->browse_half_backward;
        #}
        $browser->end_boilerplate;
        print "_______________________________\n";
    }
    #print "  $_: $all_works{$_}\n" foreach (sort keys %all_works);

      #$works{$auth} = ($inp eq '') ? 'all' : [split /[\s,]+/, $inp];

}
# $q->do_search("BAALA");
