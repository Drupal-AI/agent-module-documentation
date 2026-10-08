Masonry Views adds a "Masonry" Views **style plugin** that renders a view's results as a cascading, gap-filling masonry grid (like Pinterest), delegating the actual layout to the separate Masonry module's jQuery Masonry integration.

---

The module provides a single Views style plugin (`@ViewsStyle(id = "masonry")`, title "Masonry", theme `views_view_masonry`) that you select as a view display's **Format**. It uses a row plugin, supports per-row CSS classes and grouping (`usesRowPlugin`, `usesRowClass`, `usesGrouping` are all TRUE). All of the layout options — column width, gutter width, resizable/animated behaviour, images-loaded handling, lazy-load selectors, stamps, RTL, etc. — are not defined by this module; they come from the required **Masonry** module's `masonry.service` (`getMasonryDefaultOptions()` / `buildSettingsForm()`), so the style's options form is just a thin "Masonry" fieldset over that service, and the chosen values are stored in the view display's `style.options`. At render time, `masonry_views_preprocess_views_view_masonry()` wraps each result in a `.masonry-item` element inside a `.masonry-layout-<view_id>` container and calls `masonry.service->applyMasonryDisplay()` to attach the JS/library that lays the items out; `masonry_views_preprocess_views_view()` tags the rows container with `data-drupal-masonry-layout`. The module has no configuration page, permissions, schema, entities, or Drush commands of its own — it is purely a Views format, and it degrades to a message ("options disabled") if the jQuery Masonry library is not installed.

---

- Display a view of nodes, media, or images as a Pinterest-style cascading grid.
- Build a portfolio or gallery grid where items have varying heights and pack together.
- Turn an existing content listing view into a masonry layout by changing its Format.
- Show a masonry grid of teaser cards using a rendered-entity row plugin.
- Add per-row CSS classes to masonry items for custom card styling.
- Group masonry results into sections (grouping) while keeping the masonry packing per group.
- Configure the gutter (gap) width between masonry items via the style options.
- Enable a resizable masonry layout that re-packs when the viewport changes.
- Animate item repositioning with a configurable animation duration.
- Force item widths for a uniform-column masonry grid.
- Lay out images that only pack once they have finished loading (images-loaded first).
- Integrate lazy-loaded images by pointing masonry at the lazyload/lazyloaded CSS selectors.
- Support right-to-left masonry layouts automatically for RTL languages.
- Use "stamp" elements that masonry flows content around.
- Create a responsive blog or news grid without writing custom layout JavaScript.
- Present a tag/term listing as a compact masonry wall.
- Combine masonry with Views exposed filters so users refilter a masonry grid.
- Provide a masonry gallery display alongside a default table/grid display of the same view.
- Style the masonry container with the predictable `.masonry-layout-<view-id>` selector.
- Target individual cells with the `.masonry-item` class for hover/overlay effects.
- Add a masonry display to an EVA (entity view attachment) view (preprocess hook supports it).
- Lay out product cards, testimonials, or team members in a gap-free grid.
- Migrate a legacy jQuery-masonry front-end to a maintainable Views-driven grid.
