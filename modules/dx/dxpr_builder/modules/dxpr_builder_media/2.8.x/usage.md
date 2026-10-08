<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
DXPR Builder Media is a hidden submodule that provides an Entity Browser-based media browser (a modal image/media picker) for selecting media inside the DXPR Builder editor.

---

Enabling `dxpr_builder_media` installs the configuration for a DXPR-styled media picker: an Entity Browser (`entity_browser.browser.dxpr_builder_media_modal`), a supporting View (`views.view.dxpr_builder_media`) that lists media in a selectable grid, and an image style (`image.style.dxpr_builder_media_thumbnail`) for the grid thumbnails. Its small amount of code is presentation glue: `hook_preprocess_views_view()` attaches Gin- or Claro-specific CSS to the `dxpr_builder_media` view depending on the active admin theme, and `hook_library_info_alter()` wires the view's JS to core's Backbone library. You "turn it on" for DXPR Builder by choosing this browser as the builder's media browser in DXPR Builder settings — i.e. setting `dxpr_builder.settings:media_browser` to the entity browser id `dxpr_builder_media_modal` (the settings form lists every available entity browser plus Media Library). The module is marked `hidden: true` (it does not show on the normal Extend list) and depends on Entity Browser, Inline Entity Form, Media, Media Library, and Views. It has no settings, permissions, schema, or Drush of its own.

---

- Give DXPR Builder editors a modal media/image picker instead of basic file upload.
- Reuse existing Drupal media entities when inserting images in the builder.
- Present media in a selectable, thumbnailed grid inside the builder.
- Provide an Entity Browser (`dxpr_builder_media_modal`) tailored to DXPR Builder.
- Theme the media browser for Gin or Claro automatically based on the active admin theme.
- Select a media item and insert it into a DXPR-built layout.
- Offer an alternative to the Media Library browser for DXPR image selection.
- Standardize media selection across all DXPR Builder editing.
- Show consistent thumbnail sizes via the dxpr_builder_media_thumbnail image style.
- Let editors browse and pick from the site's media library within the builder.
- Wire the media browser's JS to core Backbone without extra configuration.
- Enable rich media insertion for marketing pages built with DXPR.
- Configure DXPR to use this browser via the media_browser setting.
- Keep media selection inside a modal so editors stay in the builder.
- Support inline entity form / entity browser entity form workflows for media.
- Provide the media-picking half of a full DXPR page-building setup.
- Deploy the media browser as exportable configuration (view, entity browser, image style).
- Avoid building a custom media widget for the DXPR editor.
- Give a branded, admin-theme-aware media selection experience.
- Pair with dxpr_builder_page/dxpr_builder_block so editors can add media to built content.
