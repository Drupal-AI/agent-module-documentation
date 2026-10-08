<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Store Dashboard (commerce_store_dashboard) — agent index
**Per-store `dashboard` view mode + page for Commerce store owners/managers.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Requires:** commerce:commerce_store
- **Route:** `entity.commerce_store.dashboard` → `/store/{commerce_store}/dashboard` (`_custom_access: CommerceStoreDashboardAccessCheck::access`)
- **View mode:** `commerce_store.dashboard`
- **Permissions:** `access own commerce_store dashboard`; `bypass commerce_store dashboard access` (restricted)
- **Security:** Access is ownership-enforced server-side (owner id == current user + own-dashboard permission), or the restricted bypass permission. Correct cache contexts (`user`, `user.permissions`). No mutating or anonymous endpoints.

See [configure/dashboard.md](configure/dashboard.md)