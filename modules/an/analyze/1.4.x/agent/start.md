<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze (analyze) — agent index

A framework that adds an **"Analyze" tab** to every entity with a `canonical` link template and
defines an **`Analyze` plugin type** so modules can render per-entity insights on that tab. Package
`Analyze`. Core `^10.3 | ^11`. License GPL-2.0-or-later. Version 1.4.x. `composer require` has no
runtime deps; suggests `drupal/statistics` and `drush/drush`.

The module ships **no analyzers of its own** — analyzer plugins live in submodules:
`analyze_basic_content_info`, `analyze_page_views`, `analyze_google_analytics`,
`analyze_plugin_example`.

- **Write an analyzer, the plugin manager/base/interface, gauge & table theming** →
  [plugins/writing-an-analyze-plugin.md](plugins/writing-an-analyze-plugin.md)
- **Routes, the Analyze tab controller, access, permissions, config objects & settings UI** →
  [config/settings-and-access.md](config/settings-and-access.md)

## What it actually is

- **Plugin type `Analyze`** — manager `AnalyzePluginManager` (service `plugin.manager.analyze`,
  directory `Plugin/Analyze`, annotation `Annotation\Analyze` with `id`/`title`/`description`,
  interface `AnalyzeInterface`, alter hook `hook_analyze_info_alter`). Base class
  `AnalyzePluginBase` implements `AnalyzeInterface` + `ContainerFactoryPluginInterface`.
- **Dynamic routes** — `EventSubscriber\AnalyzeRouteSubscriber::alterRoutes()` creates, for every
  entity type with a canonical link: `entity.<type>.analyze` (summary) and one
  `analyze.<type>.<plugin>` (full report) per plugin. All are `_admin_route` and require
  `_analyze_access: 'TRUE'`.
- **Controller** — `Controller\AnalyzeController::analyze()` renders each enabled+accessible
  plugin's `renderSummary()` (summary page) or `renderFullReport()` (full page). Summaries are
  restricted to `#theme` of `analyze_gauge` or `analyze_table` (validated in `validatePluginData()`).
- **Access check** — `Access\AnalyzeAccessAccessChecker` (`_analyze_access`) requires the
  `view analyze reports` permission and that the analyzer is enabled for the entity's bundle.
- **Helper service** `analyze.helper` (`Helper`) — loads the routed entity, instantiates plugins,
  lists entity types with a canonical link, and exposes `analyze.settings` config.
- **Settings** — global form `Form\AnalyzeSettingsForm` at `/admin/config/content/analyze-settings`
  (`analyze.analyze_settings`, perm `administer analyze`); batch form `Form\AnalyzeBatchForm` at
  `/admin/config/content/analyze-batch` (`analyze.batch`). `hook_form_alter` injects an "Analyze
  settings" section into each bundle edit form.
- **Theme hooks** (`analyze.module`): `analyze_gauge`, `analyze_circular_gauge`, `analyze_table`
  (+ SDC components under `components/`). `analyze_preprocess_analyze_table` casts each row's `data`
  to string.
- **Config**: `analyze.settings` (per type/bundle status), `analyze.plugin_settings`,
  `analyze.entity_settings`. Schema in `config/schema/analyze.schema.yml`.
- **Permissions** (`analyze.permissions.yml`, both `restrict access: true`): `administer analyze`,
  `view analyze reports`.
- **Drush** (`drush.services.yml`, `src/Drush/Commands/`): `analyze:batch` (`AnalyzeBatchCommands`),
  `analyze:setup-ai` (`AnalyzeSetupCommands`); batch logic in `Service\AnalyzeBatchService`.
- Also provides a Views filter `Plugin/views/filter/AnalyzeSelectFilter` and a ContentIntel plugin
  `Plugin/ContentIntel/AnalyzePlugin` (integration shims).
