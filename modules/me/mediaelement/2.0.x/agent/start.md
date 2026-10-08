# MediaElement.js — agent index

Renders `file` fields as HTML5 audio/video through the [MediaElement.js](https://www.mediaelementjs.com/)
player. Two formatters extending core file formatters, plus a global settings form. Depends on core
`file`. Provides a config schema and one permission (*administer mediaelement*); no Drush.

- **Global settings form: library source (local vs CDNJS), sitewide attach, dimensions, config keys** →
  [configure/settings.md](configure/settings.md)
- **The two field formatters and their per-instance settings (preload, download link, poster image)** →
  [configure/formatters.md](configure/formatters.md)
- **The `administer mediaelement` permission** → [permissions/permissions.md](permissions/permissions.md)
- **Theme hooks, templates, JS bundle, and `drupalSettings.mediaelement`** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Formatters: `mediaelement_file_video`, `mediaelement_file_audio` (both field type `file`).
- Config `mediaelement.settings`: `library_settings.library_source` = `local` (default) or `cdnjs`;
  `global_settings.attach_sitewide` (default `0`).
- Default is **local** at `/libraries/mediaelement/build` — supply the library or switch to CDNJS.
- Configure route: `mediaelement.config` → `/admin/config/media/mediaelement/config`.
