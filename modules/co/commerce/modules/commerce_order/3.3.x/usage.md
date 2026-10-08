Commerce Order defines the Order and Order Item entities, order adjustments (discounts, fees, taxes), and state-machine-driven order workflows — the transactional core of Drupal Commerce.

---

An **order** collects **order items** (each referencing a purchasable entity such as a product variation, with quantity and unit price), belongs to a store and customer, and carries billing information via a Profile. Totals are computed from item prices plus **adjustments** — a pluggable line-item mechanism (`commerce_order.adjustment_type`) used for promotions, taxes, fees and shipping. Order lifecycle is managed by the State Machine module through configurable **workflows** (e.g. draft → placed → fulfilled → completed), with transitions that other modules react to via events. Order types and order-item types are configurable bundles you extend with Field UI; each order type is bound to a workflow and (via Commerce Number Pattern) an order-number pattern. It depends on Commerce, Price, Store, Number Pattern, Entity Reference Revisions, Profile and State Machine. Manage order types and settings at Admin → Commerce → Configuration → Order types (`commerce_order.configuration`); orders at Admin → Commerce → Orders. An `AvailabilityManager` lets modules veto adding items (e.g. out of stock).

---

- Represent customer orders with line items, quantities and prices.
- Compute order totals from item prices plus adjustments.
- Apply discounts, fees, taxes and shipping as order adjustments.
- Drive order lifecycle with configurable state-machine workflows.
- Define custom order states and transitions (e.g. add "awaiting stock").
- React to order transitions via events (send email on "placed").
- Create multiple order types with distinct fields and workflows.
- Assign sequential order numbers via number patterns.
- Attach billing profiles (addresses) to orders.
- Store per-order customer, store and email data.
- Add custom fields (PO number, notes) to an order type.
- Implement a custom adjustment type for a bespoke fee.
- Prevent adding unavailable items via availability checkers.
- Track order item unit price vs. adjusted total.
- Build back-office order management screens with Views.
- Model quotes or draft carts as orders in a draft state.
- Recalculate order totals when items or adjustments change.
- Support guest and authenticated customer orders.
- Refund or adjust an order via negative adjustments.
- Manage all orders from the admin order listing.
- Integrate custom fulfillment workflows on order state changes.
