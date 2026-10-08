Exports Drupal Commerce orders to Bitrix24 leads or deals and syncs products/sections to the Bitrix24 catalog.

---

`b24_commerce` extends the base `b24` module for Drupal Commerce. An event subscriber listens to
Commerce order insert/update/assign/delete events and pushes each order to Bitrix24 — as a **lead**
when the portal is in Classic CRM mode or a **deal** in Simple mode — filling Bitrix24 fields from a
per-order-type mapping with `commerce_order`/`profile`/`user` token substitution. Ordered line items
are attached as Bitrix24 product rows. Separately, product-variation and taxonomy-term entity hooks
keep the Bitrix24 product catalog in sync, and an admin batch form bulk-exports the catalog. All
config routes require `administer b24 configuration`; the base `b24` OAuth connection must be set up
first.

---

- Automatically create a Bitrix24 lead/deal when a Commerce order is placed.
- Update the linked Bitrix24 record when an order changes (only when mapped values actually change).
- Set the order's customer email on the Bitrix24 record when an order is assigned to a user.
- Remove the Drupal↔Bitrix24 reference when an order is deleted.
- Map Commerce order / billing-profile / customer fields to Bitrix24 lead & deal fields per order type.
- Use Drupal tokens and custom static values in order field mapping.
- Attach ordered products (id, price, quantity) to the Bitrix24 lead/deal as product rows.
- Export Commerce product variations to Bitrix24 catalog products on save.
- Export taxonomy terms to Bitrix24 product sections and set a variation's `SECTION_ID`.
- Batch-export the whole catalog (products + sections) to Bitrix24 from `/admin/config/b24/commerce/export_products`.
- Choose which Commerce stores and which section-defining fields participate in the export.
- Alter outbound order data before it is sent with `hook_b24_commerce_data_alter()`.
- Support multiple Commerce order types, each with its own mapping settings page (dynamic routes/tasks).
- Fire `B24CommerceEvent` (`b24_commerce.entity.insert/update`) so other modules (e.g. b24_user) can react.
- Keep Bitrix24 records de-duplicated via the shared `b24_reference` hash table.
