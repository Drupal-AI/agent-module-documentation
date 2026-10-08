<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, access, permissions and configuration

## Static routes (`analyze.routing.yml`)

- `analyze.analyze_settings` — `/admin/config/content/analyze-settings`, form
  `Form\AnalyzeSettingsForm`, permission `administer analyze`. This is the `configure` route.
- `analyze.batch` — `/admin/config/content/analyze-batch`, form `Form\AnalyzeBatchForm`,
  permission `administer analyze`.

## Dynamic routes (`EventSubscriber\AnalyzeRouteSubscriber`)

For **every entity type with a `canonical` link template**, and only when at least one Analyze
plugin exists, `alterRoutes()` adds:

- `entity.<type>.analyze` — path `<canonical>/analyze`, controller
  `AnalyzeController::analyze` (summary; `full_report` unset → FALSE), title callback
  `analyzeTitle`.
- `analyze.<type>.<plugin>` — path `<canonical>/analyze/<plugin_id>`, same controller with
  `plugin` + `full_report => TRUE`.

Both set `_admin_route: TRUE` and `_analyze_access: 'TRUE'`. Local tasks are added in
`analyze_local_tasks_alter()`: an "Analyze" primary tab (base route `entity.<type>.canonical`), a
"Summary" default secondary tab, and one secondary tab per plugin.

## Access — `_analyze_access` (`Access\AnalyzeAccessAccessChecker`)

`access(Route, AccountInterface, string $entity_type, ?string $plugin)`:

1. Load the routed entity via `Helper::getEntity()`; forbidden if it does not exist.
2. Require permission **`view analyze reports`**; otherwise forbidden.
3. Read `analyze.settings` `status`; allow only if the analyzer(s) are enabled for
   `[$entity_type][$entity->bundle()]`. For a specific `$plugin`, the plugin must be enabled, its
   full-report URL must not be overridden (`fullReportUrlOverridden()`), and its own `access()`
   must pass.

The controller (`AnalyzeController::analyze()`) additionally re-checks `isEnabled()` **and**
`access()` for each plugin before rendering it, and caches per `url` + the entity's cache tags.

## Permissions (`analyze.permissions.yml`)

- `administer analyze` — configure analyzers (`restrict access: true`).
- `view analyze reports` — read the Analyze tab / reports (`restrict access: true`).

## Configuration objects

- **`analyze.settings`** — the on/off matrix. `status[entity_type][bundle][plugin_id] = TRUE`.
  Schema: nested `sequence` of booleans (`config/schema/analyze.schema.yml`).
- **`analyze.plugin_settings`** — per-analyzer detailed settings, keyed
  `"<entity_type>.<bundle>.<plugin_id>"` (written by `AnalyzePluginBase::getEntityTypeSettingsForm`
  / `saveSettings` and by `analyze_add_settings_form_submit`).
- **`analyze.entity_settings`** — alternate per type/bundle analyzer settings read by
  `getEntityTypeSettings()` (`<type>.analyzers.<plugin>` and `<type>.<bundle>.analyzers.<plugin>`,
  merged bundle-over-type).

## Where the toggles come from

- The global `AnalyzeSettingsForm` (form id `analyze_analyze_settings`).
- `hook_form_alter()` in `analyze.module` injects an "Analyze settings" details element into every
  **bundle edit form** (and hard-codes `user`), gated by `administer analyze`. Each applicable
  plugin's `getEntityTypeSettingsForm()` supplies a checkbox (+ any configurable settings);
  `analyze_add_settings_form_submit()` writes `analyze.settings` and `analyze.plugin_settings`.

## Operating it

1. `drush en analyze` plus one or more analyzer submodules (e.g. `analyze_basic_content_info`).
2. Visit `/admin/config/content/analyze-settings` (perm `administer analyze`) or a bundle edit
   form and enable analyzers per type/bundle.
3. Grant `view analyze reports` to roles that should read the tab.
4. Open any entity's canonical page → "Analyze" tab. Run `drush cr` after enabling a new analyzer
   so the route subscriber rebuilds routes.
5. Bulk runs: `/admin/config/content/analyze-batch` or `drush analyze:batch`
   (`Service\AnalyzeBatchService`).
