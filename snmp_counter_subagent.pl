#!/usr/bin/perl

use NetSNMP::agent (':all');
use NetSNMP::ASN qw(:all);
use NetSNMP::OID;
use feature 'say';

sub hello_handler {
  my ($handler, $registration_info, $request_info, $requests) = @_;
  my $request;
  my %dict;
  my $file = '/usr/share/snmp/counters.conf';
  open(FILE,"<$file") or die "Can't open file";
  while (<FILE>){
     chomp;
     my ($key, $val) = split /,/;
     $dict{$key} = $val;
  }
  close (FILE);

  for($request = $requests; $request; $request = $request->next()) {
     my $oid = $request->getOID();
     if ($request_info->getMode() == MODE_GET) {
            if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) {
              $request->setValue(ASN_COUNTER,time);
            }
            if ($oid > new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) {

              $oid1="$oid";
              my $sep = '.';
              my $oid_index = rindex($oid1, $sep);
              my $value_id  = int(substr($oid1,$oid_index+1)) ;
              $value_id=$value_id-1;
              $counter_value=NULL;
              $br= int($dict{$value_id});
              $counter_value =$br*time;
              $max=2**32-1;
              if ($counter_value > $max) {
                   $counter_value = $counter_value & 0x00000000FFFFFFFF;
              }

             print  "$counter_value\n";
             $request->setValue(ASN_COUNTER,$counter_value);
           }
     }
  }

}
my $rootOID = ".1.3.6.1.4.1.4171.40";
my $regoid = new NetSNMP::OID($rootOID);
my $agent = new NetSNMP::agent();
$agent->register("sub_agent", $regoid,
                 \&hello_handler);