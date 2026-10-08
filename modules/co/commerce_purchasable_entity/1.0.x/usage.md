<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Purchasable Entity provides a lightweight alternative to Commerce's product/variation pair: a single `commerce_purchasable_entity` type with a price and a store reference, for cases where the full product model is more structure than the shop needs.

---

Drupal Commerce models sellable things as a product with one or more variations, which is powerful but heavy when you are selling, say, event tickets, memberships or single-SKU services. This module defines a minimal purchasable entity instead: a bundleable content entity (`commerce_purchasable_entity` with a `commerce_purchasable_entity_type` bundle entity) carrying the fields Commerce actually requires of a purchasable — a unique **SKU**, a title, a required **price** (`commerce_price`) and a required **store** reference — and implementing Commerce's purchasable-entity interface so it can be referenced by an order item type and go through cart, checkout, tax and promotions like any product variation. Each bundle simply picks the order item type used when the entity is purchased. It ships its own storage handler (with a `loadBySku()` helper), an access control handler, list builders for both entities and their types, entity forms, and a `PurchasableEntityHtmlRouteProvider` giving it a full admin UI with menu, action and task links; it deliberately ships **no add-to-cart form of its own**, expecting an alternative add-to-cart flow (for example Commerce Webform Order) — so the order item price is resolved server-side from the entity, not from user input. Permissions follow the usual Commerce shape: a restricted `administer commerce_purchasable_entity_type` for bundle configuration plus create/edit/delete/view permissions for the entities themselves. It depends on `commerce`, `commerce_price` and `commerce_store`.

---

- Sell event tickets without modelling them as products with variations.
- Offer memberships as a single purchasable item.
- Sell a service with one price and no variants.
- Reduce editorial overhead on a single-SKU shop.
- Provide a purchasable entity for a custom booking flow.
- Attach a price and store to a bespoke entity type.
- Create several purchasable types with different fields.
- Keep cart, checkout and tax behaviour from Commerce core.
- Reference the entity from a custom order item type.
- Give donations a purchasable representation.
- Sell digital downloads without variation overhead.
- Model course enrolments as purchasable entities.
- Apply promotions to a minimal purchasable type.
- Give each purchasable type its own fields via Field UI.
- Restrict bundle administration to store administrators.
- Let editors create purchasables without product knowledge.
- Build a marketplace listing type that is directly purchasable.
- Avoid unused variation UI on a simple catalogue.
- Provide a purchasable entity for API-driven storefronts.
- Keep pricing logic in Commerce rather than custom code.
