<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The formatter: settings, pagination, AJAX-link integration

Single class: `EntityReferencePaginationFormatter` in
`src/Plugin/Field/FieldFormatter/EntityReferencePaginationFormatter.php`, declared with the
`#[FieldFormatter]` attribute:

- id `entity_reference_pagination_formatter`, label "Rendered entity (Paginated)",
  description "Display the referenced entities rendered and paginated).",
  `field_types: ['entity_reference']`.
- Extends core `Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter`
  (the "Rendered entity" formatter), so it inherits that formatter's `view_mode` / `link` settings,
  its `settingsForm()`, `settingsSummary()` and `viewElements()`.

## Install / enable

`drush en entity_reference_pagination_formatter`. Composer requires `drupal/ajax_link ^1.0`
(info.yml dependency `ajax_link:ajax_link`). Then on any bundle's *Manage display*, set an
`entity_reference` field's formatter to **"Rendered entity (Paginated)"** and configure it. No
config objects, schema, routes or permissions are added by this module.

## Dependency injection

`create()`/`__construct()` extend the parent's service list with `request_stack`; the current
request is stored in `$this->currentRequest`. Injected parent services: `logger.factory`,
`entity_type.manager`, `entity_display.repository`.

## Settings (`defaultSettings()`)

Merged on top of `parent::defaultSettings()` (which supplies `view_mode` and `link`):

| Setting | Default | Form element | Meaning |
| --- | --- | --- | --- |
| `index_name` | `page` | textfield, required | Query-parameter name that holds the current page index. Also part of the wrapper id, so distinct names let several paginated fields coexist on one page. |
| `items_per_page` | `10` | textfield, required | Referenced entities rendered per page. |
| `ajaxlink_method` | `replace` | select (`replace`\|`append`) | Whether the next page replaces the current items or is appended below (emitted as `data-ajax-link-method`). |
| `ajaxlink_auto` | FALSE | checkbox | Adds class `ajax-link-auto` so `ajax_link` auto-triggers the link when displayed. |
| `ajaxlink_history` | FALSE | checkbox | Adds `data-ajax-link-history=1` to push pagination into browser history. |
| `ajaxlink_remove_after_execution` | FALSE | checkbox | Adds `data-ajax-link-remove-after-execution=1` so the link is removed once used. |

`settingsForm()` appends these elements to the parent form; `settingsSummary()` appends lines for
the index name, items-per-page, the replace/append mode, and one line each for the enabled AJAX
flags.

## Pagination mechanism (`view()`)

The class overrides `view()` (not `viewElements()`):

1. Reads `items_per_page` and `index_name` from settings; `$index_current = (int) request query
   get(index_name, 0)`.
2. Builds `$items_entity_ids[$index] = $item->entity->id()` for every field item, then
   `array_chunk($items_entity_ids, $items_per_page)`. If the requested chunk index does not exist,
   returns an (essentially empty) render array with `url.path` + `url.query_args` cache contexts.
3. Takes the current chunk's ids and `$items->filter()`s the field item list down to items whose
   `$item->entity->id()` is in that chunk, then calls
   `parent::view($items_current_page, $langcode)`. The parent path renders through
   `getEntitiesToView()`, so the **rendered referenced entities honour entity view access and the
   view-mode display settings**.
4. Computes `$wrapperId = "field--name-{field}--ajax-wrapper--{index_name}"` and, **if the next
   chunk exists**, appends a "Next page" link:
   - `#type => 'link'`, `#title => t('Next page')`, `#url => Url::fromRoute('<current>', [], ['query'
     => [index_name => index_current+1] + currentRequest->query->all()])`.
   - `#attributes`: `class => ['ajax-link']`, `data-ajax-link-selector => "#$wrapperId"`,
     `data-ajax-link-method => ajaxlink_method`; plus the optional flag attributes above.
   - `#attached => ['library' => ['ajax_link/ajaxLink']]`.
   The link index is placed after the parent's items (`$elements['#items']->count()`, skipping any
   already-set numeric keys).
5. Sets `$elements['#attributes']['id'][] = $wrapperId` and re-adds the two `url.*` cache contexts.

There is **no custom AJAX route or controller** in this module: the "Next page" link is an ordinary
link back to the *current* page URL with an incremented index. Without JS it reloads the page and
re-renders the field at the new index; with `ajax_link` the client library fetches that URL and
replaces/appends the wrapper's contents. Because the page index is only a query parameter read
against the same field on the same entity being viewed, pagination cannot address a different entity
or field.

## Notes / caveats

- `view()` calls `$item->entity->id()` directly while building the id list; a broken reference whose
  target entity no longer loads (`$item->entity` null) would error there rather than being skipped.
  Content-editor-managed references, so this is a robustness note.
- Each page renders its chunk of the field's items through the standard rendered-entity (parent)
  path, which applies the usual view-access filtering to what it displays.
- Cache varies by `url.path` and `url.query_args`, i.e. per page index and per path.
