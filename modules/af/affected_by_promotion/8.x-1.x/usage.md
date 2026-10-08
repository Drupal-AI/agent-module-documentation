<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Affected By Promotion is a small Commerce developer helper: given a promotion, it returns a database query for the entities (products, etc.) that the promotion's offer plugin affects.

---

Affected By Promotion provides a single service, `affected_by_promotion.affected_entities_manager` (class `AffectedEntitiesManager`), that answers "which entities does this promotion apply to?" by delegating to the promotion's offer plugin. The service only works when the offer plugin implements `SupportsAffectedEntitiesQueryInterface` and its `getAffectedEntitiesQuery($entity_type_id)` method returns a `\Drupal\Core\Database\Query\Query`; when the offer does not implement that interface, the service returns `FALSE`. It builds no query itself and provides no UI, no routes, no permissions, and no config — it is an API for other module code to call (for example to list the `commerce_product` entities a promotion covers, then apply your own ranges, sorting, and access filtering). It depends on Commerce Promotion (`drupal/commerce`). There is a core Commerce issue (#3007070) tracking folding this capability into Commerce itself.

---

- Get a query for the entities affected by a given promotion via `AffectedEntitiesManager::getAffectedEntitiesQuery($promotion, $entity_type_id)`.
- Get the same query directly from an offer plugin with `getAffectedEntitiesQueryByOffer($offer, $entity_type_id)`.
- List the `commerce_product` entities a promotion applies to.
- Enumerate order items or other entity types an offer targets (any `$entity_type_id` the offer understands).
- Build custom reports of a promotion's reach in a store's admin tooling.
- Detect whether an offer plugin supports the affected-entities query (service returns `FALSE` when it does not).
- Add affected-entities support to a custom offer plugin by implementing `SupportsAffectedEntitiesQueryInterface`.
- Return a `SelectInterface` you can further constrain with `range()`, `orderBy()`, and conditions.
- Feed the returned entity IDs into a batch process (e.g. re-index or re-price affected products).
- Power a "products in this promotion" listing in a custom controller or Views-adjacent code.
- Drive an email/notification job targeting only the products a promotion covers.
- Audit which products a discount currently reaches before publishing the promotion.
- Cross-check overlapping promotions by comparing their affected-entity queries.
- Use the interface as an extension point so third-party offer plugins expose their targeting logic.
- Wrap the service in a Drush command or queue worker for bulk operations.
- Integrate promotion reach data into a merchandising dashboard.
- Precompute affected-product sets for caching or search facets.
- Keep the affected-entities logic in one place instead of re-deriving offer conditions.
- Serve as a reference implementation for the pending core Commerce feature (issue #3007070).
