Commerce Store defines the Store entity — the top-level container that owns products, orders and payment/tax configuration — and its configurable store types, for one or many storefronts.

---

Every Drupal Commerce site needs at least one store. This submodule provides the `commerce_store` content entity and the `commerce_store_type` config entity, so you can model a single shop or several (multiple brands, regions or currencies) in one install. A store holds a name, email, default currency, supported billing countries, address and timezone, and one store is flagged the default. Products are assigned to one or more stores and orders belong to a store, which drives currency, tax and address behavior. Store types let you attach different fields and settings to different kinds of stores via Field UI and Commerce entity traits. It depends on Commerce and Commerce Price and integrates with core Options and Path. Administer stores at Admin → Commerce → Stores (`entity.commerce_store.collection`).

---

- Create the store that owns your products and orders.
- Run multiple stores (brands or regions) from one Drupal site.
- Set a store's default currency for pricing and display.
- Restrict which billing countries a store accepts.
- Configure a store's address, email and timezone.
- Designate a default store for single-store sites.
- Define store types with distinct fields via Field UI.
- Assign products to one or more stores.
- Scope orders, tax and payment behavior per store.
- Localize a store to a specific market and currency.
- Add custom fields (e.g. support phone, social links) to a store type.
- Model a marketplace with per-vendor stores.
- Separate a wholesale store from a retail store.
- Provide store contact details used in transactional emails.
- Control the set of countries shown at checkout per store.
- Manage all stores from the Commerce admin listing.
- Use store entity references to build store-aware views.
- Set per-store default currency for multi-currency catalogs.
