Bootstrap Layouts registers a set of Bootstrap grid-based layout plugins (rows and responsive columns) for the core Layout system, so they appear anywhere Layout Discovery is consumed — Layout Builder, Display Suite, and Panels/Page Manager.

---

Bootstrap Layouts provides eleven ready-made layout plugins (`bs_1col`, `bs_1col_stacked`, `bs_2col`, `bs_2col_bricked`, `bs_2col_stacked`, `bs_3col`, `bs_3col_bricked`, `bs_3col_stacked`, `bs_4col`, `bs_4col_bricked`, `bs_4col_stacked`) declared in `bootstrap_layouts.layouts.yml` under the "Bootstrap" category, each mapping regions onto Bootstrap `.row`/`.col-*` markup. All layouts share one plugin class, `BootstrapLayoutsBase` (extending core `LayoutDefault`), which adds a configuration form: for the whole layout and for every region you can pick a wrapper element (div, span, section, article, header, footer, aside, figure), choose CSS classes from a grouped select (column widths `col-{xs,sm,md,lg}-{1..12}`, hidden/visible responsive classes, background and text color/alignment/transformation utilities, plus `row` and `clearfix`), toggle a layout-specific class and per-region `bs-region` classes, and add arbitrary attributes (with token support if the Token module is enabled). At render time `_bootstrap_layouts_preprocess_layout()` in the `.module` file turns those settings into wrapper elements, classes and attributes on the Twig templates in `templates/3.0.0/`. The module depends only on core `layout_discovery`; it ships no admin UI, routes, permissions or default config — configuration is stored per display by whichever consumer renders the layout (Layout Builder section config, Display Suite third-party settings, or a Panels variant). It defines two plugin types via annotation-based managers: `BootstrapLayoutsHandler` (handlers for `ds` and `page_manager` that load/save layout instances, extensible with your own) and `BootstrapLayoutsUpdate` (data-driven update plugins). Developers can alter the class option list with `hook_bootstrap_layouts_class_options_alter()`. It requires a Bootstrap-based theme (or one providing the grid classes) to actually style the output.

---

- Add a two-, three-, or four-column Bootstrap row as a section in Layout Builder.
- Give an entity view mode a Bootstrap grid layout through Display Suite.
- Lay out a Panels/Page Manager variant with a responsive Bootstrap layout.
- Choose a "stacked" variant that adds full-width top and bottom regions around the columns.
- Choose a "bricked" variant that interleaves full-width bands between column rows.
- Set a region's column width by picking `col-md-8` / `col-md-4` from the classes select.
- Make columns responsive by combining `col-sm-12` with `col-md-6` style classes.
- Hide or show a region at a breakpoint with `hidden-xs` / `visible-lg` classes.
- Change a region's wrapper element from `div` to `section`, `article`, `aside`, etc.
- Change the layout container's wrapper element and its classes (e.g. keep or drop `row`).
- Add background or text utility classes (`bg-primary`, `text-center`, `text-uppercase`) to a region.
- Add a `clearfix` utility to a region to control float clearing.
- Add custom HTML attributes to the layout or a region (e.g. `id|hero,role|banner`).
- Insert token values into layout/region attributes when the Token module is enabled.
- Toggle the automatic layout-specific class (e.g. `bs-1col`) on the container.
- Toggle the automatic `bs-region` and `bs-region--{name}` classes on each region.
- Provide Bootstrap grid layouts across a whole site by simply installing the module (no config needed).
- Rely on core Layout Discovery so the layouts show up in any Layout-aware tool.
- Register additional theme- or module-specific classes via `hook_bootstrap_layouts_class_options_alter()`.
- Write a custom `BootstrapLayoutsHandler` plugin to load/save layouts for another layout consumer.
- Define your own Bootstrap layout by adding an entry to a `*.layouts.yml` reusing `BootstrapLayoutsBase`.
- Override or theme a layout by copying the matching Twig template from `templates/3.0.0/`.
- Migrate a Drupal 7 Display Suite / Panels Bootstrap layout setup to Drupal 10/11.
- Build multi-region pages combining top/left/middle/right/bottom regions from the stacked layouts.
