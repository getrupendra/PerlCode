#!/usr/perl 
use POSIX; # for ceil and floor function
use Data::Dumper;
# use warnings ;
use 5.010; #for 'say' 
use Fcntl qw(SEEK_SET); 

say "#" x 50 ; 

{ 

	$here_doc = <<"EOF";

It is perl tutorial code document. 
This is the syntax for here document and it will continue
until it encounters a EOF in the first line.
This is case of double quote so variable value will be 
interpolated. For example value of process id is  = $$

EOF
	print "here document is defined " if defined($here_doc); # print foreach @here_doc ;
	printf ("\nthe size of string : %d \n" , length $here_doc ) ; # printf ("\nthe size of array: %d \n" , scalar  @here_doc ) ; 
	# print "";
}


#input record separator
{
	#slup mode .... taking a file in scalar 
	local $/ = undef;
	$data = <DATA>;
	$data =~ s/whiskey/Bad thing/gi;
	print $data ;


	other way is take into array 
	@data = <DATA>;
	print foreach @data ;
	# print "";

}


#chomp and chop
{

	#local $/ = ',';
	say qq( the input recored separator : '$/' \n );
	$str = "this , is , not good ,,\n#*,\n\n";
	say qq( string is '$str');

	$ret = chop $str ;
	print $ret  ; #removes the last character of line , returns last character removed
	say qq(chop output  '$str');

	$ret = chomp $str;
	print  $ret ;#removes the new line character or $/ i.e. \n,  returns 1 if removed any $/
	say qq( chomp output'$str');

	# print "";
}


#array 	#array elemen separator  	#print ouput record separator 
{
	@arr = (10,20,30, 0) ; 
	print "\n\n\n". @arr; # 4 
	print "\n", @arr; # 1020300 
	print "\n", sort @arr; #0102030
	print "\n", reverse @arr ; #0302010
	print "\n" , scalar(@arr) ;
	$size = @arr ;
	print "\n", $size ;

	@array1 = qw/This is an array/;
	@array2 = qw/monday
	tuesday
	friday/;

	printf("\nThe array1 has %d elements",scalar @array1 ) ;
	say qq(The 2nd array1 elements:  $array1[1] ) ;

	printf("\nThe array2 has %d elements",scalar @array2 ) ;
	say qq(The 2nd array2 elements:  $array2[1] ) ;

	pop(@array1);
	print " \@array1  = @array1\n";

	unshift( @array1 , "hi"); #opposite of push
	print " \@array1  = @array1\n";
	print "@array1[0..2]" ;




	#remove one element from the beginning of the array.
	$var =  shift(@array2);
	print " \@array2  = @array2\n";
	say $var ;
	print " \@array2  = @array2\n";

	local $" = '^'; #array elemen separator 
	local $\ = 'NEW_LINE' ;#print ouput record separator 
	@list = (10,20,30,40,50,60,70,80)[1,5..7];

	print "Value of list = @list\n";

	@list2 = (100,200,30) ;
	@merged_list = ( @list, @list2);
	print "@merged_list" ;

	# print "";
}

