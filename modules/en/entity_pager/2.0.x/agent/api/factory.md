# API: entity_pager.factory and the EntityPager object

The rendering logic lives in an `EntityPager` value object built per View by the
`entity_pager.factory` service. You rarely call this directly — the theme layer does — but it
is the module's only public service.

## Service

`entity_pager.factory` → `Drupal\entity_pager\EntityPagerFactory`
(args: `@token`, `@language_manager`, `@current_route_match`, `@request_stack`).

```php
$pager = \Drupal::service('entity_pager.factory')->get($view_executable);
```

`get(ViewExecutable $view)` returns a `Drupal\entity_pager\EntityPagerInterface`.

## EntityPagerInterface

| Method | Returns |
|---|---|
| `getView()` | the `ViewExecutable`. |
| `getEntity()` | the current-page content entity (from the route's `entity:*` param or request `entity` attribute), or `NULL`. |
| `getLinks()` | filtered array of render arrays keyed `prev` / `all` / `next` (empty entries dropped). |
| `getOptions()` | the style plugin options array. |

Non-interface helpers on the class: `getCurrentRow()` (int index of the current entity in the
view result, or `FALSE`).

## How a link is built (`getLink`)

For prev (`offset -1`) and next (`offset +1`): it takes the result row at
`currentRow + offset`, resolves its entity (via the configured relationship if set, else
`$row->_entity`), detokenises the label against that entity, and links to the entity's
`canonical` URL (current-language translation when present). If there is no such row and
`show_disabled_links` is on, it emits a disabled `<nolink>` link with class `inactive`;
`circular_paging` instead wraps to the opposite end.

The "All" link (`getAllLink`) is rendered only when `display_all` is TRUE: it detokenises
`link_all_url` (a URI/scheme → `Url::fromUri`, otherwise `Url::fromUserInput`) and
`link_all_text` against the current entity.

## Preprocess wiring

`template_preprocess_entity_pager()` (in `entity_pager.module`) calls the factory, then sets the
template variables `links`, `current` (`getCurrentRow() + 1`, or NULL), `count`
(`view.total_rows`), `display_count`, and attaches the `entity_pager/entity-pager` library and
the `url.path` cache context.
