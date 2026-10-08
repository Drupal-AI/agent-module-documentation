<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AffectedEntitiesManager service + offer interface

## Install & enable

```bash
composer require drupal/affected_by_promotion
drush en affected_by_promotion -y
```

Requires Commerce Promotion (`commerce_promotion`, from `drupal/commerce ^2.0|^3.0`). No config
to set, no permissions, no Drush commands — enabling the module just registers one service.

## The service

`affected_by_promotion.affected_entities_manager` → `Drupal\affected_by_promotion\AffectedEntitiesManager`
(`src/AffectedEntitiesManager.php`). Constructed with no arguments (stateless helper). Two public
methods, both taking an entity type id string (e.g. `'commerce_product'`):

| Method | Signature | Behavior |
|---|---|---|
| `getAffectedEntitiesQuery` | `(PromotionInterface $promotion, string $entity_type_id)` | Reads `$promotion->getOffer()`. If that offer is **not** a `SupportsAffectedEntitiesQueryInterface`, returns `FALSE`. Otherwise returns `$offer->getAffectedEntitiesQuery($entity_type_id)`. |
| `getAffectedEntitiesQueryByOffer` | `(PromotionOfferInterface $offer, string $entity_type_id)` | Same check/delegation, but you pass the offer plugin directly instead of a promotion. Returns `FALSE` if the offer does not implement the interface. |

Return type is `bool|\Drupal\Core\Database\Query\Query` — either `FALSE` or whatever query object
the offer plugin builds. The manager itself **builds no query and runs no SQL**; it only checks
the interface and forwards the call. Callers are responsible for `range()`/`orderBy()`/conditions,
for executing the query, and for applying any access checks appropriate to the caller's context
(the docblock notes: "One would have to do ranges and additional limitations by oneself").

## The extension point

`Drupal\affected_by_promotion\SupportsAffectedEntitiesQueryInterface`
(`src/SupportsAffectedEntitiesQueryInterface.php`) declares one method:

```php
public function getAffectedEntitiesQuery($entity_type_id);
```

An offer plugin (a `commerce_promotion` `PromotionOffer` plugin) implements this to return a
`\Drupal\Core\Database\Query\Query` selecting the entities of `$entity_type_id` the offer targets.
Stock Commerce offers do **not** implement it, so out of the box the manager returns `FALSE` — the
value comes from custom/contrib offer plugins that opt in.

## Usage

```php
/** @var \Drupal\affected_by_promotion\AffectedEntitiesManager $mng */
$mng = \Drupal::service('affected_by_promotion.affected_entities_manager');

/** @var \Drupal\Core\Database\Query\SelectInterface|false $q */
$q = $mng->getAffectedEntitiesQuery($promotion, 'commerce_product');
if ($q) {
  $ids = $q->execute()->fetchCol();
}
```

Prefer constructor/`\Drupal::service()` injection of
`affected_by_promotion.affected_entities_manager` in your own services.

## Tests

`tests/src/Unit/GetAffectedEntitiesTest.php` covers all three cases with the `DummyPromotion*`
fixtures: an offer implementing the interface (query returned), one that does not (`FALSE`), and
the by-offer variant. Good reference for the exact contract.
