<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring SearchStax

## Admin routes (from `searchstax.routing.yml`)

| Route | Path | Form | Permission |
|---|---|---|---|
| `searchstax.admin_settings` (the `configure` route) | `/admin/config/search/searchstax` | `SettingsForm` | `administer site configuration` |
| `searchstax.advanced_settings` | `/admin/config/search/searchstax/advanced-settings` | `AdvancedSettingsForm` | `administer site configuration` |
| `searchstax.version_check` | `/admin/config/search/searchstax/version-check` | `VersionCheckForm` | `administer site configuration` |

The module defines **no permissions of its own** — all three forms gate on the core
`administer site configuration` permission.

## The `searchstax.settings` config object

Single config object (`config/install/searchstax.settings.yml`, schema
`config/schema/searchstax.schema.yml`). Keys and install defaults:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `analytics_url` | string | `https://app.searchstax.com` | SearchStudio analytics endpoint base URL. |
| `analytics_key` | string | *(unset)* | Global SearchStax analytics key. |
| `search_specific_analytics_keys` | sequence | *(unset)* | Per-search analytics keys, keyed by search id. |
| `key_id` | string | *(unset)* | Key module entity id holding credentials, when Key is used. |
| `searches_via_searchstudio` | bool | `false` | Re-route live search queries through SearchStudio instead of Solr. |
| `discard_parameters` | sequence | `[highlight, keys, spellcheck]` | Drupal query params ignored when `searches_via_searchstudio` is on. |
| `js_version` | string | `'3'` | Which SearchStudio tracking JS version to load. |
| `eu_cookie_compliance.enabled` | bool | `true` | Integrate tracking with EU Cookie Compliance. |
| `eu_cookie_compliance.category` | string | *(unset)* | Consent category (opt-in-with-categories mode). |
| `flood_protection.enabled` | bool | `false` | Rate-limit search/update requests per IP. |
| `flood_protection.search_limit` | int | `15` | Max search requests per IP per window. |
| `flood_protection.search_window` | int | `10` | Search window, seconds. |
| `flood_protection.update_limit` | int | `50` | Max update requests per IP per window. |
| `flood_protection.update_window` | int | `60` | Update window, seconds. |
| `untracked_roles` | sequence | `[]` | Role ids excluded from analytics tracking. |
| `autocomplete.override_supported_suggesters` | sequence | *(unset)* | Suggester plugin ids to force-treat as supported. |
| `autosuggest_core` | string | *(unset)* | **Deprecated** (1.9.0, removed 2.0.0) — set on the suggester plugin instead. |

Read/write with drush (no UI needed):

```bash
# read one nested key
drush config:get searchstax.settings flood_protection.enabled

# turn on flood protection and tighten the search limit
drush config:set searchstax.settings flood_protection.enabled true -y
drush config:set searchstax.settings flood_protection.search_limit 5 -y

# re-route searches through SearchStudio
drush config:set searchstax.settings searches_via_searchstudio true -y
```

For nested/sequence keys prefer `php:eval` with the config factory:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("searchstax.settings")
  ->set("untracked_roles", ["administrator"])
  ->set("analytics_key", "AK-123")->save();'
```

## The Solr connector plugin

The module registers one `search_api_solr` **SolrConnector** plugin, id **`searchstax`**
("SearchStax Cloud with Token Auth"), class
`src/Plugin/SolrConnector/SearchStaxConnector.php`. It authenticates to the hosted cluster
with a short-lived token instead of basic auth. Per-server credentials (including an optional
`key_id` pointing at a Key entity) live in the Search API **server** config entity's
`backend_config.connector_config`, not in `searchstax.settings`. To wire a server up: create a
`search_api.server` with backend `search_api_solr` and `connector: searchstax`. Sites without
`search_api_solr` get tracking/analytics only (no indexing connector).

## Optional-config credentials (Key module)

`config/optional/` ships two Key entity templates that are installed only when the Key module
is present: `key.key.searchstax_solr_connector_credentials` and
`key.key.searchstax_analytics_credentials`. Point `searchstax.settings:key_id` (analytics) or
the connector's `key_id` (Solr) at a Key entity to keep secrets out of exported config.

## Version compatibility

`searchstax.version_check` (`/admin/config/search/searchstax/version-check`) logs into the
SearchStax account API and reports whether the Solr app matches the site's Drupal major
version — this **requires live credentials and network access to SearchStax**.
