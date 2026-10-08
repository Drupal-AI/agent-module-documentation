Commerce Wishlist lets Drupal Commerce customers save purchasable products to one or more wishlists (favorites / save-for-later), with an "Add to wishlist" button on product forms, a wishlist page, and email sharing.

---

The module defines three entity types: **`commerce_wishlist`** (a customer's list, content entity), **`commerce_wishlist_item`** (a line on the list referencing a purchasable entity + quantity), and **`commerce_wishlist_type`** (a config bundle; ships a `default` type with an `allowAnonymous` flag). Wishlists are resolved per request by the **`commerce_wishlist.wishlist_provider`** service — session-backed for anonymous users (`commerce_wishlist.wishlist_session`) and user-backed for authenticated ones — and manipulated through **`commerce_wishlist.wishlist_manager`** (`addEntity()`, `removeWishlistItem()`, `emptyWishlist()`, `merge()`); on login, `WishlistAssignment` claims/merges the anonymous wishlist. Global behavior is in `commerce_wishlist.settings` (`allow_multiple` wishlists per user, `allow_anonymous_sharing`, `duplicate` on share, `default_type`, and per-entity-type `view_modes`), edited at `/admin/commerce/config/wishlist-settings`. The UI is surfaced by adding an "Add to wishlist" button to the Commerce add-to-cart form and to product-variation field formatters (third-party settings `show_wishlist`, `weight_wishlist`, `label_wishlist`, `region`), a **Wishlist block** (`commerce_wishlist`, optional dropdown), routes `/wishlist` and `/user/{user}/wishlist`, a share form (emailing a copy via `WishlistShareMail`), and Views field plugins (Move to cart, Move to wishlist, Edit quantity, Remove). It dispatches a rich set of events (`WishlistEvents`) around wishlist and wishlist-item lifecycle. Permissions include `access wishlist`, `administer commerce_wishlist_type`, plus the standard Commerce-generated entity permissions. Requires `commerce`, `commerce_cart`, `commerce_store`, `inline_entity_form`, and `profile`.

---

- Add an "Add to wishlist" button next to "Add to cart" on product pages.
- Let anonymous visitors build a wishlist that follows their session.
- Merge a guest's wishlist into their account automatically on login.
- Let customers move an item from their wishlist straight into the cart.
- Move a cart item back to the wishlist to save it for later.
- Show a Wishlist block in the header with an item count and optional dropdown.
- Give each customer a dedicated wishlist page at /wishlist.
- Allow multiple named wishlists per customer (e.g. "Birthday", "Home") via `allow_multiple`.
- Share a wishlist by email to friends or family.
- Duplicate an anonymous wishlist when it is shared so the original is preserved (`duplicate`).
- Define custom wishlist types (`commerce_wishlist_type`) with their own fields.
- Toggle whether a wishlist type allows anonymous lists (`allowAnonymous`).
- Add an "Add to wishlist" control to a product-variation field formatter with a custom label.
- Control the button's position/region and sort order on the add-to-cart form.
- Choose the view mode used to render products on the wishlist per entity type.
- Programmatically add a purchasable entity to a wishlist via the wishlist manager service.
- Empty a customer's wishlist in code (`emptyWishlist()`).
- React to wishlist events (item added, wishlist emptied, wishlist created) via `WishlistEvents`.
- Build custom reports/Views over wishlists and wishlist items (Views data provided).
- Let store staff administer wishlist types and fields (`administer commerce_wishlist_type`).
- Restrict who can view the wishlist page with `access wishlist`.
- Enforce a single default wishlist type for new lists (`default_type`).
- Provide a "save for later" experience without a full cart abandonment flow.
- Remove an item from the wishlist with a one-click Remove button (Views field).
- Support gift-registry-style lists shared publicly by URL.
