<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, layouts and favourites

## Route takeover

`Drupal\type_tray\Routing\TypeTrayRouteSubscriber` (service `type_tray.route_subscriber`,
`RoutingEvents::ALTER` priority **95**) rewrites the `node.add_page` route's `_controller` to
`\Drupal\type_tray\Controller\TypeTrayController::addPage`. The path stays `/node/add`.

## Theme hooks (`type_tray_theme()`)

| Hook | Template | Variables |
|---|---|---|
| `type_tray_page` | `templates/type-tray-page.html.twig` | `items`, `layout`, `category_labels`, `node_add_page_url` |
| `type_tray_teaser` | `templates/type-tray-teaser.html.twig` | `content_type_link`, `nodes_by_type_link`, `thumbnail_url`, `thumbnail_alt`, `icon_url`, `icon_alt`, `short_description`, `extended_description`, `layout`, `content_type_entity`, `favorite_link_text`, `favorite_link_url`, `favorite_link_action` |

`items` is `[category_key => [type_id => teaser render array]]`.
Override by copying the templates into your theme and clearing caches.

Asset library `type_tray/type_tray` (`js/type_tray.js`, `css/type_tray.css`; depends on
`core/jquery`, `core/drupal`, `core/drupalSettings`, `core/drupal.debounce`) is attached to
the page render array.

## Layouts

`addPage()` reads `?layout=` from the request, defaulting to `grid`:

| `layout` | Shows |
|---|---|
| `grid` (default) | icon + the content type's core description |
| `list` | thumbnail + icon + the **extended description** (`type_description`), falling back to the core description when empty |

Deep-link a layout with `/node/add?layout=list`.

## Favourites

- Route `type_tray.favorites` → `/type-tray/favorites-action/{type}/{op}`
  (`op` = `add|remove`), requirements `_role: authenticated` **and** `_csrf_token: TRUE`.
- Handler `TypeTrayController::processFavorites()` validates `op`, the type's existence and
  the user's `create` access, then writes into the **key-value collection**
  `type_tray_favorites`, keyed by uid, as `[type_id => TRUE|FALSE]`, and redirects back to
  `/node/add`.
- `getUserFavorites()` returns `array_keys(array_filter($collection->get($uid) ?? []))`.
- When non-empty, a synthetic group with key `type_tray__favorites` and label `Favorites`
  is prepended to the categories and rendered first.

Inspect or clear a user's favourites:

```bash
drush php:eval 'print var_export(\Drupal::keyValue("type_tray_favorites")->get(1), TRUE);'
drush php:eval '\Drupal::keyValue("type_tray_favorites")->delete(1);'
```

## Caching

- The page render array carries the `node_type` list cache tags
  (`config:node_type_list`) and every per-type `create` access result as a cacheable
  dependency.
- Each teaser adds the type entity's cacheable metadata plus the **`user`** cache context
  (because of favourites), so the tray is cached per user.
- Both the settings form and the favourites route invalidate `config:node_type_list`.

## Constants worth knowing

```php
TypeTrayController::UNCATEGORIZED_KEY   = '_none';
TypeTrayController::UNCATEGORIZED_LABEL = 'Uncategorized';
TypeTrayController::FAVORITES_KEY       = 'type_tray__favorites';
TypeTrayController::FAVORITES_LABEL     = 'Favorites';
TypeTrayController::TYPE_TRAY_DEFAULT_THUMBNAIL_PATH = '/assets/thumbnails/wysiwyg1.png';
TypeTrayController::TYPE_TRAY_DEFAULT_ICON_PATH      = '/assets/icons/file-text.svg';
```
