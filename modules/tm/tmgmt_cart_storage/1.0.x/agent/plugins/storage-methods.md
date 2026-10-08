<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT cart storage methods

## Selecting a method
Config `tmgmt_cart_storage.settings:method` (default `user_data`), chosen on `/admin/tmgmt/settings`. `DecoratedJobItemCart` reads it lazily via the plugin manager and swaps the session cart for the method's stored cart on first cart access, saving back on `destruct()` only if the cart changed.

## Shipped plugins
- **`user_data`** (`UserDataCart`): persists the cart in `user.data` under module `tmgmt_cart_storage`, key `cart`, scoped to the current uid. Anonymous users fall back to the plain session cart. Deletes the record when the cart empties.
- **`global`** (`GlobalCart`): stores one cart in the `tmgmt_cart_storage` key/value collection, shared by all users. `instantiateCart()` intentionally returns the stored cart (ignoring any session contents) so session data is not merged into the shared cart.

## Adding a method
Create a plugin in `src/Plugin/TmgmtCartStorageMethod/` with the `#[TmgmtCartStorageMethod(id: '…', label: …)]` attribute implementing `TmgmtCartStorageMethodInterface` (`instantiateCart(array): array`, `save(array): void`).

## Data-exposure note
Per-user carts are uid-keyed (isolated). The global cart is a deliberate shared surface — only enable it where all cart users are meant to see the same job items.
