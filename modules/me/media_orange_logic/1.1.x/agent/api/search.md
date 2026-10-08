<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Orange Logic — search API & endpoints

## Manager service
`media_orange_logic.manager` → `Drupal\media_orange_logic\OrangeLogicManager`.

```php
$manager = \Drupal::service('media_orange_logic.manager');
$query   = $manager->buildCriteriaQuery(['Keyword' => 'sunset', 'MediaType' => 'Image']);
$response = $manager->search($query, ['page_number' => 1, 'per_page' => 20]);
$items   = $response->renderItems();
```

- `buildCriteriaQuery(array $values)` — keeps only allowed keys
  (`MediaType, Text, Artist, Keyword, NativeKeyword, SystemIdentifier, MediaNumber,
  Color, Orientation, OriginalSubmisionNumber, CreateDate, EditDate, MediaDate`),
  builds `(key:val OR key:val) AND (...)`.
- `search(string $query, array $options)` — GETs the configured `search_endpoint`
  with `token` (from `OrangeLogicTokenManager`, cached in private tempstore),
  `format=json`, and a fixed `fields` list; returns an `OrangeLogicSearchResponse`.
  NB: throws to `die($e->getMessage())` on a Guzzle exception.
- Token: `media_orange_logic.token.manager` (`OrangeLogicTokenManager::getToken()`).
- Public links: `media_orange_logic.asset_public_link.manager`.

## AJAX endpoint (access review)
`POST /media-orange-logic/eb/ajax/selected-assets` → `EntityBrowserController::ajaxSelectedAssets`.
Reads `asset_ids` from the request, runs a `SystemIdentifier` search and returns rendered
thumbnails as JSON. Route requirement is only `_permission: 'access content'` (granted to
anonymous by default), and it queries the DAM with the site's stored token — treat as an
unauthenticated asset-lookup proxy when assessing exposure.
