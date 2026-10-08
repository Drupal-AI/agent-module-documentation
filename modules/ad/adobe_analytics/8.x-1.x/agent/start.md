<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adobe Analytics (adobe_analytics) — agent index

Injects the Adobe Analytics / AppMeasurement (formerly Omniture SiteCatalyst) tracking script
and a token-replaced variable payload into the bottom of every non-admin page. Core `^10 || ^11`.
License GPL-2.0-or-later. Version dir **8.x-1.x** (installed 8.x-1.0). Depends on core **`field`**
and contrib **`token`** (`drupal/token:^1.0`).

- **Settings form, config object + schema, roles, custom variables, snippet, tokens, the
  `hook_adobe_analytics_variables()` hook, and the per-entity field override** →
  [config/settings.md](config/settings.md)

## What it actually is

- A **page-attachment analytics injector**, not an entity/route provider. `hook_page_bottom()`
  (`adobe_analytics.module`) adds a `#lazy_builder` calling
  `adobe_analytics.variable_formatter:renderMarkup`, cached per `user.roles` with the settings
  config's cache tags.
- Renders the `analytics_code` theme hook (`templates/analytics-code.html.twig`): a `<script src>`
  to the AppMeasurement file plus an inline `<script>` holding the formatted variables/snippet.

## Provides

- **1 config form** `Form\AdobeAnalyticsAdminSettings` (`ConfigFormBase`) at route
  **`adobe_analytics.settings`** → `/admin/config/search/adobeanalytics`
  (menu link `adobe_analytics.admin` under *Configuration → Search and metadata*).
- **1 permission**: `administer adobe analytics configuration` (`restrict access: true`) — gates
  that route.
- **1 config object** `adobe_analytics.settings` (+ config schema; install defaults in
  `config/install/`).
- **A field type** `adobe_analytics` with matching widget + (no-op) formatter
  (`src/Plugin/Field/*`) for per-entity overrides; field-value schema `field.value.adobe_analytics`.
- **Services**: `adobe_analytics.variables_factory` (`VariablesFactory::load`),
  `adobe_analytics.variables` (`VariablesInterface`), `adobe_analytics.variable_formatter`
  (`VariableFormatter`, a `TrustedCallbackInterface`), plus two tracking matchers
  (`TrackingMatcher\AdminContext`, `TrackingMatcher\RoleContext`) tagged
  **`adobe_analytics_tracking_matcher`** and wired in by `AdobeAnalyticsServiceProvider`.
- **A hook** `hook_adobe_analytics_variables()` for other modules to contribute
  header/variables/footer variables (see the `tests/adobe_analytics_test` module).

## Not provided

No Drush commands, no controllers/custom routes beyond the settings form, no REST resources,
no submodules, no external HTTP calls from the server (the tracking JS runs client-side).
