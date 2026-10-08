# Theming facets

Theme hooks (`facets_theme()` in `facets.module`), templates in `templates/`:

| Theme hook | Template | Key variables |
|---|---|---|
| `facets_item_list` | `facets-item-list.html.twig` | `facet`, `items`, `title`, `list_type` (ul/ol), `wrapper_attributes`, `attributes`, `empty`, `context` |
| `facets_result_item` | `facets-result-item.html.twig` | `facet`, `raw_value`, `value`, `show_count`, `count`, `is_active` |
| `facets_views_plugin` | `facets-views-plugin.html.twig` | `content` (facets rendered inside a view) |

## Template suggestions
`hook_theme_suggestions_facets_result_item()` adds, per result item:
- `facets_result_item__<widget_type>` (e.g. `facets-result-item--checkbox.html.twig`)
- `facets_result_item__<widget_type>__<facet_id>`

So you can theme a single facet or a whole widget type by dropping a matching template in
your theme.

## Libraries (`facets.libraries.yml`)
`facets/widget` (base), `facets/drupal.facets.checkbox-widget`,
`drupal.facets.dropdown-widget`, `soft-limit`, `drupal.facets.hierarchical`,
`drupal.facets.general` (CSS), `drupal.facets.admin_css`. Widgets attach these via their
`build()`; override CSS/JS by extending or replacing the library in your theme.
