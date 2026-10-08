Views Bootstrap 5 adds a set of Views style plugins that render view results as common Bootstrap 5 components — cards, carousels, accordions, tabs, grids, list groups, dropdowns, media objects, and styled tables.

---

The module extends core Views with nine additional "Format" (style) plugins built for the Bootstrap 5 markup and utility-class conventions. When configuring a view's display you pick one of the Bootstrap styles and fill in a settings form specific to that component — for example choosing which field supplies a card's title/image/body, the carousel interval and autoplay behavior, accordion grouping and open/closed behavior, tab type and position, or responsive column counts for the grid. Each style ships a Twig template (`views-bootstrap-*.html.twig`) so the exact markup is overridable, and the module registers per-view/per-display theme suggestions (e.g. `views_bootstrap_cards__myview`) so you can target individual views. It depends only on core Views and expects a Bootstrap 5 theme (or the Bootstrap framework CSS/JS) to be present to supply the actual styling and interactive behaviors; a small JS library is bundled for carousel helpers. There is no global admin settings page — all configuration lives inside each view's style options and is stored as view config, so it is exportable and deployable. It is a quick way to produce responsive, component-based listings without hand-writing Bootstrap markup.

---

- Display a listing of nodes as a responsive Bootstrap card grid.
- Build an image carousel/slider from a view of media or articles.
- Render a FAQ view as a Bootstrap accordion, one item per result.
- Group accordion content by a field value instead of one item per row.
- Present tabbed content with tabs, pills, or a vertical list layout.
- Position tabs on the top, left, right, bottom, or justified.
- Lay out results in a responsive multi-column grid with per-breakpoint columns.
- Output a Bootstrap list group from a view.
- Create a dropdown menu populated by view results.
- Render a media-object layout (image beside heading and body text).
- Show a striped, bordered, hover, or condensed Bootstrap table.
- Make a Views table horizontally responsive at a chosen breakpoint.
- Add captions to carousel slides that hide below a chosen breakpoint.
- Autoplay a carousel on load or after user interaction with configurable interval.
- Pause a carousel on hover and enable keyboard navigation.
- Select which fields supply a card's title, image, and content.
- Display fully rendered row content inside card bodies instead of selected fields.
- Apply custom wrapper/row/column CSS classes to card and grid layouts.
- Override a component's markup via its `views-bootstrap-*.html.twig` template.
- Target a single view with a per-view theme suggestion (e.g. `views_bootstrap_cards__myview`).
- Build a product listing with cards for a Bootstrap-themed commerce site.
- Create a homepage hero slider without custom code.
- Deploy Bootstrap-styled listings as exportable view configuration.
