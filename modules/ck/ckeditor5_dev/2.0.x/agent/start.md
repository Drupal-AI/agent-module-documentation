<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Dev tools (ckeditor5_dev) — agent index

Developer tooling for CKEditor 5 in Drupal. Version **2.0.1**. Core `^10.5 || ^11 || ^12`.
Depends on core `ckeditor5`. No config form, no services, no config schema, no Drush commands.

Three capabilities:

1. **CKEditor 5 Inspector.** `hook_library_info_alter()` (in `ckeditor5_dev.module`) appends
   `ckeditor5_dev/ckeditor5_dev` as a dependency of core's `internal.drupal.ckeditor5` library.
   `js/ckeditor5_dev.js` wraps `Drupal.CKEditor5Instances.set`/`delete` so `CKEditorInspector.attach()`/
   `detach()` runs as each editor mounts/unmounts. The Inspector JS itself is loaded external from
   `https://unpkg.com/@ckeditor/ckeditor5-inspector` (v5.0.0, GPL-2.0-or-later). Result: a debugging
   pane appears on any page with a live CKEditor 5 instance — no build step, no per-format config.
2. **Plugin report.** Route `/admin/reports/ckeditor5-plugins` (`ckeditor5_dev.reports_plugins`),
   permission `access ckeditor5 plugin report`, controller
   `Ckeditor5DevReports::reportPlugins()`. Calls `plugin.manager.ckeditor5.plugin`->`getDefinitions()`
   and renders one table row per **registered** plugin definition: label, id, declared HTML elements,
   providing module. This is the full site-wide set of registered definitions, **not** the subset
   enabled for one text format. Linked under Administration → Reports.
3. **Plugin starter template.** `ckeditor5_plugin_starter_template/` — a copy-and-rename scaffold for
   building a module that provides a custom CKEditor 5 plugin. Details in
   [`guides/plugin-starter-template.md`](guides/plugin-starter-template.md).

Answers the two questions that consume CKEditor 5 integration time: *what is the editor model doing*
(the Inspector — the model is not the DOM, so DOM debugging cannot answer it), and *which module
provides this plugin and what markup does it allow* (the report).

Key facts for agents:
- The module answers those questions but changes nothing about editor behavior itself.
- The report is **all registered** CKEditor 5 plugins, not per-text-format. Do not tell a user this
  is "what is enabled for format X".
- No settings form. Once enabled the Inspector is automatic; the only UI is the report.
- Permission `access ckeditor5 plugin report` gates the report only, not the Inspector.

**Development tool — do not leave it enabled in production.** The module's own `hook_help` and README
say so explicitly. The Inspector is a debugging overlay that renders for any user reaching a page with
a CKEditor 5 instance while the module is on; the report exposes editor plugin configuration. This is
exactly the class of leftover-dev-module a production-readiness check flags. No security-sensitive
routes beyond the admin-gated report — see the security note below.

## Security

This is a development-only tool: keep it disabled in production. The plugin report at
`/admin/reports/ckeditor5-plugins` is gated by the `access ckeditor5 plugin report` permission and is
read-only, and the Inspector overlay loads its script from an external CDN, so the module is intended
for local/dev environments rather than production.

## Files
- `data.json` — metadata.
- `usage.md` — prose + use cases.
- `agent/guides/plugin-starter-template.md` — how the scaffold works and the build workflow.
