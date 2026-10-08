<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speculative Loading (speculative_loading) — agent index

Adds browser **Speculation Rules API** support to Drupal: injects one inline
`<script type="speculationrules">` block into every page `<head>` so Chromium browsers
**prefetch** or **prerender** likely next pages for near-instant navigation. Package
`Performance`. Depends only on core **`system`**. Core requirement `^10.3 || ^11`, PHP `>=8.1.0`.
License GPL-2.0-or-later. Version 1.x (installed 1.0.0-beta2). No permissions of its own, no Drush,
no entities, no library assets.

- **Settings, config object, routes, injection mechanism, exclusions, plugin type & alter hook** →
  [config/settings.md](config/settings.md)

## What it actually is

- A `hook_page_attachments()` implementation (`speculative_loading.module`) that asks
  `plugin.manager.speculation_rules` for `getSpeculationRules()` and attaches the result as an
  inline `speculationrules` script via `html_head`, value = `json_encode($rules)`.
- **Two site settings** in config object `speculative_loading.settings`: `mode`
  (`prefetch` | `prerender`, default `prerender`) and `eagerness`
  (`conservative` | `moderate` | `eager`, default `moderate`). Schema in
  `config/schema/speculative_loading.schema.yml`; install defaults in `config/install/`.
- **Settings form** `SpeculativeLoadingSettingsForm` (`ConfigFormBase`) at route
  `speculative_loading.settings` → `/admin/config/development/performance/speculative-loading`,
  requirement `_permission: 'administer site configuration'`. Exposed as a menu link and a local
  task under core's *Performance* page.

## Services & plugins (from source)

- `speculative_loading.url_pattern_prefixer` → `UrlPattern\UrlPatternPrefixer`: prefixes a path
  pattern (e.g. `/*`, `/admin/*`) with the correct base path per context (`site`, `files`,
  `modules`, `themes`); escapes special chars with `addcslashes`.
- `plugin.manager.speculation_rules` → `Plugin\SpeculationRulesManager` (extends
  `DefaultPluginManager`): builds the rules array in `getSpeculationRules()` and the exclusion list
  in `getHrefExcludePaths($mode)`.
- **Plugin type `speculation_rules`**: discovery dir `Plugin/SpeculationRules`, annotation
  `@SpeculationRules`, interface `SpeculationRulesInterface`. Ships one plugin
  `DefaultSpeculationRules` (id `default`).
- **Alter hook** `hook_speculation_rules_href_exclude_paths_alter(&$exclude_paths, $mode)` (see
  `speculative_loading.api.php`) lets other modules add/remove excluded path patterns per mode.

## Notes

- Non-Chromium browsers ignore the markup harmlessly. `hook_uninstall()` deletes
  `speculative_loading.settings`.
