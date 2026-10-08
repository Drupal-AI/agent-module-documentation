<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CDNetworks Purge — configuration, routes, permissions

## Install / enable

Requires `key` and `purge` (composer: `drupal/key:^1.0`, `drupal/purge:^3.0`). Enable
`cdnetworks_purge`; then in Purge's config add the **CDNetworks Purger** as a purger, and enable a
queuer (Purge ships `purge_queuer_coretags`; use `purge_queuer_url` for URL queueing). For tag
headers to be emitted, also turn on the `cachetag` setting.

## Config object: `cdnetworks_purge.settings`

Single config object edited by `Form\ConfigForm` (`getFormId()` = `cdnetworks_purge_settings_form`).
Schema: `config/schema/cdnetworks_purge.schema.yml`; install defaults:
`config/install/cdnetworks_purge.settings.yml`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `base_uri` | string | `https://api.cdnetworks.com` | CDNetworks REST base URI, no trailing slash. |
| `username` | string | `''` | **Key entity ID** for the CDNetworks username (form uses `#type: key_select`). |
| `apikey` | string | `''` | **Key entity ID** for the CDNetworks API key (`#type: key_select`). |
| `cdn_url` | string | `''` | Accelerated CDNetworks domain (no scheme). Queued URL hosts are rewritten to this. |
| `cachetag` | integer | `0` | Toggles the `tag` response header (tags-header plugin `isEnabled()`). |
| `ideal_conditions_limit` | integer | `100` | Purge `getIdealConditionsLimit()` value. |
| `verbose_log` | integer | `0` | Enables extra info-level logging of purges. |

Note: `username` and `apikey` hold **Key entity machine names**, not the secrets themselves. The
client resolves them at runtime via `@key.repository` (`getKeyValue()`), so the actual credentials
are stored/managed by the Key module (e.g. an env-provider key), not in this config object or its
export.

`ConfigForm::submitForm()` writes all seven keys. Install update `cdnetworks_purge_update_8201`
clears stale form artifacts (`submit`, `form_build_id`, `form_token`, `form_id`, `op`) that older
versions accidentally saved.

## Routes & permissions (`*.routing.yml`, `*.permissions.yml`)

- `cdnetworks_purge.settings` — `/admin/config/development/cdnetworks_purge` — `ConfigForm` —
  requires **`administer cdnetworks_purge configuration`** (`restrict access: true`).
- `cdnetworks_purge.purge` — `/admin/config/development/cdnetworks_purge/purge` — `CachePurgeForm` —
  requires **`perform cdnetworks_purge manual purge`** (`restrict access: true`).

Both are standard `_form` routes (automatic CSRF token on submit). Local tasks are defined under
the core Performance route (`*.links.task.yml`).

## Manual purge form (`Form\CachePurgeForm`)

Textareas for URLs, regex URLs, and tags (one per line, split on CR/LF). URL/Directory action
radios map to `default` / `delete` / `expire`. On submit it calls the client's `purgeUrl()`,
`purgeRegex()`, and per-line `purgeTag()`, showing a messenger message per success. URLs ending in
`/` are treated as directory (wildcard) purges.

## Status report

`cdnetworks_purge_requirements('runtime')` (in `.install`) calls
`cdnetworks_purge.client::validateConfiguration()` and raises a `REQUIREMENT_ERROR` linking to the
settings form when `username`, `apiKey`, or `baseUri` are empty.

## Drush

`cdnetworks_purge.drush.inc` declares `cdnetworks-purge-purge-urls` via the **Drupal 8-era**
`hook_drush_command()`, which modern Drush (9+) no longer loads, and its callback calls a
non-existent `$client->flush()` method. Treat it as legacy/non-functional; use the manual form or
the `cdnetworks_purge.client` service instead.
