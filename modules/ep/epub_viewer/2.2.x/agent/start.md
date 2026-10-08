<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Epub Viewer (epub_module) — agent index

Field formatter that turns EPUB (`application/epub+zip`) file-field values into a link that opens the file in a bundled in-browser e-book reader. Project dir `epub_viewer`; **machine/enable name `epub_module`**. License GPL-2.0-or-later. Core `^9.3 || ^10 || ^11`. Version 2.2.x. No contrib dependencies; no `composer.json`, no `config/` schema, no permissions/services/Drush of its own.

## What it provides

- **Formatter** `epub_field_formatter` (*Epub Formatter*), on **core file fields** → [fields/formatter.md](fields/formatter.md).
- **Viewer route** `epub_module.epub` = `/view-ebook/{fid}` → `EpubController::viewEbook`, theme `epub_view`, plus the bundled JS reader → [api/viewer.md](api/viewer.md).
- **Settings form** `epub_module.epub_settings_form` = `/admin/config/epub/epubsettings`, config `epub_module.epubsettings` → [config/settings.md](config/settings.md).

## Fast facts (from source)

- `epub_module.info.yml`: name *Epub Viewer*, `type: module`, no `dependencies`, no `package`.
- Routing (`epub_module.routing.yml`): viewer perm `access content`; settings perm `access administration pages` (`_admin_route: TRUE`).
- Menu link (`epub_module.links.menu.yml`): *EBook Viewer Configuration* under `system.admin_config_system`.
- `hook_theme()` (`epub_module.module`): `epub_formatter` (var `path`) and `epub_view` (vars `data`, `options`).
- Templates: `epub-formatter.html.twig` (the link), `epub-view.html.twig` (the reader). `epub-light-theme-view.html.twig` is **unused** (references a library `epub_module/epub-style` that is not defined — there is no `*.libraries.yml`).
- Bundled assets under `js/` (epub.js, jszip, screenfull, content_view.js, jquery), `css/`, `jquery-ui-1.12.1.custom/`, icon fonts; loaded via hard-coded `<script>`/`<link>` tags in `epub-view.html.twig`, not the Drupal library system. Two assets load from CDNs (Google-hosted jQuery 3.4.1, cdnjs detect_swipe 2.1.1).
- Optional integration: `color_field` (checked via `moduleExists('color_field')` in the settings form only).
