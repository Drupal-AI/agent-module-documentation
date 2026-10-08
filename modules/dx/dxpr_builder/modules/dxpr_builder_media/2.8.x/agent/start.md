<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# DXPR Builder Media — agent index

Hidden submodule of **dxpr_builder** that provides an Entity Browser-based **media browser**
(modal image/media picker) for the DXPR Builder editor. Mostly configuration plus small theming
glue. No settings, permissions, schema, or Drush of its own.

- **The shipped config + how to select this browser in DXPR + the theming glue** →
  [configure/media-browser.md](configure/media-browser.md)

Key facts:
- Ships `entity_browser.browser.dxpr_builder_media_modal`, `views.view.dxpr_builder_media`,
  and `image.style.dxpr_builder_media_thumbnail`.
- Activate it by setting `dxpr_builder.settings:media_browser` to `dxpr_builder_media_modal`.
- Code: `hook_preprocess_views_view()` (Gin/Claro CSS) + `hook_library_info_alter()` (Backbone).
- Module is `hidden: true`; depends on `entity_browser`, `entity_browser_entity_form`,
  `inline_entity_form`, `media`, `media_library`, `views`. Parent:
  [../../../../2.8.x/agent/start.md](../../../../2.8.x/agent/start.md).
