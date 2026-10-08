Views Flexbox adds a **Flexbox** Views *style* plugin that renders the results of any View as a CSS flexbox container instead of an HTML table or grid, with UI controls for direction, justification and alignment plus an optional "Card" theme.

---

The module registers one Views style plugin (`id: flexbox`, class `Flexbox` extending `StylePluginBase`, `usesRowPlugin = TRUE`) whose options form lets you set flex `direction` (row / row-reverse / column / column-reverse), `justify` content, `align_items`, `align_content`, a `style` preset (`_none_` or `cards`), whether to add default per-item classes (`item-N`), and custom item classes. Each rendered row becomes a `.views-flexbox-item` inside a `.views-view-flexbox` wrapper via the `views-view-flexbox.html.twig` template (theme hook `views_view_flexbox`, preprocessed by `template_preprocess_views_view_flexbox`). The chosen flex settings are emitted as modifier classes on the wrapper (`views-flexbox-direction-row`, `views-flexbox-justify-center`, etc.) and the layout is realized by the module's CSS libraries (`views_flexbox/views_flexbox`, plus `views_flexbox/views_flexbox.cards` when the Card style is selected). When "Link to content" is enabled (Card style only), each item is wrapped in an `<a>` whose href comes from a token-replaceable `link_source` field, or falls back to the row entity's canonical URL. Custom item classes and link sources support Views field replacement tokens (only when the display uses fields). There is no global settings page (`configure` is null), no permissions, and no Drush commands — everything is configured per View display in the Views UI. Note the config schema (`views.style.flexbox`) is slightly out of sync with the plugin: `justify` is typed `boolean` and the `link_to_content`/`link_source` keys are not declared, so those settings rely on Views' generic handling.

---

- Lay out a View's results as a responsive flexbox row that wraps on small screens instead of a rigid grid.
- Render a card/tile listing of nodes with the built-in "Card Layout" style.
- Make each card in a listing clickable, linking to the node's canonical page.
- Link cards to an arbitrary URL built from Views field tokens (e.g. `{{ field_external_url }}`).
- Arrange teasers in a horizontal row (`flex-direction: row`) with even spacing (`space-between`).
- Stack items vertically on a page region using `flex-direction: column`.
- Reverse the visual order of results with `row-reverse` / `column-reverse` without changing the query sort.
- Center a small set of results horizontally and vertically with `justify: center` + `align_items: center`.
- Distribute items with `space-around` / `space-evenly` for a gallery-style layout.
- Align items to the start, end, center, stretch or baseline of the cross axis.
- Control multi-line wrapping alignment with `align_content` (start/end/center/stretch/space-between/space-around).
- Strip the default `item-N` classes to reduce markup weight when you don't need per-item CSS hooks.
- Add your own space-separated CSS classes to every item for theme styling.
- Build a logo wall / partner grid that reflows automatically across breakpoints.
- Create a related-content strip beneath an article using a flexbox row of teasers.
- Replace a core Grid-format View with flexbox to get gap/alignment control the grid style lacks.
- Theme the output further by targeting the generated modifier classes in your theme's CSS.
- Provide a mobile-friendly product/feature listing without writing layout CSS from scratch.
- Use tokenized per-item classes to color-code cards by a field value.
- Combine with any Views row plugin (fields, entity/teaser rendering) since the style uses row plugins.
- Prototype card layouts quickly in the Views UI before committing to a custom template.
