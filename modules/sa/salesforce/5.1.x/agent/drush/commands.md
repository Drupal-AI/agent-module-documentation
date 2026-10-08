# Drush commands (`salesforce:*`)

Registered via `src/Commands/SalesforceCommands*` (`drush.services.yml`). All require a
working Salesforce authorization except where noted.

| Command | Purpose |
|---|---|
| `salesforce:rest-version` | Show/select the REST API version in use. |
| `salesforce:list-objects` | List Salesforce sObject types. |
| `salesforce:describe-fields` | List fields of an object. |
| `salesforce:describe-object-deprecated` | (deprecated) describe an object. |
| `salesforce:describe-record-types` | List record types for an object. |
| `salesforce:describe-metadata` | Describe object metadata. |
| `salesforce:dump-object` | Dump an object's full describe. |
| `salesforce:list-resources` | List available REST resources. |
| `salesforce:read-object` | Read a record by Id. |
| `salesforce:create-object` | Create a record. |
| `salesforce:query-object` | Run a SOQL query (by object/conditions). |
| `salesforce:execute-query` | Execute a raw SOQL query string. |
| `salesforce:list-providers` | List configured auth providers (`salesforce_auth`). |
| `salesforce:refresh-token` | Refresh the OAuth token for a provider. |
| `salesforce:revoke-token` | Revoke the stored token for a provider. |

Examples:
```bash
drush salesforce:list-providers
drush salesforce:list-objects
drush salesforce:query-object Contact
drush salesforce:execute-query "SELECT Id, Name FROM Contact LIMIT 5"
drush salesforce:refresh-token my_auth
```

`salesforce:list-providers` and `salesforce:rest-version` are the safest to run without a
live query; most others hit the Salesforce API.
