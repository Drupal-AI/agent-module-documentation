# Plyr — agent index

Field formatters that render video/audio with the [Plyr](https://plyr.io) JS player. Depends on
core `media`. No permissions of its own; no Drush; no config schema. A `plyr.settings` route exists
(`/admin/config/media/plyr`, *administer site configuration*) but the form is **empty** — all real
config is per-formatter on *Manage display*. Plyr JS/CSS (3.7.8) loads from the cdn.plyr.io CDN.

- **The three formatters, every settings key, applicability, CDN library** →
  [configure/formatters.md](configure/formatters.md)
- **Theme hooks, the `data-plyr-*` attributes, and `js/plyr-player.js` behavior (for theming/JS overrides)** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Formatters: `plyr_remote_video` (fields `link`/`string`/`string_long`, only on oEmbed media — YouTube/Vimeo),
  `plyr_file_video` & `plyr_file_audio` (field `file`).
- Settings live on the `entity_view_display` component under `settings` (autoplay, loop, resetOnEnd,
  hideControls, a `controls` map, and `youtube.noCookie`).
- Settings → `#plyr_settings` array → `data-plyr-config` JSON attribute → `Plyr.setup('.plyr-player')`.
