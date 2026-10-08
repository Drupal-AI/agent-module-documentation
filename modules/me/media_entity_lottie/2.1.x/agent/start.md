# Media entity Lottie — agent index

Adds a **`lottie_file`** media source + a **`file_lottie_player`** field formatter so core Media can
hold `.json` Lottie animations and render them with the `<lottie-player>` web component. No settings
form (`configure: null`), no permissions, no Drush. Configured through the standard Media UI.

- **Create a Lottie media type, the source field, and wire the display formatter (UI + config)** →
  [configure/media-type.md](configure/media-type.md)
- **The `lottie_file` source, `file_lottie_player` formatter settings, JS libraries, and the upload validator** →
  [plugins/source-and-formatter.md](plugins/source-and-formatter.md)

Key facts:
- Source `lottie_file` extends core `File`; restricts the source field to extension `json`; exposes
  metadata `width`, `height`, `name`, `version`, `frames` (from JSON keys `w`,`h`,`nm`,`v`,`fr`).
- Formatter `file_lottie_player` is only applicable to a field whose name contains
  `field_media_lottie_file`; renders `<lottie-player>` and attaches library `media_entity_lottie/lottie_player`.
- Player JS is loaded from **unpkg CDN** (`libraries.yml` remote libs) — needs outbound network or a
  local override.
