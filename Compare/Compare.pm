package Time::Compare;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Time::Compare ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	&new &more &more_eqv &less_eqv
);

our $VERSION = '0.01';

use overload '>'=>\&more,'<'=>\&less,'eq'=>\&eqv,'>='=>\&more_eqv,'<='=>\&less_eqv,'""'=>\&space;
my $TIME;

sub new{
	my ($class,$time,$self);	  
	($class,$time) = @_;
	die "Not defined variable CLASS(new->Time::Compare)" unless $time;
  	&check_syn($time,'new');	
	$self = {};
	bless $self,$class;
	$self->{'TIME'} = $time;	
	($self->{'HH'},$self->{'MM'},$self->{'SS'}) = split /:/,$time;
	return $self;
}

sub more{
	my ($h,$m,$hour,$minute,$left,$right);
	($left,$right) = @_;
  	&check_syn($left->{'TIME'},'more');
	&check_syn($right->{'TIME'},'more');	
	($h,$m) = ($left->{'HH'},$left->{'MM'});
	($hour,$minute) = ($right->{'HH'},$right->{'MM'});
	return 1	if $h>$hour;
	return 1 if(($h eq $hour) && ($m>$minute));
	return undef;
}

sub less{
	my ($h,$m,$hour,$minute,$left,$right);
	($left,$right) = @_;
  	&check_syn($left->{'TIME'},'less');
	&check_syn($right->{'TIME'},'less');	
	($h,$m) = ($left->{'HH'},$left->{'MM'});
	($hour,$minute) = ($right->{HH},$right->{MM});

	return 1 if $h<$hour;
	return 1 if (($h eq $hour) && ($m<$minute));
	return undef;
}

sub less_eqv{
	my ($h,$m,$hour,$minute,$left,$right);
	($left,$right) = @_;
  	&check_syn($left->{'TIME'},'less_eqv');
	&check_syn($right->{'TIME'},'less_eqv');	
	($h,$m) = ($left->{'HH'},$left->{'MM'});
	($hour,$minute) = ($right->{HH},$right->{MM});

	return 1 if $h<$hour;
	return 1 if (($h eq $hour) && ($m < $minute));
	return 1	if (($h eq $hour) && ($m eq $minute));
	return undef;
}

sub more_eqv{
	my($h,$m,$hour,$minute,$left,$right);	  #>=
	($left,$right) = @_;	
	&check_syn($left->{'TIME'},'more_eqv');	
	&check_syn($right->{'TIME'},'more_eqv');
  	($h,$m) = ($left->{HH},$left->{MM});
	($hour,$minute) = ($right->{HH},$right->{MM});
	
	return 1 if $h > $hour;
	return 1	if (($h eq $hour) && ($m eq $minute));
	return 1 if (($h eq $hour) && ($m > $minute));
	return 0;
}

sub space{
}

sub eqv{
	my($left,$right,$h,$m,$s,$hour,$minute,$sec);
	($left,$right) = @_;	
	&check_syn($left->{'TIME'},'more_eqv');	
	&check_syn($right->{'TIME'},'more_eqv');
  	($h,$m,$s) = ($left->{HH},$left->{MM},$left->{SS});
	($hour,$minute,$sec) = ($right->{HH},$right->{MM},$right->{SS});
	return 1 if (($h eq $hour) && ($m eq $minute) && ($s eq $sec));
	return undef;
}

sub check_syn{
	my($str,$func);	  
	($str,$func) = @_;
	die "Wrong format time data - You have entered $str(Time::Compare->$func).Right format is HH:MM:SS"
				unless $str =~ /\d?\d:\d\d:\d\d/ ;
	my($h,$m,$s) = split /:/,$str;			
	die "HH:MM:SS values must be less or evq 60(Time::Compare->$func)"
				if (($h>60) || ($m>60) || ($s>60));
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Time::Compare - Perl extension for comparing time
Test it for simple usage

=head1 SYNOPSIS

  use Time::Compare;
 	$tm1 = Time::Compare->new('10:00:00');
	$tm2 = Time::Compare->new('11:00:00');
	if ($tm1 > $tm2) ...

=head1 ABSTRACT

  
=head1 DESCRIPTION

This module you can use for simple comparing time
Only create two objects for comparing and work with them
Operations with these objects - >,<,eq,=>,<=
Time format for such objects is HH:MM:SS - you can use such format if you work with MySQL time format

=head2 EXPORT

You can get time digits in vars $time->{HH} - hours
											$time->{MM} - minutes,
											$time->{SS} - seconds
											$time->{TIME} - time	

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.


If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

yak <lt>yak@nm.ru<gt>

=head1 COPYRIGHT AND LICENSE

Copyright yak 2004 by yak

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
