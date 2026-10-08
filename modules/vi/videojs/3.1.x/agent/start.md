<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video.js Player — agent index

Field formatters that render core File/Video fields with the [Video.js](https://videojs.com/) HTML5 player, loaded from a CDN by default. No admin settings form (`configure` null), no permissions, no Drush. Provides a config schema for the library location.

- **The two formatters, their settings, and the library/CDN config** → [configure/formatters.md](configure/formatters.md)
- **The `videojs` theme hook for rendering a player from custom code** → [theming/theme-hook.md](theming/theme-hook.md)

Key facts:
- Formatters: `videojs_player` (single value, `isApplicable` when field is not a list) and `videojs_player_list` (multi value). Field types: `file`, `video`.
- Per-display settings: `width` (854), `height` (480), `controls` (TRUE), `autoplay` (FALSE), `loop` (FALSE), `muted` (FALSE), `preload` (`none`). Stored in the `entity_view_display` component.
- Render element `#theme => 'videojs'`, template `templates/videojs.html.twig`, attaches library `videojs/videojs`.
- Library `videojs/videojs` (`videojs.libraries.yml`) loads Video.js 5.x from `//vjs.zencdn.net/5.0` (external CDN). Config object `videojs.settings` (`videojs_location`, `videojs_directory`) records a local/CDN path; `videojs_get_version()` probes it.
- No `configure` route ships; `videojs.settings` is set via config/drush only.
