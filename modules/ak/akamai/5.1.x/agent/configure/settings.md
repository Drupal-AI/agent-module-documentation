# Configure Akamai

All settings live in one config object: **`akamai.settings`** (schema in
`config/schema/akamai.schema.yml`). UI: `/admin/config/akamai/config`
(route `akamai.settings`, form `Drupal\akamai\Form\ConfigForm`, permission `administer akamai`).

## Keys (with install defaults)

| Key | Default | Meaning |
|---|---|---|
| `version` | `v3` | CCU client plugin id (`akamai_client`). Only `v3` ships. |
| `disabled` | `FALSE` | **Killswitch** — `TRUE` disables all calls to Akamai. |
| `storage_method` | `file` | `file` = read credentials from an `.edgerc` file; `key` = use the Key module. |
| `rest_api_url` | placeholder | CCU API host, e.g. `https://xxxx.purge.akamaiapis.net/` (used with `key` storage). |
| `client_token` / `client_secret` / `access_token` | `''` | With `storage_method: key` these hold **Key entity IDs** (a `<select>` of keys), not raw secrets. |
| `edgerc_path` | `''` | Path to the `.edgerc` file (used with `file` storage). |
| `edgerc_section` | `default` | Section within the `.edgerc` file. |
| `basepath` | `NULL` | Site FQDN prefix for all cache clears (Akamai indexes full URIs), e.g. `http://www.example.com`. |
| `timeout` | `5` | API request timeout, seconds (integer). |
| `domain` | `{production: TRUE, staging: FALSE}` | Which Akamai network to target. Exactly one is TRUE. |
| `action_v3` | `{delete: TRUE, invalidate: FALSE}` | CCUv3 purge action: `delete` (evict) vs `invalidate` (mark stale). |
| `log_requests` | `FALSE` | Log all requests/responses to the `akamai` logger channel. |
| `edge_cache_tag_header` | `FALSE` | Emit an `Edge-Cache-Tag` response header (cache tags → Akamai). |
| `edge_cache_tag_header_blacklist` | (unset) | Sequence of tag prefixes stripped from that header. |
| `purge_urls_with_hostname` | `FALSE` | Send base path as the Fast Purge `hostname` request member. |
| `edgescape_support` | `FALSE` | Enable Edgescape geolocation processing + `[akamai:edgescape:*]` token. |

Note: in the form, `domain` is a single `<select>` (`production`/`staging`); on save it is
converted to the boolean map above. Same idea for the action.

## Credentials

Two mutually exclusive paths, chosen by `storage_method`:

- **`.edgerc` file** (`file`): set `edgerc_path` + `edgerc_section`. File format is the standard
  Akamai EdgeGrid ini (`host`, `access_token`, `client_token`, `client_secret`).
- **Key module** (`key`): pick a Key entity for each of access/client token and client secret,
  plus `rest_api_url`. The `key` option only appears in the UI when the `key` module is enabled.

## Change settings via drush (grounding for evals)

```bash
# Kill switch on:
drush config:set akamai.settings disabled 1 -y
# Target the staging network instead of production:
drush config:set akamai.settings domain.staging 1 -y
drush config:set akamai.settings domain.production 0 -y
# Emit the Edge-Cache-Tag header:
drush config:set akamai.settings edge_cache_tag_header 1 -y
# Read a value:
drush config:get akamai.settings domain
```

With Purge instead of this form: enable `purge_ui`, enable the **Akamai** purger at
`/admin/config/development/performance/purge`, and configure credentials via that UI.
