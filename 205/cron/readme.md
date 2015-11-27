##CRON is awesome

Runs every hour to check if any EC2 instances are running. You need to have AWS CLI installed.   
Displays notification if there are instances running.   

To schedule a notification about yer AWS status, write a cron job in cron-file-aws.txt   

Then run:   
`crontab cron-file-aws.txt`   

This will start the deamon. Everytime you run this command, the crontab will be replaced by the new data in the cron-file.txt
   
Put everything on one line   
Make sure to hit "return" so the file ends with a new line. 
