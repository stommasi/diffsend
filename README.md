diffsend
========

This script emails to a specified address a diff report comparing
a specified file to the state it was in the last time the script
was run. By passing a regular expression, diff will only report
on matching lines. If executed as a regular cron job, one can
keep notified about certain kinds of changes made, for example,
to log files. The script uses mutt to send the email, so this
must already be configured properly.

Usage: diffsend.sh \<file\> \<regex to match\> \<email address\>

Example crontab entry for reporting visits to example.com logged
by the Apache httpd server:

	*/15 * * * * ~/bin/diffsend.sh /var/log/httpd/access_log 'example.com' 'user@example.com'
