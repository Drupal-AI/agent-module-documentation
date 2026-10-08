Define, manage and display store products as a node-like content entity with per-product grant-based access control.

---

`arch_product` is the central entity of the Arch commerce suite. It provides the `product` content entity (base table `arch_product`) and its `product_type` bundles, modelled closely on core's node system: products are fieldable, revisionable and translatable, with SKU, title, publish status, owner, an availability status and a `price` field. Access is governed by a full node-style **grant** system — `ProductAccessControlHandler` delegates to `ProductGrantDatabaseStorage` (table `arch_product_access`), and modules supply grants/realms via `hook_product_grants()` / `hook_product_access_records()`. The module ships add/edit/delete forms, an admin product list with bulk actions (publish, promote, sticky, assign owner, delete), a preview workflow, the revision UI, Views plugins, tokens and a store-dashboard product-count panel.

---

- Create product types (bundles) with their own fields, form and display modes.
- Add, edit, delete and translate products through dedicated forms at `/product/add`, `/product/{product}/edit`, etc.
- Give each product a SKU, title, owner, publish status and availability state.
- Attach prices via the `arch_price` `price` field (a hard dependency).
- Control who can view/edit/delete each product with a node-style grant access system.
- Extend access with `hook_product_grants()`, `hook_product_access_records()` and `hook_product_access()`.
- Let authors view their own unpublished products with `view own unpublished product`.
- Bypass all product access for trusted roles with `bypass product access` (restricted).
- Manage products from the admin listing at `/admin/store/products` with a bulk operations form.
- Run bulk actions: publish/unpublish, promote/demote, make sticky/unsticky, assign owner, delete.
- Preview unsaved product edits at `/product/preview/{product_preview}/{view_mode}` (create/update-gated).
- Keep a full revision history with view/revert/delete revision routes and permissions.
- Reference products from other entities via the `ProductSelection` entity-reference selection plugin.
- Filter, sort and build listings of products with the bundled Views field/filter/argument/row plugins.
- Use product tokens (`arch_product.tokens.inc`) in messages, mails and patterns.
- Show a product count on the store dashboard via the `ProductCount` dashboard panel plugin.
- Define per-bundle availability options through the `ProductAvailability` value object and field.
- Rebuild product access grants from `/admin/reports/status/rebuild-store-permissions`.
- Configure per-bundle permission granularity (view/create/edit/delete <type> product).
