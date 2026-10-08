<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Analyze

## Routes / UI
| Route | Path | Form | Permission |
|---|---|---|---|
| `analyze.analyze_settings` (the `configure` route) | `/admin/config/content/analyze-settings` | `AnalyzeSettingsForm` | `administer analyze` |
| `analyze.batch` | `/admin/config/content/analyze-batch` | `AnalyzeBatchForm` | `administer analyze` |

Both appear under **Configuration → Content authoring** (menu links "Content Analysis" and "Batch
Analysis"). Per-entity report routes (`entity.{type}.analyze`, `analyze.{type}.{plugin}`) are added
dynamically by `AnalyzeRouteSubscriber` for every entity type with a `canonical` link template, and
show as local tasks/tabs on the entity.

## Permissions (`analyze.permissions.yml`, both `restrict access: true`)
- **`administer analyze`** — access the two settings/batch forms; also required for the Analyze
  fieldset injected into bundle edit forms.
- **`view analyze reports`** — required by the `_analyze_access` check to view any Analyze
  tab/report. Access is granted only when the user has this permission **and** the entity's
  type+bundle (and the specific plugin, for a plugin route) is enabled in config.

## Enabling analyzers per entity type / bundle
The settings form (`AnalyzeSettingsForm`) lists every canonical-URL entity type, its bundles, and a
checkbox per **applicable** analyzer (`isApplicable()`). Saving writes:

- **`analyze.settings`** → key `status[entity_type][bundle][plugin_id] = true`. This is the master
  on/off matrix read by `isEnabled()` and the access checker.

Analyzers with configurable settings (`getConfigurableSettings()`) are **also** injected into each
bundle's own edit form via `hook_form_alter` (an "Analyze settings" fieldset under Additional
settings; `user` entity is hard-coded in on `user_admin_settings`). Saving there writes:

- **`analyze.plugin_settings`** → key `"{type}.{bundle}.{plugin_id}"` (per-bundle plugin settings).
- **`analyze.entity_settings`** → `{type}.[{bundle}.]analyzers.{plugin_id}` (type/bundle-level
  settings; bundle merges over type via `array_replace_recursive`). Read helpers on the base class:
  `getEntityTypeSettings()`, `isEnabledForEntityType()`, `saveSettings()`.

## Config schema (`config/schema/analyze.schema.yml`)
- `analyze.settings` — `status` nested sequence (type → bundle → plugin → bool).
- `analyze.entity_settings` — per-type/bundle `analyzers` mapping with `enabled` + nullable
  `settings`.
- (`analyze.plugin_settings` is written by code; free-form per-plugin.)

## Batch form
`AnalyzeBatchForm` at `/admin/config/content/analyze-batch` runs the same pipeline as the Drush
command (see drush doc) through Drupal's Batch API — pick analyzers, entity type:bundle targets,
limit and force-refresh, then run with a progress bar. Only analyzers implementing
`BatchableAnalyzerInterface` appear.
