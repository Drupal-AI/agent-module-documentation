Bootstrap Layout Builder (BLB) adds Bootstrap grid rows and columns as section layouts to core Layout Builder, so editors build responsive multi-column sections and style them without writing CSS.

---

BLB registers a single core Layout plugin (`bootstrap_layout_builder`) whose derivatives are generated from `blb_layout` config entities — one per column count (1 to 12 columns out of the box). Each derived layout renders a Bootstrap `row` with the chosen number of column regions, wrapped in an optional `container` / `container-fluid` / edge-to-edge wrapper. When configuring a section, the editor gets a tabbed UI (Layout / Style / Settings): the Layout tab exposes a per-breakpoint column-structure chooser (Mobile, Tablet, Desktop `blb_breakpoint` entities), a container-type radio, and a gutters on/off toggle; the Style tab embeds the `bootstrap_styles` module's style groups (background color, image/video, spacing, etc.) applied to the container wrapper; the Settings tab holds advanced free-text classes and YAML attributes for the row, columns, and container. Which column split each breakpoint offers is controlled by `blb_layout_option` config entities (e.g. "Two equal columns" = `6 6`, "25/75" = `3 9`), and the actual Bootstrap classes come from each breakpoint's `base_class` (`col`, `col-md`, `col-lg`). A global settings form (`bootstrap_layout_builder.settings`) toggles live preview, hides advanced settings, and sets the one-column class. Breakpoints, layouts, and layout options are all manageable as config entities under Admin → Config → Content → Bootstrap Layout Builder, and everything exports as configuration. It depends on `bootstrap_styles` for the styling engine and on core `layout_builder` for the layout system itself.

---

- Add a two-, three-, or four-column Bootstrap row as a Layout Builder section.
- Build a full 12-column grid section and split columns however you need.
- Choose a different column structure per breakpoint (e.g. stacked on mobile, 3 columns on desktop).
- Pick a boxed `container`, full-width `container-fluid`, or edge-to-edge (`w-100`) section wrapper.
- Toggle Bootstrap gutters on or off for a row via the Layout tab.
- Apply a background color, image, or local video to a section using the embedded bootstrap_styles Style tab.
- Add custom utility classes (e.g. `py-5 bg-warning`) to the row, columns, or container wrapper.
- Add arbitrary HTML attributes to rows/columns/containers as YAML in the Settings tab.
- Preview column and style changes live in the Layout Builder canvas without saving.
- Define a new custom breakpoint (e.g. XL) as a `blb_breakpoint` config entity with its own `base_class`.
- Add a new column layout (e.g. a 6-column row) by creating a `blb_layout` config entity.
- Create a custom column split (e.g. `4 4 4` or `2 8 2`) as a `blb_layout_option`.
- Restrict which column options appear for a given breakpoint via the layout-options form.
- Set the CSS class used for one-column sections site-wide (default `col-12`).
- Hide the advanced Settings tab from editors to keep the UI simple.
- Enable or disable AJAX live preview globally for all BLB sections.
- Reorder breakpoints (Mobile/Tablet/Desktop) by weight to control column-chooser order.
- Gate access to BLB configuration with the `configure bootstrap layout builder` permission.
- Export all breakpoints, layouts, and layout options as configuration to deploy across environments.
- Use BLB layouts on any Layout Builder-enabled entity view mode (content types, media, users).
- Give editors a Bootstrap-native page builder without a custom theme layout for each grid.
- Combine BLB grid sections with bootstrap_styles styles for landing pages.
- Theme the section/container/wrapper output via the `blb_section`, `blb_container`, and `blb_container_wrapper` templates.
- Set default column structures for each breakpoint so new sections start sensibly.
- Add responsive column classes automatically from each breakpoint's base class plus the chosen structure.
