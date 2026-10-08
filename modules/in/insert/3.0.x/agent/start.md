<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insert — agent index

Adds an **Insert** button to file/image field widgets so an uploaded file/image can be dropped
into a nearby text area or CKEditor field. It is a **widget alteration** (hooks on core file/image
widgets), not a field type or plugin. Two config layers:

1. **Global** config object `insert.config` (route `insert.config` → `/admin/config/content/insert`,
   permission `administer filters`): which widget plugin ids Insert attaches to, image-in-file toggle,
   CSS classes, audio/video extensions, absolute vs relative URLs.
2. **Per widget**: a `third_party_settings.insert` array on an `entity_form_display` component
   (which insert styles are offered, default style, image width, etc.).

- **Global settings + per-widget settings, config keys, where stored, drush** →
  [configure/insert-config.md](configure/insert-config.md)
- **Extend Insert (new widgets/styles/rendering) via its hooks — how the submodules do it** →
  [hooks/extend.md](hooks/extend.md)

Key facts:
- Default source widgets: `file_generic` (file) and `image_image` (image), in `insert.config` →
  `widgets.file` / `widgets.image`.
- Per-widget setting lives at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.insert` with keys `styles` (map of enabled style names),
  `default` (default style, default `insert__auto`), `auto_image_style`, `link_image`, `width`, `rotate`.
- **Insert is "off" for a field when `styles` is empty** — no button is shown.
- No permissions of its own, no Drush, no plugin types. Submodules: `insert_media`, `insert_colorbox`,
  `insert_responsive_image` (nested under this project).
- Gotcha on this site: `lightning_media_image` rewrites a **new** image-field widget to
  `entity_browser_file` on first form-display save; set an `image_image` component, save, then set it
  **again** (it is no longer "new") to make `image_image` + `insert` settings stick. File fields are
  unaffected.
