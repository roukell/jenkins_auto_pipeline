CRUMB=$(curl "http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)" --cookie-jar cookies.txt --user admin:$ADMIN_PASSWORD)
//The cookies.txt file will contain the session cookie and will have the following format:
// cookies.txt start
# Netscape HTTP Cookie File
# https://curl.se/docs/http-cookies.html
# This file was generated by libcurl! Edit at your own risk.

#HttpOnly_localhost     FALSE   /       FALSE   0       JSESSIONID.974c6e10     node01atelbjgy45rs16spc4gkpz8sk3.node0
// cookies.txt end

curl 'http://localhost:8080/user/admin/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken' --user admin:$ADMIN_PASSWORD --data 'newTokenName=ec2-token' --cookie cookies.txt -H $CRUMB 
// example output
{"status":"ok","data":{"tokenName":"kb-token","tokenUuid":"f2319160-f159-4397-9aaf-a9ec6ccb5931","tokenValue":"119ba16ffcd0ab29676e99ccffaf5c433a"}}

//-----WORKING SCRIPT-----
sed -i 's/^Environment="JAVA_OPTS=.*/Environment="JAVA_OPTS=-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"/' /usr/lib/systemd/system/jenkins.service
ADMIN_PASSWORD=$(cat /var/jenkins_home/secrets/initialAdminPassword)
CRUMB=$(curl "http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)" --cookie-jar cookies.txt --user admin:$ADMIN_PASSWORD)
ACCESS_TOKEN=$(curl 'http://localhost:8080/user/admin/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken' --user admin:$ADMIN_PASSWORD --data 'newTokenName=ec2-token' --cookie cookies.txt -H $CRUMB | jq -r '.data.tokenValue')
