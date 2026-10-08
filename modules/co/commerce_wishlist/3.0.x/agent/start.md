# Commerce Wishlist — agent index

Save-for-later / favorites for Drupal Commerce. Entities: `commerce_wishlist` (list),
`commerce_wishlist_item` (line), `commerce_wishlist_type` (config bundle, ships `default`).
Requires `commerce`, `commerce_cart`, `commerce_store`, `inline_entity_form`, `profile`.
No `configure` in info.yml, but a settings form at `/admin/commerce/config/wishlist-settings`.

- **Global settings, wishlist types, the add-to-wishlist button & block, routes** →
  [configure/settings.md](configure/settings.md)
- **Services & how to add/remove/merge wishlist items in code (+ events)** →
  [api/services.md](api/services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Settings object `commerce_wishlist.settings`: `allow_multiple`, `allow_anonymous_sharing`,
  `duplicate`, `default_type` (default `default`), `view_modes` (per entity type).
- Services: `commerce_wishlist.wishlist_provider` (resolve the current list, session- or
  user-backed), `commerce_wishlist.wishlist_manager` (`addEntity`, `removeWishlistItem`,
  `emptyWishlist`, `merge`), `commerce_wishlist.wishlist_session`,
  `commerce_wishlist.wishlist_assignment` (claim anon list on login).
- UI: "Add to wishlist" injected into the Commerce add-to-cart form and into product-variation
  field formatters (third-party settings `show_wishlist`, `weight_wishlist`, `label_wishlist`,
  `region`); Wishlist **block** id `commerce_wishlist`; routes `/wishlist`,
  `/user/{user}/wishlist`, share form; Views field plugins (Move to cart / wishlist, Edit
  quantity, Remove).
- Events: `\Drupal\commerce_wishlist\Event\WishlistEvents` (assign, empty, entity-add, and full
  CRUD for wishlist + wishlist item).
- Permissions: `access wishlist`, `administer commerce_wishlist_type`, plus Commerce-generated
  entity permissions.
