# Field Slideshow — agent index

A "Slideshow" field formatter for core Image fields, powered by jQuery Cycle2. Chosen per display on
**Manage display**; no global config page (`configure` null), no permissions, no Drush. Depends on core
`image`. Ships a config schema for the formatter and defines a small `field_slideshow_pager` plugin type.

- **The `slideshow` formatter: every setting, where it's stored, the Cycle2 library, Colorbox link** →
  [configure/formatter.md](configure/formatter.md)
- **The `field_slideshow_pager` plugin type (Thumbnails, Counter) and how to add your own** →
  [plugins/pager.md](plugins/pager.md)

Key facts:
- Formatter id `slideshow` (`FieldSlideshow` extends core `ImageFormatter`), field type `image`.
- Settings stored in `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.settings` (`slideshow`, `slideshow_pager`, `colorbox_image_style`).
- Runtime needs `/libraries/jquery.cycle2/jquery.cycle2.min.js` installed (asset library
  `field_slideshow/field_slideshow.cycle2`); swipe adds `cycle2swipe`.
- Theme hook `field_slideshow` → `templates/field-slideshow.html.twig`; JS settings go to
  `drupalSettings.field_slideshow[<id>]`.
- The `config/schema` is slightly stale vs `defaultSettings()` (schema has `deley`, lacks `autoHeight`);
  trust `defaultSettings()`.
