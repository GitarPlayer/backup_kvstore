# backup_kvstore
A short bash script for backing up the Splunk KV store via API

### Environment vars
- `KV_USER`: Accountname of a splunk user with following capabilities:
1. edit_server
2. list_settings	
3. run_collect
4. run_mcollect
5. list_settings
- `PW`: Splunk secret used by the KV_USER account
- `SPLUNK_URL`: The URL of your SPLUNK server
- `KV_PORT`: The port of your KV store, default set by Splunk is 8089
