# Better Exposed Filters Layout (vefl_bef) — agent index

VEFL submodule. Adds a Views exposed form style **`vefl_bef`** ("Better Exposed Filters (with
layout)") that combines Better Exposed Filters widgets with VEFL's region placement. Requires
`vefl` + `better_exposed_filters`. Same config shape and rendering as the base `vefl_basic` plugin
(see the parent module's `configure/exposed-form.md` and `theming/template.md`).

- **Enable it on a view + what vefl_bef adds over vefl_basic** →
  [configure/exposed-form.md](configure/exposed-form.md)

Key facts:
- Plugin id **`vefl_bef`**, class `VeflBef` extends BEF's `BetterExposedFilters` and `use`s
  `Drupal\vefl\Plugin\views\exposed_form\VeflTrait`.
- Config stored under a view's `display_options.exposed_form`: `type: vefl_bef`, `options.layout`
  (`layout_id`, `widget_region: {<widget_id>: <region_id>}`) plus the full BEF `options.bef` tree.
- Extra region-assignable items beyond vefl_basic: **`secondary`** ("Secondary exposed form
  options", visible when BEF `allow_secondary` is on) and **`sort_bef_combine`** ("Combine sort
  order with sort by", visible when BEF's combined sort is on).
- No permissions, Drush, plugin managers, or settings page of its own.
