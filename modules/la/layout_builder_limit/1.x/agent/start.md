<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Limit (layout_builder_limit) — agent index

Sets a **minimum and/or maximum number of components (blocks)** allowed in a Layout Builder
**section**, or **per region** inside a section. Not a which-blocks/which-layouts restriction —
that is Layout Builder Restrictions; this module governs **counts**. Version **1.0.0-beta5**
(doc dir `1.x`). Core `^10.1 || ^11`. Package *Layout Builder*. License GPL-2.0-or-later.

- **Full mechanism, permissions, third-party setting shape, config schema, enforcement** →
  [config/section-limits.md](config/section-limits.md)

## What it actually is (from source)

- **No routes, no services.yml, no plugin types, no Drush, no install file, no submodules.**
  Everything is wired from `layout_builder_limit.module` via three hooks that hand off to
  `\Drupal::service('class_resolver')->getInstanceFromDefinition(...)`.
- Dependency: core **`layout_builder`** only (`drupal:layout_builder`).
- **Permissions** (`layout_builder_limit.permissions.yml`): `manage layout builder limit settings
  on default` and `manage layout builder limit settings on overrides`.
- **Config schema** (`config/schema/layout_builder_limit.schema.yml`): defines the
  `layout_builder.section.third_party.layout_builder_limit` third-party setting `limit`, keyed by
  scope (`disabled` / `region` / `section`).

## The three hooks and their classes

- `hook_form_layout_builder_configure_section_alter` → **`FormAlter::configureSectionFormAlter()`**
  — adds the "Limit settings" details (scope select + min/max fields) to the section form,
  **permission-gated**, and saves the values as the section third-party setting `limit`.
- `hook_plugin_filter_block__layout_builder_alter` → **`PluginFilterAlter`** — empties the block
  plugin list for a region/section that has reached its maximum (UI: nothing to add).
- `hook_element_info_alter` → **`ElementInfoAlter`** (implements `TrustedCallbackInterface`) —
  adds a `#pre_render` (`preRender()`, inline warning/error messages + removes
  `layout_builder_add_block` at max) and an `#element_validate`
  (`validateLayoutBuilderElement()`, **the server-side check that fails the layout Save** when a
  min/max is violated).
- **`LayoutBuilderLimit`** — constants (`LIMIT_DISABLED`/`LIMIT_REGION`/`LIMIT_SECTION`) and
  `getDefaultConfiguration()` / `getScopeSettings()` that normalize the stored configuration.

## Config / operation

- Configured **inline** on each Layout Builder section (the section-config tray), not on a
  standalone admin form — `configure` route is **null**.
- Stored per section as `third_party_settings.layout_builder_limit.limit` with a `scope` and, for
  region/section scope, a `settings` map of `{minimum_enabled, minimum, maximum_enabled, maximum}`.

See [config/section-limits.md](config/section-limits.md) for the exact keys, schema, permission
logic, and enforcement flow.
