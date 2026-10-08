# PrevNext service API

Service `prevnext.service` → `Drupal\prevnext\PrevNextService`
(`@config.factory`, `@entity_type.manager`, `@current_user`).

## Methods

```php
/** @var \Drupal\prevnext\PrevNextServiceInterface $pn */
$pn = \Drupal::service('prevnext.service');

// Render array of the enabled prev/next links for an entity (respects config,
// permissions, language, access, and caching). Empty array if type/bundle not
// enabled or user lacks permission.
$build = $pn->buildEntityLinks($node);

// Just the neighbour IDs: ['prev' => id|null, 'next' => id|null].
$ids = $pn->getPreviousNext($node);
```

## How neighbours are found (`getEntitiesOfType`)

For the entity's storage it builds an entity query:

- `condition('status', 1)` — published only.
- `condition(<bundle_key>, $entity->bundle())` and `condition(<langcode_key>, $entity->language())`
  when the type defines those keys.
- **previous**: `condition(id, $current, '<')` + `sort(id, 'DESC')`; **next**:
  `condition(id, $current, '>')` + `sort(id)`.
- `range(0, 1)`, `accessCheck()`, tag `prev_next_{type}_type` (alter the query via
  `hook_query_TAG_alter`).
- If empty and `prevnext_infinite_loop` is on, it re-runs without the id bound to grab the
  first/last sibling (wrap-around).

`buildEntityLinks()` short-circuits (returns `[]`) when: the entity type isn't in
`prevnext_enabled_entity_types`; the bundle isn't in `prevnext_enabled_entity_bundles`; or the user
holds neither `view prevnext links` nor `view {type} prevnext links`. Each link is built from the
`entity.{type}.canonical` route and rendered through the `prevnext` theme hook.

## Theming

Single theme hook `prevnext` (`templates/prevnext.html.twig`) with variables `direction`
(`previous`/`next`), `text`, `id` (`prev`/`next`), `url`, `entity`. Override the template in your
theme to change markup. There is no plugin type to implement and no hook API beyond the query tag.
