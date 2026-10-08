<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch is a modular e-commerce suite for Drupal; the base `arch` module provides the **store dashboard** at `/admin/store` (a plugin-driven panel page), the `administer store` permission, store content settings, and the admin-theme toggle for store administration.

---

The `arch` base module is the umbrella/admin layer of the Arch commerce platform. It declares a `StoreDashboardPanel` plugin type and renders `/admin/store` from those panels plus `hook_arch_tasks()` links (`DashboardController`), giving submodules (orders, products, payment, etc.) a place to surface counters and quick actions. It adds the top-level "Store" admin menu tree and the `administer store` permission that most Arch admin pages hang under. A `StoreContentSettingsForm` at `/admin/store/settings/contents` stores (in the `arch.content_settings` key/value collection) which node is the Terms & Conditions and which is the Privacy Policy, and in what combination (`_none` / `TC` / `PP` / `TCPP`) the acceptance links are shown on the checkout form via the `arch_terms_of_use` theme hook. `arch_form_system_themes_admin_form_alter()` adds a "use the administration theme when administrating store" checkbox that mirrors into `node.settings:use_admin_theme`. It also styles the admin toolbar (Seven / admin_menu icon libraries) and ships a bundled Underscore.js library (preferring core's copy when present). The base module depends on `entity`, `arch_product` and `arch_order`, and requires the `address` and `currency` contrib modules plus the bcmath/intl/json PHP extensions. Real commerce behavior lives in the 24 submodules; enable the ones you need. This suite is pre-1.0 (alpha) and several submodules (invoice, order statistics, discount) are declared placeholders ("Arch TODO") that currently ship only an info file.

---

- Provide a single `/admin/store` dashboard landing page for shop operators.
- Group all store administration under one "Store" admin menu tree.
- Gate store admin pages behind the `administer store` permission.
- Let submodules contribute dashboard panels via the `store_dashboard_panel` plugin type.
- Let submodules contribute dashboard task links via `hook_arch_tasks()`.
- Show an order-count panel on the dashboard (from `arch_order`).
- Configure which node is your Terms & Conditions page for checkout.
- Configure which node is your Privacy Policy page for checkout.
- Choose whether checkout shows T&C, Privacy Policy, both, or neither.
- Render a translatable "I accept the …" acceptance line on the checkout form.
- Force the administration theme while editing store content and orders.
- Add store-branded icons to the admin toolbar.
- Build a full storefront by enabling the product, price, cart, checkout, order and payment submodules.
- Add card payments through the Saferpay gateway submodule.
- Offer cash-on-delivery or bank-transfer payment options.
- Add warehouses and stock deduction via the stock submodules.
- Add per-role, per-price-type price access control via the price submodule.
- Add a product comparison feature via `arch_compare`.
- Add a customer address book via `arch_addressbook`.
- Sell downloadable products via `arch_downloadable_product`.
- Expose products and prices to Search API for faceted catalog search.
- Alter the dashboard render array from custom code via `hook_arch_dashboard_page_alter()`.
- Serve as the base dependency that every other Arch submodule builds on.
