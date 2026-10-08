<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Promo Bar (commerce_promo_bar) — agent index

**Displays promotional/notification bars via a fieldable `commerce_promo_bar` Commerce entity and a `promo_bar_block` block, with store/role/path/date visibility and optional promotion-linked tokens.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Dependencies:** commerce_promotion, options, color_field
- **Entity:** `commerce_promo_bar` (content entity, translatable, fieldable; `admin_permission = "administer commerce promo bar"`).
- **Block:** `promo_bar_block` (setting: `stack`). Cache contexts: `url.path`, `store`.
- **Storage:** `PromoBarStorage::loadAvailable(store, roles)`; per-page filter `PromoBar::evaluateVisibility()`.
- **Routes:** collection `/admin/commerce/promo-bars`; settings `admin/commerce/config/promo_bar` (`_permission: administer commerce promo bar`); per-entity add/edit/enable/disable/duplicate/delete forms.
- **Permissions:** `administer commerce promo bar` (restrict access) plus Entity-API generated per-op permissions.
- **Security:** admin/entity-permission-gated config and CRUD; no anonymous or mutating endpoints; body is a text-format-filtered field. No security findings.

See [configure/promo-bar.md](configure/promo-bar.md)
