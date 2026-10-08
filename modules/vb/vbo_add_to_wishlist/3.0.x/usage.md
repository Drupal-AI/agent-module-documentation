<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Views Bulk Operations action so a shopper can select several Commerce products in a view and add them all to their wishlist in one operation.

---

The module provides a single VBO action plugin (`vbo_add_to_wishlist`). For each selected product it loads the product, takes its first variation, gets or creates the current user's `default` Commerce Wishlist, and — if that variation is not already on the wishlist (checked with a parameterised DB query) — creates a `commerce_product_variation` wishlist item and saves it to the wishlist owned by the current user. Duplicates are skipped and logged. It depends on Views Bulk Operations, Drupal Commerce and Commerce Wishlist.

Setup: on a product listing view, add the *Global: Views bulk operations* field, enable the "VBO add to wishlist action", save; the bulk action then appears on the view. The action always writes to the acting user's own default wishlist (owner = current user id), and its DB lookup uses bound placeholders (no SQL injection). Note the action's `access()` returns TRUE for non-node entities (so any user who can reach the VBO field can run it), but it only ever mutates that same user's own wishlist.

---
- Add many Commerce products to a wishlist in one bulk action.
- Wire the action into a product listing view via VBO.
- Create the user's default wishlist automatically if absent.
- Skip products already present on the wishlist.
- Log an attempt to add a duplicate product/variation.
- Use the first variation of each selected product.
- Let shoppers batch-favourite catalogue items.
- Combine with exposed filters to bulk-save a filtered set.
- Give a custom label to the bulk action in the view.
- Add wishlist support to an existing product view without code.
- Operate only on the current user's own wishlist.
- Bulk-save search results to a wishlist for later.
- Let logged-in shoppers curate favourites quickly.
- Add products from an admin product listing to a wishlist.
- Avoid re-adding items already on the wishlist.
- Provide a one-click "save selected" workflow on catalogue pages.
