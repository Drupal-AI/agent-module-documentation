# Views Exposed Form Layout (VEFL) — agent index

Adds a Views **exposed form style** that places each exposed filter/sort/action into the regions
of a Layout API layout, instead of one flat row. No admin settings page (`configure` = null);
you configure it per view. Depends on `views` + `layout_discovery`. Submodule `vefl_bef` does the
same for Better Exposed Filters.

- **Turn it on for a view + the option keys (`layout_id`, `widget_region`)** →
  [configure/exposed-form.md](configure/exposed-form.md)
- **Template/theme override (`vefl_views_exposed_form` hook, region output)** →
  [theming/template.md](theming/template.md)
- **Define custom layouts / the `vefl.layout` service / form actions** →
  [extend/layouts.md](extend/layouts.md)

Key facts:
- Exposed form plugin id: **`vefl_basic`** (title "Basic (with layout)"), class `VeflBasic`
  extends core `Basic`, shares logic in `VeflTrait`.
- Stored in the view's `display_options.exposed_form.options.layout`:
  `layout_id` (e.g. `vefl_onecol`) and `widget_region` = `{ <widget_id>: <region_id> }`.
- Widget ids include each exposed filter identifier plus actions `sort_by`, `sort_order`,
  `items_per_page`, `offset`, `submit`, `reset` (see `Vefl::getFormActions()`).
- Ships one layout `vefl_onecol` (region `middle`) in `vefl.layouts.yml`; any layout_discovery /
  Display Suite / Panels layout also works.
- Service `vefl.layout` (`Drupal\vefl\Vefl`): `getLayouts()`, `getLayoutOptions()`,
  `getFormActions()`. No permissions, no Drush, no plugin managers.
