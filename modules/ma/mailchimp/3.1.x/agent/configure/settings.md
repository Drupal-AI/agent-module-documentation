# Settings & authentication

Config object `mailchimp.settings` (schema `config/schema/mailchimp.schema.yml`). UI at
`/admin/config/services/mailchimp` (route `mailchimp.admin`, permission `administer mailchimp`);
OAuth setup at `/admin/config/services/mailchimp/oauth` (route `mailchimp.admin.oauth`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Mailchimp API key (when not using OAuth). |
| `use_oauth` | bool | `TRUE` | Authenticate via OAuth instead of a stored API key. |
| `domain` | string | `''` | Website domain used for authentication / connected sites. |
| `api_timeout` | int | `10` | API request timeout (seconds). |
| `api_classname` | string | `Mailchimp\Mailchimp` | API client class used by `ClientFactory`. |
| `cron` | bool | `FALSE` | Queue subscription operations for processing on cron. |
| `batch_limit` | int | `100` | Max operations processed per batch/cron run. |
| `test_mode` | bool | `FALSE` | Simulate sends without live API calls (dev/testing). |
| `enable_connected` / `connected_id` / `connected_paths` | – | Mailchimp Connected Sites linkage. |
| `webhook_hash` | string | – | Secret hash validating incoming `/mailchimp/webhook/{hash}` calls. |
| `optin_check_email_msg` | label | 'Please check your email…' | Message shown when double opt-in is triggered. |

Auth notes:
- Prefer OAuth (`use_oauth: TRUE`) so no long-lived API key is stored; complete the flow on
  the OAuth settings form (`MailchimpOAuthController::getAccessToken`).
- With an API key, the datacenter suffix (e.g. `-us13`) selects the region automatically.
- Store secrets in an environment variable / Key entity rather than committing them.

Read/write with `drush config:get mailchimp.settings` / `drush config:set`.
