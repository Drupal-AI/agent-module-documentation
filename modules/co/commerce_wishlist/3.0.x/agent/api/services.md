# Services, programmatic use & events

## Services

| Service id | Class | Role |
|---|---|---|
| `commerce_wishlist.wishlist_provider` | `WishlistProvider` | Resolve/create the current customer's wishlist(s). |
| `commerce_wishlist.wishlist_manager` | `WishlistManager` | Add/remove/empty/merge wishlist items. |
| `commerce_wishlist.wishlist_session` | `WishlistSession` | Track anonymous wishlist ids in the session. |
| `commerce_wishlist.wishlist_assignment` | `WishlistAssignment` | Claim/merge an anonymous wishlist onto a user (on login). |
| `commerce_wishlist.wishlist_share_mail` | `WishlistShareMail` | Email a wishlist. |
| `cache_context.wishlist` | `WishlistCacheContext` | `wishlist` cache context. |

### `WishlistProvider` (resolve the list)

```php
$provider = \Drupal::service('commerce_wishlist.wishlist_provider');
$wishlist = $provider->getWishlist('default');            // current user/session, type 'default'
$wishlist = $provider->createWishlist('default');         // create if none
$all      = $provider->getWishlists();                    // all of the current customer's lists
$ids      = $provider->getWishlistIds();
```

### `WishlistManager` (mutate the list)

```php
$manager = \Drupal::service('commerce_wishlist.wishlist_manager');
// $variation is a purchasable entity (e.g. commerce_product_variation).
$item = $manager->addEntity($wishlist, $variation, $quantity = 1, $combine = TRUE, $save = TRUE);
$manager->removeWishlistItem($wishlist, $item);
$manager->emptyWishlist($wishlist);
$manager->merge($source, $target);                        // merge one wishlist into another
```

## Entities

- `commerce_wishlist` — the list (owner, type, items, name). Route provider gives canonical /
  edit / delete; list at `/wishlist`.
- `commerce_wishlist_item` — one line: references a purchasable entity + quantity. Storage
  `WishlistItemStorage`, access handler, Views data.
- `commerce_wishlist_type` — config bundle (see configure/settings.md).

## Events — `\Drupal\commerce_wishlist\Event\WishlistEvents`

Subscribe to react to lifecycle changes (constants → event names):

| Constant | Event name |
|---|---|
| `WISHLIST_ASSIGN` | `commerce_wishlist.wishlist.assign` |
| `WISHLIST_EMPTY` | `commerce_wishlist.wishlist.empty` |
| `WISHLIST_ENTITY_ADD` | `commerce_wishlist.entity.add` |
| `WISHLIST_LOAD` / `WISHLIST_CREATE` / `WISHLIST_PRESAVE` / `WISHLIST_INSERT` / `WISHLIST_UPDATE` / `WISHLIST_PREDELETE` / `WISHLIST_DELETE` | `commerce_wishlist.commerce_wishlist.<op>` |
| `WISHLIST_ITEM_*` (LOAD/CREATE/PRESAVE/INSERT/UPDATE/PREDELETE/DELETE) | `commerce_wishlist.commerce_wishlist_item.<op>` |

`WishlistEntityAddEvent` (fired on `WISHLIST_ENTITY_ADD`) carries the wishlist, the added
purchasable entity, and quantity — useful to enforce limits or add messaging.

## Views field plugins

`Plugin/views/field/`: `MoveToCart`, `MoveToWishlist`, `EditQuantity`, `RemoveButton` — the
action buttons used by the shipped `commerce_wishlist_item_table` / `commerce_wishlists` views.
