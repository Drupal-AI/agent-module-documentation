<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — azure_cdn_purge.settings

All configuration lives in one config object, **`azure_cdn_purge.settings`**, written by
`AzureCdnSettingsForm` (`src/Form/AzureCdnSettingsForm.php`, form id `azure_cdn_admin_settings`,
route `azure_cdn_purge.admin_config_form` at `/admin/config/services/azure`, permission
`administer azure cdn purge`). The module ships **no `config/install/` default and no
`config/schema/`** — keys exist only after the form is first saved.

## Install / enable

1. `drupal/purge` is required (`composer require drupal/azure_cdn_purge` pulls `drupal/purge ^3.2`);
   `ddev drush en azure_cdn_purge -y`.
2. Enable Purge UI (`purge_ui`) to add the purger, and optionally Purge's Cron processor for
   cron-driven purging.
3. Grant `administer azure cdn purge` to the operator role.
4. At Purge UI (`/admin/config/development/performance/purge`) add the **Azure CDN** purger and
   enable the **Path queuer** + a processor (Cron or the module's `azure_processor`).

## Config keys (all set by `submitForm()`)

Purge settings fieldset:
- `endpoint_type` — select, required. `endpoints` (Azure CDN) or `afdEndpoints` (Azure Front Door).
  Used verbatim in the REST URL path segment.
- `devel` — checkbox, "Enable debug mode". Gates the debug logging in the purger (see
  [../api/purger.md](../api/purger.md)).
- `chunk_size` — number, required. Max invalidations per REST request; `AzurePurger::invalidate()`
  passes it to `array_chunk()`.
- `chunk_delay` — number, required. Seconds `sleep()`ed between chunks to dodge Azure rate limits.

Authentication fieldset (Azure AD OAuth 2.0 client-credentials):
- `tenant_id` — required. Directory (tenant) id; forms the `login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token` URL.
- `client_id` — required. App registration (application) id.
- `scope` — required. Resource identifier + `.default` (e.g. `https://management.azure.com/.default`).
- `client_secret` — required. App registration client secret.

Purge endpoint (URI params) fieldset:
- `endpoint_name` — required. CDN/Front Door endpoint name (globally unique).
- `profile_name` — required. CDN profile name (unique in the resource group).
- `resource_group_name` — required. Azure resource group.
- `subscription_id` — required. Azure subscription id.
- `api_version` — required. REST API version string.

## Notes

- The `chunk_size` / `chunk_delay` fields are `textfield`s rendered with an HTML5 `number` type
  attribute; there is no numeric validation server-side beyond `#maxlength => 4`.
- Azure requires the app registration to hold the **Contributor** role on the CDN/Front Door
  profile for the purge action to succeed (see README / project description).
- The **manual purge** form (`AzureCdnPurgeForm`, route `azure_cdn_purge.purge_form`) declares
  `getEditableConfigNames()` = `azure_cdn_purge.purge_settings`, but that object is never read or
  written — the manual form has no persisted config; it only dispatches invalidations. See
  [../api/purger.md](../api/purger.md).
