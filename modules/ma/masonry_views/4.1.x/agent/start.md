# Masonry Views — agent index

Provides one **Views style plugin** — `masonry` ("Masonry") — that renders a view display as a
cascading masonry grid. Select it as a display's **Format**. Layout options come from the
required `masonry` module's `masonry.service`; this module only wires them into Views and
renders the markup. No config page, permissions, schema, or Drush.

- **Use the Masonry format on a view + the option keys + render markup/theming** →
  [configure/views-style.md](configure/views-style.md)

Key facts:
- Style plugin id `masonry`, theme hook `views_view_masonry`, template
  `templates/views-view-masonry.html.twig`. `usesRowPlugin` / `usesRowClass` / `usesGrouping`.
- Stored in the view display's `style: { type: masonry, options: {...} }`.
- Options (from `masonry.service->getMasonryDefaultOptions()`): `layoutColumnWidth`, `gutterWidth`,
  `isLayoutResizable`, `isLayoutAnimated`, `layoutAnimationDuration`, `isLayoutFitsWidth`,
  `isLayoutRtlMode`, `isLayoutImagesLoadedFirst`, `isLayoutImagesLazyLoaded`,
  `imageLazyloadSelector`, `imageLazyloadedSelector`, `stampSelector`, `isItemsWidthForce`,
  `isItemsPositionInPercent`, `extraOptions`.
- Requires the `masonry` module (>= 4.x) and its jQuery Masonry library; without the library the
  options are disabled and no layout is applied.
