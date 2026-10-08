# View Marquee — agent index

A single Views **style** plugin that wraps a view's rows in an HTML `<marquee>`. Depends on
core `views`. No config page (`configure` null), no permissions, no Drush, no config schema,
no submodules. All configuration is per view display in the style options form.

- **The style plugin, every option, the theme/template, and how options map to `<marquee>` attributes** →
  [configure/style.md](configure/style.md)

Key facts:
- Style id `view_marquee`, class `Drupal\view_marquee\Plugin\views\style\ViewMarquee`, theme
  `views_view_view_marquee`, template `templates/views-view-view-marquee.html.twig`.
- Options: `row_class`, `direction` (left/up/right/down), `behavior` (scroll/alternate),
  `speed` (→ `scrollamount`), `delay` (→ `scrolldelay`), `mouseover` (pause on hover).
- Preprocess `template_preprocess_views_view_view_marquee()` in `view-marquee.theme.inc`
  builds the raw attribute strings; CSS library `view_marquee/marquee-style`.
- `<marquee>` is a deprecated HTML element — functional but non-standard.
