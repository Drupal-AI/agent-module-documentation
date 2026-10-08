<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure

Config object `auto_login_url.settings` (schema in `config/schema/auto_login_url.schema.yml`).
Edit at `/admin/people/autologinurl` (route `auto_login_url.settings`) or via drush.

| Key | Default | Meaning |
|---|---|---|
| `secret` | `''` | HMAC secret; auto-generated (`random_bytes(48)` base64) on first use if empty. Blank it to invalidate all URLs. |
| `expiration` | `2592000` | Global token lifetime in seconds (30 days). Per-URL override via `custom_expiration`. |
| `delete` | `false` | Global single-use: delete the record after first successful login. Per-URL override via `one_time_use`. |
| `token_length` | `64` | Characters of the HMAC used as the URL token (8–128). |
| `validate_ip_address` | `false` | If TRUE, a URL only works from the IP that created it. |
| `enable_usage_analytics` | `true` | Log each use into `auto_login_url_usage` (pruned to 6 months by cron). |
| `max_urls_per_user_per_hour` | `10` | Per-user creation rate limit (State-backed, window 3600s). |

```bash
ddev drush config:set auto_login_url.settings expiration 3600 -y      # 1-hour default
ddev drush config:set auto_login_url.settings delete 1 -y             # global single-use
ddev drush config:set auto_login_url.settings validate_ip_address 1 -y
```

## Admin / reporting routes (all require `administer auto login url`)

| Route | Path | Purpose |
|---|---|---|
| `auto_login_url.settings` | `/admin/people/autologinurl` | settings form |
| `auto_login_url.generate` | `/admin/people/autologinurl/generate` | mint a URL from the UI |
| `auto_login_url.manage` | `/admin/people/autologinurl/manage` | list URLs |
| `auto_login_url.view` | `/admin/people/autologinurl/view/{id}` | view one URL |
| `auto_login_url.delete` | `/admin/people/autologinurl/delete/{id}` | delete one URL |
| `auto_login_url.bulk_operations` | `/admin/people/autologinurl/bulk-delete` | delete expired |
| `auto_login_url.usage` | `/admin/people/autologinurl/usage` | usage analytics |
| `auto_login_url.health_check` | `/admin/reports/auto-login-url/health` | operational health check |

The public login route `auto_login_url.login` (`/autologinurl/{uid}/{hash}`) is `_access: TRUE` +
`no_cache: TRUE` — it is meant to be hit unauthenticated; the token is the credential.
