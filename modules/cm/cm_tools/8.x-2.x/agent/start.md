<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ComputerMinds tools (cm_tools) — agent index

A grab-bag of **site-builder and developer tools** by the ComputerMinds agency. Despite the
"tools and helpers" tagline it is **not** a pure code-only library: it ships a token-gated
uptime-monitoring endpoint, a Paragraphs-as-table field formatter and widget, a Webform
page-level-validation handler, a cache context, an update-report preprocess hook, and two static
PHP helper classes (array + translation utilities). Installed **8.x-2.5** (version dir `8.x-2.x`).
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. No module dependencies; PHP `>=8.0`.

Note: the Paragraphs plugins soft-depend on the `paragraphs` module and the Webform handler on the
`webform` module — cm_tools declares no hard dependency on either (they only load if you actually
use those plugins).

## What it provides (from source)

- **Uptime monitoring endpoint** — route `cm_tools.monitoring` at
  `/cm_tools/monitoring/{token}` (`cm_tools.routing.yml`), controller
  `Controller/CmToolsMonitoringController`. Token-gated custom access, page-cache killed,
  `_maintenance_access: TRUE`. `hook_requirements()` (in `cm_tools.install`) surfaces the URL on
  the status report. → [monitoring/uptime-endpoint.md](monitoring/uptime-endpoint.md)
- **Paragraphs table field formatter + widget** — `Plugin/Field/FieldFormatter/ParagraphsTableFormatter`
  (id `cm_tools_paragraphs_table_formatter`) and `Plugin/Field/FieldWidget/ParagraphsTableWidget`
  (id `cm_tools_paragraphs_table_widget`), both for `entity_reference_revisions` fields. Render /
  edit paragraphs as an HTML table instead of stacked subforms. Config schema in
  `config/schema/cm_tools.schema.yml`; theming via `cm_tools_preprocess_field_multiple_value_form`
  (`cm_tools.module`). → [fields/paragraphs-table.md](fields/paragraphs-table.md)
- **Webform page-level validation handler** — `Plugin/WebformHandler/CmToolsPageLevelValidation`
  (id `cm_tools_page_level_validation`) sets a form-wide validation error (driven by Webform
  Conditions), optionally restricted to selected wizard pages. Summary Twig template under
  `templates/`. → [webform/page-level-validation.md](webform/page-level-validation.md)
- **Helpers, cache context, update-report sort** — static `ArrayHelper` (key/value/offset insert,
  rename, remove, stable sorts) and `TranslationHelper::ensureTranslationsOfSimpleStrings()`
  (programmatic locale translations); the `cm-session` calculated cache context
  (`Cache/Context/CmSessionCacheContext`, in `cm_tools.services.yml`); and
  `hook_preprocess_update_report()` sorting the available-updates report by security status.
  → [api/helpers.md](api/helpers.md)

## Surface summary

- Routes: 1 (`cm_tools.monitoring`). Permissions: **none** (no `.permissions.yml`).
- Services: 1 (`cache_context.cm-session`). Plugins: 3 (field formatter, field widget, webform handler).
- Hooks: `hook_requirements`, `hook_theme`, `hook_preprocess_update_report`,
  `hook_preprocess_field_multiple_value_form`. No install/update schema hooks; no Drush commands.
- Config: field-formatter/widget settings schema only; no settings form of its own.
