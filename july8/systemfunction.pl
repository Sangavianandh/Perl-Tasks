#!/usr/bin/perl
$file="ls -l";
#system function executes and returns
system( $file);
#execute function execte the command and not return 
exec("ls -l");
#after the execute function  following statement will not be executed
print "Hii sangvai\n";
print "welcome";
