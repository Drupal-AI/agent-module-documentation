<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig function: custom_entity_pager_insert()

Registered by `Drupal\custom_entity_pager\TwigExtensions\PaginatorExtension::getFunctions()`
as the Twig function `custom_entity_pager_insert`. Call it from any template that is
rendered on a node canonical page.

## Install / enable
`drush en custom_entity_pager -y`. No configuration follows — the module has no settings
form, no permissions, and no config objects.

## Signature
```
custom_entity_pager_insert(content_type, field_order = '', title = TRUE, inner_text = NULL)
```
(`PaginatorExtension::customEntityPagerInsert()`)

- `content_type` (string, required) — content-type machine name whose published nodes form the sequence.
- `field_order` (string, optional) — machine name of a node field to sort by; the module joins
  `node__<field_order>` and orders by `<field_order>_value` ASC. Must be a field, not a base column.
  Empty string (default) orders by `nid` ASC.
- `title` (bool, optional, default TRUE) — TRUE renders the `paginate_with_titles` template
  (links labelled with node titles); FALSE renders the `paginate` template (plain "prev"/"next").
- `inner_text` (string, optional, default NULL) — text rendered between the prev and next links.

## Behaviour
- Reads the current `node` route parameter via `@current_route_match`. If it is not a
  `Drupal\node\NodeInterface`, `$current_nid` stays NULL and the function returns `FALSE`
  (nothing rendered) — so it only produces output on actual node pages.
- On a node page it calls `custom_entity_pager.main_service`
  `getPaginator($content_type, $current_nid, $field_order)`, attaches `inner_text`, and returns a
  render array with `#theme` = `paginate` or `paginate_with_titles` and `#element` = the result.

## Templates (theme hooks from `custom_entity_pager_theme()`)
- `paginate` → `templates/paginate.html.twig`: renders `element.prev` / `element.next` as links to
  `entity.node.canonical` with the literal labels `'prev'|t` / `'next'|t`, plus optional `inner_text`.
- `paginate_with_titles` → `templates/paginate-with-titles.html.twig`: same links but labelled with
  `element.prev.title` / `element.next.title`.
- Both only emit a link when the neighbour is not null. Override the templates in your theme for
  custom markup/CSS — the module ships no styling.

## Examples (from README)
```
{{ custom_entity_pager_insert('article') }}
{{ custom_entity_pager_insert('article', 'field_date') }}
{{ custom_entity_pager_insert('article', 'field_date', TRUE) }}
{{ custom_entity_pager_insert('article', 'field_date', FALSE, 'Pager') }}
```
