# -k do not validy certs, -s silent, -o output to devnull , -w --write-out the status code
if [[ http_code=$(curl -k -s -o /dev/null -u $KV_USER:$PW -X POST https://$SPLUNK_URL:$KV_PORT/services/kvstore/backup/create -w "%{http_code}") -eq 200 ]]
then
  # sed only print backupRestoreStatus and remove any whitespaces
  kvstore_status=$(curl -k -s -u $KV_USER:$PW -X GET https://$SPLUNK_URL:$KV_PORT/services/kvstore/status | sed -r -n 's!<s:key name="backupRestoreStatus">([[:alpha:]]*)(</s:key>)!\1!p' | sed 's/^[[:space:]]*//g' )
  if [[ $kvstore_status == 'Busy' ]]
  then
    echo "Backup is in progress, the status is $kvstore_status. This means our job here is done."
  else
    >&2 echo "Something went wrong, curl returned the following: $kvstore_status"
  fi
else
  >&2 echo "HTTP status code returned was $http_code"
fi