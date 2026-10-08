# Tiny Slider — agent index

Integrates the Tiny Slider 2 vanilla-JS carousel. No configure route. Two display plugins plus one
Drush command. Depends on `field` + `image`.

- **Field formatter `tiny_slider_field_formatter` + Views style `tiny_slider`: option keys,
  advanced mode, where settings are stored** → [configure/display.md](configure/display.md)
- **Install the JS library (`tiny_slider:download` / `ts:dl`)** →
  [drush/download.md](drush/download.md)

Key facts:
- The Tiny Slider JS/CSS library is **not shipped**; it must live at `/libraries/tiny-slider`
  (`js/dist/tiny-slider.js`). `hook_requirements()` shows an error until it is present. Config can
  still be set without the library; the slider just will not initialize on the front-end.
- No config schema of its own (`provides_config_schema: false`); formatter settings ride in the
  `entity_view_display`, Views options in the view config entity.
- Option defaults come from `TinySliderGlobal::defaultSettings()` and
  `_tiny_slider_default_settings()` (see the display doc).
