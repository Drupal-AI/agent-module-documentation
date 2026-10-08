<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Admin (drowl_admin) — agent index

A CSS-only support module that attaches admin-theme, toolbar, Layout Builder and CKEditor styling
fixes to Drupal admin pages. It is the styling base for the other DROWL (`drowl_*`) modules and is
"not useful without" them. Package **User interface**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 3.0.17 (dir 3.0.x).

- **The three hooks (what backend/toolbar changes it makes) + the CSS libraries + the iconset
  requirement** → [hooks/backend-and-libraries.md](hooks/backend-and-libraries.md)
- **The ProjectWiki content plugin (soft dependency)** →
  [plugins/project-wiki-content.md](plugins/project-wiki-content.md)

## What it actually is

- **Hard dependency:** core `layout_builder` (from `drowl_admin.info.yml`). No other module deps.
- **Front-end library:** expects `npm-asset/drowl-admin-iconset` at `/libraries/drowl-admin-iconset/`
  (composer `suggest`; a runtime `hook_requirements()` in `drowl_admin.install` errors if missing).
- **No routes, no permissions, no services, no config objects/schema, no settings form, no Drush,
  no entities, no fields.** It defines no plugin *types*.
- All behavior comes from three procedural hooks in `drowl_admin.module` plus CSS libraries in
  `drowl_admin.libraries.yml`. It attaches **CSS only** (no JS behaviors ship; some libraries just
  declare core JS deps).

## Hooks (in `drowl_admin.module`)

- `drowl_admin_page_attachments()` — on admin routes attaches `admin_ckeditor_tweaks`; then, keyed on
  the configured admin theme name, `admin_theme_overrides_gin` / `_adminimal`; on Layout Builder
  routes, `layout_builder_claro` / `layout_builder_gin`.
- `drowl_admin_toolbar_alter()` — attaches `admin_toolbar_fixes` and `contextual_links` to the
  toolbar's `administration` item.
- `drowl_admin_editor_js_settings_alter()` — sets `full_html` `format_tags` to
  `p;h2;h3;h4;h5;h6;pre` (drops `h1`).
- Helper `drowl_admin_is_layout_builder_route()` — regex-matches `layout_builder.*` route names.

## Plugin (soft dependency)

- `DrowlAdminProjectWikiContents` (id `drowl_admin`) in
  `src/Plugin/ProjectWikiContentPlugins/`, extends `ProjectWikiMarkdownContentPluginBase` from the
  **optional** `project_wiki_markdown_content` module (NOT in `info.yml` deps — only active if that
  module is installed). Returns the bundled Markdown dir `docs/project_wiki_markdown_content`.
  See [plugins/project-wiki-content.md](plugins/project-wiki-content.md).