#STDIN
{
	print "Your name ? \n";
	$name = <STDIN>;
	print "\n". $name ; 
	# print "";
}
#hashes
{
	%translate = (1=>'one', 2 => 'two', '3' => 'threee') ;
	$translate{4} = 'four';
	@translate{5, 6} = ('five', 'six');

	print "\nscalar: " . $translate{1} . "\t", $translate{2},"\t", $translate{3} ,"\t", $translate{4}, "\t", $translate{5} ,"\t", $translate{6} ,  "\n";
	print "@translate{'1','2', 3 , '4', 5 , 6  } ";
	print  keys %translate ;
	print  "\n" .keys %translate ;
	print Dumper(%translate) 
	# print "";
# }

#strings
{
	$string = "Hi I am a computer professional " ;
	say qq(String is '$string');
	say (length $string) ; 
	 say (uc $string ) ;
	 say  lc $string ;
	 say  ucfirst $string  ;
	chomp $string ; 
	say qq ( chomp ret value : '$string' );
	chop($string);
	say qq(chop: '$string' ) ;
	print substr( $string , 10 , 8) ; #get 
	substr( $string , 10 , 8) = 'software' ; #assignment
	say qq(new string : '$string') ; 
	# print "";}

#function
{

	sub  func
	{
		push (@_ , 5 );
		while( @_) {
		 my $var = pop @_ ; 
		say $var ;
		}
			
	}

	func(10,20) ;
	print "$var";
	# print "";
}

# print $ENV{'PATH'};
# print Dumper ( %INC);


#constant literals 
{

	print "File name ". __FILE__ . "\n";
	print "Line Number " . __LINE__ ."\n";
	print "Package " . __PACKAGE__ ."\n";

	#they can not be interpolated
	print "__FILE__ __LINE__ __PACKAGE__\n";
	# print "";
}

#file read 
{
	my($buffer) = "";


	my($buffer , $buffer2) = ("", "");
	open(FILE, "./file.txt") or die("Error reading file, stopped");
	while(read(FILE, $buffer, 10 , 2 ) ) #reads 10 bytes each time leaving 2 offset at beginning 
	{
	   print qq("$buffer"\n);
	}
	seek (FILE , 10 ,SEEK_SET) ; #jumped to 10th byte from start
	seek (FILE , 10 ,SEEK_CUR) ; #jumped to 10th byte from current position
	read(FILE, $buffer2, 10 ); #read 10bytes from current position
	say $buffer2;
	say tell FILE ;
	say SEEK_CUR ;
	say SEEK_END ;
	say truncate FILE, 10; ##not running 

	print truncate( FILE , 10 );



	close(FILE);
	# print "";

}

#loop jumps 


local @arr =  (1,2,3,4,5,6,7,8,9);
foreach (@arr)
{
	print $_ if( $_  == 1 );
	next if ($_ == 2 || $_ == 3);
	local $var = 1 ;

	print and last if ($_ == 5 );

	# print "";



}

#my and local, state our 
{
	use feature 'state';
	our $package_var ; #our used for packge variable

	$var = 4;
	print $var, "\n";
	&hello;
	print $var, "\n";

	sub hello {
		 local $var = 10; # while 'my' cannot be accessed by gogo , 'local' gives temporary vale for  'global' var
		 print $var, "\n";
		 &gogo; # calling subroutine gogo
		 print $var, "\n";
	}
	sub gogo {
		 $var ++;
	}

	sub PrintCount{
	   state $count = 0; # initial value for static variable

	   print "Value of counter is $count\n";
	   $count++;
	}

	for (1..5){
	   PrintCount();
	}

	# print "";
}

##references
{
	$hash_ref = {				#curly bracket for anonymous hash
		Adam  => 'Eve',
		Clyde => 'Bonnie',
	};
	print Dumper ($hash_ref );  
	foreach $key (keys %$hash_ref){
		say qq( $key , $$hash_ref{$key} ) ; #stattement contains $$ to get  scalar value
	}
	undef $hash_ref ;



	$arr_ref = [				#square bracket for anonymous array
		Adam  , 'Eve',Clyde , 'Bonnie',
	];
	print Dumper ($arr_ref );  
	say  foreach (@$arr_ref);
	undef $arr_ref ;



	derefrencing 
	%hash_to_ref = (
		'1'  => 'one',
		'2' => 'two'
	);
	$hash_ref = \%hash_to_ref ;

	print %$hash_ref  ;
	print $$hash_ref{1} ;
	print $$hash_ref{2} ;

	Function definition
	sub PrintHash{
	   my (%hash) = @_;
	   
	   foreach $item (%hash){
		  print "Item : $item\n";
	   }
	}
	local %hash = ('name' => 'Tom', 'age' => 19);
	$cref = \&PrintHash;
	&$cref(%hash);

	undef %hash ;

	# print "";

}


#forcing to flush output aafter every print
{
	local $| = 10 ;

	say and sleep(1) foreach( 1..5);
	# print "";
}


#REGEX
while (<DATA>)
{

	$line = $. ;
	# $quo =  $line % 5  ;
	print "\nline $line says: $quo" ;
	if ( $line % 5 == 3 ){  print "$line" ; }    
	if ( $line % 5  == 4 or $line % 5 == 0 ) { print "$line skipped"  ;}  

	
	print if m/whiske?y/i ; #0 or 1 e , case insensitive
	print if m/so+n/; # 1 or more o 
	print if   /$digit[^\s]\.[0-9]/; #digit, \d no space , '.', one or more digit 
	print if m#^(rose|hello|hi)$#;  #only that world
	print if m#h(ello|i)#;  #strings with hi or hello
	print if /\bperl\b/;   
	print if /^(a.)+$/ ;
	 print if  /([Rr])uby\son\s\1ails/ ; #backreference  
	 print $got ;

	say  qq(the first word is "$1" and last word is "$2") if (/^(\w+)\s+(\W+)$/) ;
	say qq(the first word is "$1" and last word is "$2") if (/^(\w)\s+(\w)\s*$/) ;
	
	if( /day\s*(...).*(\d{1}).*(\d{4})\s*/){
		say  qq(prematch $`);
		#say $PREMATCH ;
		say  qq(postmatch $');
		# say $POSTMATCH ;
		say qq(last match  $+)	; #last matched bracket 
		say qq (first match $1 );
		say qq (second match $2) ;
		say qq (third match $3) ;

	}
	
	
}

# $str = " cat jumps over\n the mat" ;
# ($match) = ($str =~ /\A(.*?)/ );
# print $match ;

say '_'x 50;

__END__
whiskeey
--whiskeY

--son
sn

perl
-- perl 

114 .243
--114.243

rose and hi 
rose
shello

Ruby on rails

23 236 6562

hi I am a diligent man 
today isS Friday Aug 4, 2014 IST
FIRST_WORD    \" 
F     L 
a3a3a6a7