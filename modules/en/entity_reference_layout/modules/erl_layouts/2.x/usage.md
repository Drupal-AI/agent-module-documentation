Submodule of Entity Reference with Layout (project machine name still `entity_reference_layout`) that ships a set of ready-made one-, two- and three-column Layout Discovery layouts with per-layout and per-region configurable CSS classes and background colors.

---

`erl_layouts` (labeled "Aten Layouts") declares nine column layouts in
`erl_layouts.layouts.yml` (One Column, Two Column 1:1 / 1:2 / 2:1, Three Column 1:1:1 / 2:1:1 /
1:2:1 / 1:1:2), all rendered by the shared `templates/layouts/columns.html.twig` and the
`ErlLayout` plugin class. `ErlLayout` adds a configuration form (classes + background color for
the layout and for each region) whose input mode is controlled by a
`hook_field_widget_third_party_settings_form` on the ERL widget: for classes and for colors,
each can be set to **manual** (author free-texts a value), **select** (author picks from a
site-builder-defined `key|label` list) or **force** (a fixed value applied automatically). The
chosen classes/colors are applied to the layout and region wrappers at build time. It depends
only on `layout_discovery`; although shipped with ERL, the layouts are usable by anything built
on Layout Discovery.

---

- Provide standard 1/2/3-column layouts for ERL sections without hand-writing layout YAML.
- Offer editors a One Column layout for simple stacked content.
- Offer 1:1, 1:2 and 2:1 two-column splits.
- Offer 1:1:1, 2:1:1, 1:2:1 and 1:1:2 three-column arrangements.
- Let authors add free-text CSS classes to a layout ("manual" mode).
- Restrict authors to a curated list of layout/region classes ("select" mode).
- Force a fixed class onto every layout or region ("force" mode).
- Let authors set a background color per layout or per region.
- Restrict background colors to a predefined palette (`#fff|White` style list).
- Force a background color automatically across sections.
- Give each region (header/primary/secondary/tertiary/footer) its own classes.
- Provide a consistent column grid via the bundled `erl_layouts` CSS library.
- Reuse the layouts in Layout Builder or Display Suite (any Layout Discovery consumer).
- Support a right-to-left "column priority" main-content ordering in the template.
- Prototype page grids quickly on a paragraphs+layout site.
- Standardize section styling options offered to content authors.
