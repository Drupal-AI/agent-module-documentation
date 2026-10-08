<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Single config object **`flickr_integration_suite.settings`** (schema in
`config/schema/flickr_integration_suite.schema.yml`, all keys typed `string`). Edited through
`FlickrIntegrationSuiteSettingsForm` at `/admin/config/system/flickr-integration-suite`
(route `flickr_integration_suite.settings_form`, permission `administer site configuration`,
standard `ConfigFormBase` so CSRF token is automatic).

| Key | Form element | Default (install) | Meaning |
| --- | --- | --- | --- |
| `api_endpoint` | textfield, required | `https://api.flickr.com/services/rest/` | Base Flickr REST endpoint the service GETs. Admin-editable; no scheme validation, but defaults to HTTPS. |
| `api_key` | `key_select`, required | `''` | **Machine name of a Key entity** (from the `key` module), not the raw key. Resolved at runtime via `key.repository`. |
| `api_cache_max_age` | select | `86400` (1 day) | Seconds to cache each Flickr response in `cache.default`. `0` = no caching. Options range from 1 minute to 1 day. |

## Notes for agents

- The `api_key` field is a `key_select`, so setting credentials means **first creating a Key
  entity** (`key` module) — e.g. an env-provider key reading `FLICKR_API_KEY` — then selecting it
  here. The raw secret never enters this config object or a config export.
- `hook_update_9101` backfills `api_cache_max_age` to `86400` for sites that predate that key.
- No permissions, routes, or Drush commands beyond this form. The block/field/filter submodules
  read this same config indirectly through the `flickr_integration_suite.api_provider` service;
  they add no config object of their own beyond their plugin/settings schemas.
