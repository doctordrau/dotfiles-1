#!/usr/bin/perl

my $ssh="/usr/bin/ssh";
my $mosh="/usr/bin/mosh";

my $host;
my $unsupported=0;
for (my $i=0; $i <= $#ARGV; $i++) {
	if ($ARGV[$i] =~ /^-/) { 
		$ssh .= " \"$ARGV[$i]\"";
		if ( grep { /$ARGV[$i]/ } ("-A","-C","-D","-e","-f","-g","-L","-M","-N","-n","-R","-V","-W","-w","-X","-Y") ) {
			print "mosh does not support ssh's \"$ARGV[$i]\" option.\n";
			$unsupported=1;
		}
		if ( grep { /$ARGV[$i]/ } ("-b","-c","-D","-e","-F","-I","-i","-L","-l","-m","-O","-o","-p","-R","-S","-W","-w") ) {
			$ssh .= " \"$ARGV[$i+1]\"";
			$i++;
		}
	} else {
		$host=$ARGV[$i]; 
	}
}

my $ret = system("$mosh --ssh='$ssh' $host"); 

if ( $unsupported || $ret == 32512 ) {
	print "Got bad exit code from mosh, falling back to ssh\n";
	exec("$ssh $host");
}
