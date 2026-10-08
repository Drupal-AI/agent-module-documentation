<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translation Management cart storage replaces TMGMT's session-only job-item cart with persistent storage, defaulting to a per-user cart and optionally a single global cart shared by all users, selectable via a pluggable storage-method system.
---
Out of the box TMGMT keeps the translation job-item cart in `$_SESSION`, so it is lost when the session ends. This module decorates the `tmgmt.cart` service (`DecoratedJobItemCart`) and, on first access, swaps the session cart contents for whatever the configured storage method returns, watching for changes and writing them back on object destruction. The active method is read from `tmgmt_cart_storage.settings:method` (default `user_data`) and instantiated through a dedicated plugin manager.

Two storage-method plugins ship: `UserDataCart` persists the cart per user via the `user.data` service keyed by the current user's uid (falling back to the plain session cart for anonymous users), and `GlobalCart` stores one cart in a key/value collection shared by every user. The global cart is an explicit opt-in chosen on TMGMT's Settings page (`/admin/tmgmt/settings`); its `instantiateCart()` deliberately ignores any pre-existing session contents so private session data is not leaked into the shared cart. The per-user method is uid-scoped, so it does not expose one user's cart to another. New storage methods can be added with the `#[TmgmtCartStorageMethod]` attribute.

Setup: enable the module (per-user persistence is active by default). To share one cart across all users, switch the method to "Global" on the TMGMT settings page.
---
- Make TMGMT translation carts survive across sessions.
- Persist each user's cart via the user.data store.
- Share a single translation cart across all users (global mode).
- Choose the storage method on the TMGMT settings page.
- Fall back to a session cart for anonymous users.
- Decorate the core `tmgmt.cart` service transparently.
- Write cart changes back only when they actually change.
- Batch cart saves to object destruction time.
- Add custom storage methods via a plugin attribute.
- Keep per-user carts isolated by uid.
- Avoid leaking session cart data into the global cart.
- Configure the default method (`user_data`) via config.
- Support editorial teams sharing one translation queue.
- Retain job items added before a translation request is built.
- Reset a cart by clearing its stored value.
- Integrate persistence without changing TMGMT's cart API.