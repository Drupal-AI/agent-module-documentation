Commerce Pricelist lets a Drupal Commerce store define alternative prices for purchasable entities (product variations) that apply only to specific stores, customers, customer roles, date ranges and purchase quantities, resolving the right price at add-to-cart / display time through a Commerce price resolver.

---

The module adds two content entity types: **`commerce_pricelist`** (a "Price list") and **`commerce_pricelist_item`** (a single price, called a "price" in the UI). Both are bundled per purchasable entity type (by default `commerce_product_variation`). A price list carries a name, a weight (priority ordering), an enabled flag, and matching conditions: `stores`, `customers` (specific users), `customer_roles`, and a `start_date`/`end_date` window. Each price list item references its `price_list_id` and a `purchasable_entity`, and defines a `quantity` threshold plus a `price` and optional `list_price`. At runtime the tagged service `commerce_pricelist.price_resolver` (`PriceListPriceResolver`, priority **600** in the `commerce_price.price_resolver` chain) asks the `commerce_pricelist.repository` service for the best-matching price list item for the current purchasable entity, quantity and Commerce `Context` (store, customer, date), and returns its `price` or `list_price` (chosen by the context's `field_name`). Because it is a high-priority resolver, a matching price list overrides the variation's base price. Prices are managed under **Commerce → Price lists** (`/admin/commerce/price-lists`); each list has a "prices" collection with add/edit/enable/disable/duplicate/delete forms, drag-and-drop reordering, and **CSV import and export** forms for bulk price management. A full set of lifecycle events (`PriceListEvents::PRICELIST_*` and `PRICELIST_ITEM_*`) fire on load/create/presave/insert/update/predelete/delete. Access is governed by the `administer commerce_pricelist` permission (plus Entity API per-bundle permissions). It requires Commerce, Commerce Store and Commerce Price.

---

- Give a specific customer (user) their own negotiated price on selected products (B2B).
- Apply wholesale pricing to everyone in a "wholesale" customer role.
- Run time-limited promotional pricing with a start and end date on a price list.
- Offer quantity-based tiered pricing (e.g. cheaper unit price at qty ≥ 10).
- Set different prices per store in a multi-store Commerce site.
- Bulk-load thousands of prices from a CSV file via the price list import form.
- Export a price list's prices to CSV for editing or auditing.
- Maintain seasonal price lists and enable/disable them as needed.
- Override a variation's default price only for members of a partner role.
- Prioritize overlapping price lists using each list's weight ordering.
- Give contract customers a fixed price regardless of catalog price changes.
- Provide a separate list price (MSRP / strike-through) alongside the actual price.
- Schedule a future price change by pre-creating a price list with a start date.
- Disable a single price row without deleting it (enable/disable forms).
- Duplicate an existing price list as the basis for a new pricing scheme.
- Reorder price lists to control which one wins when several match.
- Add a per-variation price directly from the product variation "Add price" route.
- Resolve prices dynamically at add-to-cart based on the current cart context.
- React to price list changes in custom code via the PriceListEvents lifecycle events.
- Load the applicable price list item programmatically through the repository service.
- Restrict pricing to a combination of store + customer role + quantity + date window.
- Implement region- or channel-specific pricing using per-store price lists.
- Roll out a price increase across a catalog by importing a new CSV price list.
- Give newsletter subscribers (a role) exclusive member pricing.
