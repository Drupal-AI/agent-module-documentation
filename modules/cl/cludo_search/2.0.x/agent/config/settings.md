<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config keys & dynamic routing

## Install / enable

`drush en cludo_search`. No dependencies beyond core, no Composer library. Then open
`/admin/config/search/cludo_search/settings` (link also under Configuration → System via
`cludo_search.links.menu.yml`) and enter your Cludo account's **public** `customerId` and
`engineId` (from your Cludo dashboard) plus the **search page path**.

## SettingsForm (`src/Form/SettingsForm.php`)

`ConfigFormBase`, form id `cludo_search_config_settings`, editable config `cludo_search.settings`,
route `cludo_search.settings` guarded by `_permission: administer cludo search`.

Fields (grouped in two `details` elements):

| config key | type | required | default constant | notes |
|-----|------|----------|------------------|-------|
| `customerId` | textfield | yes | `CLUDO_SEARCH_DEFAULT_CUSTOMERID` = `default_customerId` | **public** Cludo account id |
| `engineId` | textfield | yes | `CLUDO_SEARCH_DEFAULT_ENGINEID` = `default_engineId` | **public** Cludo engine/index id |
| `search_page` | textfield | yes | `CLUDO_SEARCH_DEFAULT_SEARCH_PAGE` = `csearch` | site path that renders results |
| `disable_autocomplete` | checkbox | no | `FALSE` | passed to Cludo JS |
| `hide_results_count` | checkbox | no | `FALSE` | passed to Cludo JS |
| `hide_did_you_mean` | checkbox | no | `FALSE` | passed to Cludo JS |
| `hide_search_filters` | checkbox | no | `FALSE` | overlay implementation only; passed to Cludo JS |

`customerId` and `engineId` are **not secrets** — Cludo's search widget is authenticated by these
two public IDs, and the module writes them into page `drupalSettings` (see
[../search/integration.md](../search/integration.md)). There is no API-key / private-credential
field anywhere in the form or config.

`submitForm()` `trim()`s every value, saves config, calls `_cludo_search_get_settings(TRUE)` to
refresh the static settings cache, then `\Drupal::service('router.builder')->rebuild()` so a changed
`search_page` takes effect immediately.

## Settings accessor (`cludo_search.module`)

`_cludo_search_get_settings($refresh = FALSE)` — statically-cached reader that, per key from
`_cludo_search_get_field_keys()`, returns the config value or falls back to
`CLUDO_SEARCH_DEFAULT_<UPPER>` when empty. Everything that needs config (both forms, the block)
calls this rather than hitting config directly.

## Dynamic route re-pathing (`src/Routing/RouteSubscriber.php`)

Service `cludo_search.route_subscriber` (`event_subscriber` tag, arg `@config.factory`). In
`alterRoutes()` it reads `search_page` from `cludo_search.settings` (fallback `csearch`) and, if the
`cludo_search.search` route exists, sets its path to `/<search_page>`. So `/csearch` in
`cludo_search.routing.yml` is only the default — the live path follows the admin setting.

## No config schema shipped

The module ships **no** `config/schema/*.yml`; `cludo_search.settings` is written as free-form config
by the settings form. (`provides_config_schema` in `data.json` is therefore effectively nominal —
there is no schema file in source.)
