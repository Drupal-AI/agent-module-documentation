<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Store Dashboard gives Drupal Commerce store owners a dedicated dashboard page for each store, rendered through a `dashboard` view mode on the store entity.
---
The module registers a route `entity.commerce_store.dashboard` at `/store/{commerce_store}/dashboard` that renders the store entity in a `dashboard` view mode (shipped as `core.entity_view_mode.commerce_store.dashboard`). Access is decided by a custom access check, `CommerceStoreDashboardAccessCheck`, rather than a blanket permission: a user may view a store's dashboard if they hold `bypass commerce_store dashboard access`, or if they own the store (owner id matches) and hold `access own commerce_store dashboard`. Results carry the appropriate `user`/`user.permissions` cache contexts. Site builders arrange the dashboard by configuring which fields/blocks appear in the store's `dashboard` view mode.

Operationally this is an administrative/reporting surface for store managers. The access model is sound: ownership is enforced server-side and the powerful "see any store" capability is a separate, `restrict access: true` permission. There are no mutating endpoints or anonymous routes introduced by the module; it composes existing Commerce entity display and access mechanisms.
---
- Enable the module (requires Commerce Store).
- Grant store owners `access own commerce_store dashboard`.
- Grant managers `bypass commerce_store dashboard access` to see any store.
- Visit `/store/{id}/dashboard` for a store's dashboard.
- Configure the `dashboard` view mode to choose what appears.
- Add fields, blocks, or views to the store dashboard display.
- Give each store owner a self-service store overview.
- Restrict dashboard access to store owners by ownership.
- Use contextual links to reach the dashboard from a store.
- Surface store KPIs/reporting to managers.
- Keep the "view any store" capability limited via restricted permission.
- Combine with Commerce reporting/views for richer dashboards.
- Let marketplace vendors manage only their own store.
- Reach the dashboard from a store via its contextual link.
- Embed order or product views into the dashboard display.
- Rely on cache contexts (`user`) for correct per-user rendering.