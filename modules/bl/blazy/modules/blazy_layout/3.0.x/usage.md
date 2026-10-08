Blazy Layout provides a single, dynamic-region Layout Builder layout whose regions and grid can be configured on the fly, backed by Blazy's grid and media handling.

---

Blazy Layout adds one flexible Layout Builder layout plugin (`blazy_layout`, class `BlazyLayout`) that ships with up to nine predefined regions (main, feature, sidetop, sidebar, sidebelow, two footer-middle, two footer regions). Unlike fixed multi-column layouts, its column count, region widths, gaps, and breakpoints are configured dynamically through an admin form (`BlazyLayoutAdmin`) when placing the section, so a single layout can express many arrangements. It depends on core `layout_discovery` and on `blazy`, reusing Blazy's manager (`blazy_layout` service extends `blazy.manager`) for responsive grid math and lazy media. This makes it well suited to content-rich sections that mix media and text without needing a separate layout plugin for every column configuration. It integrates with Layout Builder wherever Layout Builder is enabled (entity view displays, and via contrib, standalone landing pages).

---

- Add a single reusable section that supports many column arrangements in Layout Builder.
- Build responsive multi-region sections without defining a new layout per variant.
- Configure column count and region widths dynamically when placing a section.
- Create media-rich landing-page rows that reuse Blazy's grid engine.
- Lay out a main + sidebar + footer structure from one layout plugin.
- Set per-breakpoint gaps and widths for a section.
- Compose hero + feature + sidebar arrangements on a node's Layout Builder display.
- Provide a footer with multiple aligned regions.
- Mix lazy-loaded images and text blocks within a dynamic grid.
- Reduce the number of installed single-purpose layout plugins.
- Use the `blzyr_*` regions to place blocks/fields precisely.
- Build editorial "magazine" sections with uneven columns.
- Reuse Blazy responsive settings for consistent grids across sections.
- Prototype layouts quickly by adjusting region settings instead of editing YAML.
- Apply the dynamic layout to custom entity view displays.
- Give editors flexible section options within governed Layout Builder.
- Create equal-height card rows leveraging Blazy grid CSS.
- Combine with Blazy field formatters for fully lazy-loaded sections.
- Standardize section spacing across a site via the layout admin form.
- Support decoupled-friendly structured regions for front-end rendering.
