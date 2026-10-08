<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation Management cart storage (tmgmt_cart_storage) — agent index

**Persists TMGMT's job-item cart per-user (default) or as one shared global cart, via pluggable storage methods.**

- **Version:** 1.0.x
- **Core:** ^10.5 || ^11 · **Deps:** tmgmt, user
- **No routes/permissions.** Method chosen on TMGMT settings `/admin/tmgmt/settings` (`tmgmt_cart_storage.settings:method`, default `user_data`).
- **Service:** `tmgmt_cart_storage.cart_decorator` (`DecoratedJobItemCart`, decorates `tmgmt.cart`), `plugin.manager.tmgmt_cart_storage_method`
- **Plugins:** `UserDataCart` (per-uid via `user.data`), `GlobalCart` (shared key/value)
- **Security:** Per-user cart is uid-scoped — no cross-user exposure. `GlobalCart` is an intentional, admin-selected shared cart; its `instantiateCart()` explicitly ignores prior session contents to avoid leaking one session's data into the shared store. No mutating anonymous endpoints. No security findings.

See [plugins/storage-methods.md](plugins/storage-methods.md)