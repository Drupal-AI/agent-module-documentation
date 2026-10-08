<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity reference pagination formatter (entity_reference_pagination_formatter) — agent index

A single **field formatter** that renders an `entity_reference` field's referenced entities **a page at a time** with a "Next page" link (click or AJAX auto-load). Package `Fields`. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.0.

- **The formatter, its settings, the pagination mechanism, and the AJAX-link integration** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferencePaginationFormatter` (id **`entity_reference_pagination_formatter`**, label *"Rendered entity (Paginated)"*), in `src/Plugin/Field/FieldFormatter/EntityReferencePaginationFormatter.php`, **extending core's `EntityReferenceEntityFormatter`** ("Rendered entity"). `field_types = { "entity_reference" }`.
- No routes, no controllers, no permissions, no services, no hooks, no config objects/schema, no Drush. It changes only how an entity_reference field is **displayed**; selected per view-display on *Manage display*.
- **Dependency:** requires `ajax_link:ajax_link` (composer `drupal/ajax_link ^1.0`). The formatter attaches the `ajax_link/ajaxLink` library and emits `data-ajax-link-*` attributes on the next-page link; `ajax_link` provides the client behaviour.

## Mechanism (from source, `view()`)

- Reads the page index from the request query param named by the `index_name` setting (default `page`), cast to int (default 0).
- Collects every item's `$item->entity->id()`, `array_chunk()`s the id list by `items_per_page`, and keeps only the current chunk; the field item list is then `filter()`ed to that chunk and passed to `parent::view()` (core rendered-entity output, which honours entity view access).
- If a next chunk exists, appends a `#type => 'link'` "Next page" to a `<current>` route URL carrying `index_name => index+1` plus existing query args, with `class ajax-link`, `data-ajax-link-selector`/`-method` and the `ajax_link/ajaxLink` library; optional `ajax-link-auto`, `data-ajax-link-history`, `data-ajax-link-remove-after-execution` from settings.
- Wrapper id `field--name-{field}--ajax-wrapper--{index_name}`; cache contexts `url.path` + `url.query_args`.

## Settings (`defaultSettings()`, on top of the parent's `view_mode`/`link`)

`index_name` (`page`), `items_per_page` (`10`), `ajaxlink_method` (`replace`|`append`), `ajaxlink_auto` (FALSE), `ajaxlink_history` (FALSE), `ajaxlink_remove_after_execution` (FALSE). Full detail in [fields/formatter.md](fields/formatter.md).
