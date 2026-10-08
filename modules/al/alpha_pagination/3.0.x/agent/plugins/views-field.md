<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field handler — Alpha Pagination group

`Drupal\alpha_pagination\Plugin\views\field\AlphaPaginationGroup` (final, extends `FieldPluginBase`).
Annotation `@ViewsField("alpha_pagination_group")`; registered by `alpha_pagination_views_data()` as
`views.alpha_pagination_group`. It is an **automated grouping field**: it does not alter the query
(`query()` is intentionally empty) and is excluded from output by default.

## Purpose

Emits the single grouping character for each result row — the uppercased first character of the
handler's configured source field (`paginate_view_field`, read from the area handler). Intended to be
used with Views grouping / an in-page `#`-anchor scheme so rows can be grouped under their letter and
linked to from the paginator.

## Behaviour

- `defineOptions()` forces `label = ''`, `element_label_colon = FALSE`, `exclude = TRUE`.
- `submitOptionsForm()` hides every form child except `more` / `ui_name` (it is auto-computed, nothing
  to configure).
- `render(ResultRow)`:
  1. Gets the display's alpha-pagination area handlers via `AlphaPagination::getAreaHandlers()`;
     returns `''` if none.
  2. Rebinds the service to the first area handler, reads `paginate_link_path` and the
     `paginate_view_field` (splitting `entity__field`).
  3. Renders the underlying field (`$field->renderText()`), then takes
     `mb_strtoupper(substr(strip_tags($field->last_render), 0, 1))` as the value and resolves it
     through `AlphaPagination::getValue()` / `getLabel()`.
  4. If `paginate_link_path` starts with `#`, wraps the label in an `html_tag__alpha_pagination__anchor`
     `<a name="…">` (token-replaced) so it becomes an in-page anchor target.
- `validate()` delegates to `AlphaPagination::validate()` (same one-area-per-display rule as the area
  handler).

Because the source value is derived from an already-rendered View field and passed through core
render arrays / `strip_tags`, output is escaped by the render pipeline.
