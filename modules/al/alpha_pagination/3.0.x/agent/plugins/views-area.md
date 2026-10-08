<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views area handler — Global: Alpha Pagination

`Drupal\alpha_pagination\Plugin\views\area\AlphaPaginationArea` (final, extends `AreaPluginBase`).
Annotation `@ViewsArea("alpha_pagination")`; registered by `alpha_pagination_views_data()` as
`views.alpha_pagination` (title "Alpha Pagination", group "Custom Global"). This is the plugin you add
to a View's **Header** or **Footer** to render the paginator. `label()` returns `''`.

## Setup (from `hook_help` / project docs)

1. Build a View of nodes, users, comments, taxonomy terms or media.
2. Add the field you want to group on (title, name, or any text/string field). You may exclude it from
   display. Only `text`, `text_long`, `text_with_summary`, `string`, `string_long` (and the compound
   `name`) field types are offered.
3. Add **Global: Alpha Pagination** to the header or footer.
4. Add a **contextual filter** on the same field, with **Glossary** mode on, **character limit 1**, and
   **Transform case = Upper**. The last URL argument becomes the selected letter.
5. Configure the handler options (below). Optionally scope to the current display only.

Exactly one alpha-pagination area per display is allowed; `validate()` (delegated to
`AlphaPagination::validate()`) errors if zero or more than one is configured on a display that also
uses the group field.

## Options (`defineOptions()`, all prefixed `paginate_`)

- Source: `paginate_view_relationship` (default `none`), `paginate_view_field` (default `title`).
- Link: `paginate_link_path` (default `[alpha_pagination:path]/[alpha_pagination:value]`),
  `paginate_link_external` (0), `paginate_link_class`, `paginate_link_attributes`
  (`key|value,key|value`, token-aware).
- Classes: `paginate_class` (`alpha-pagination`), `paginate_list_class` (`alpha-pagination-list`),
  `paginate_active_class` (`active`), `paginate_inactive_class` (`inactive`).
- "All" item: `paginate_all_display` (1), `paginate_all_class` (`all`), `paginate_all_label` (All),
  `paginate_all_value` (`all`), `paginate_all_position` (`after`), `paginate_toggle_empty` (1 = show
  letters without results).
- Numeric: `paginate_view_numbers` (`0` none / `1` individual 0-9 / `2` single `#` label),
  `paginate_numeric_class`, `paginate_numeric_divider` (1) + `paginate_numeric_divider_class` (`-`),
  `paginate_numeric_hide_empty` (1), `paginate_numeric_label` (`#`), `paginate_numeric_position`
  (`before`), `paginate_numeric_value` (default `0+1+2+3+4+5+6+7+8+9`).

These options are stored inside the View config (the area handler's options); the module ships **no**
config schema of its own.

## Form / submit

- `buildOptionsForm()` — builds all the `#fieldset`-grouped elements. The source-field select is built
  from `EntityFieldManager::getFieldMap()` filtered to the allowed field types; `taxonomy_term_data`
  and `media_field_data` base tables expose only `name`. Compound `name` fields expand to
  `entity__name:column` options.
- `submitOptionsForm()` — invalidates the character cache (`cacheBackend->invalidate($alphaPagination->getCid())`)
  and runs `Xss::filterAdmin()` over `paginate_link_attributes` before saving.

## Render (`render()`)

Builds a render array: a `container__alpha_pagination__wrapper` theme wrapper (attaches library
`alpha_pagination/alpha_pagination`) containing an `item_list__alpha_pagination`. Iterates
`AlphaPagination::getCharacters()`; each `AlphaPaginationCharacter::build()` yields a `#type => link`
(active/enabled letters) or a `span` `html_tag` (inactive). Per-item wrapper classes are added for
all/numeric/active/inactive states. Divider characters render as an empty class-only `<li>`. Titles
and attributes go through core's render pipeline (auto-escaped). `postExecute()` calls
`AlphaPagination::ensureQuery()` so the compiled View SQL is captured for the prefix query.
