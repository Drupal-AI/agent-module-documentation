<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters, settings, lowest-price logic & theming

All logic lives in `src/Plugin/Field/FieldFormatter/`. The three plugin classes are thin subclasses
of the corresponding core commerce_price formatters; the shared behaviour is in
`FromPriceFormatterTrait`.

## Applicability

`FromPriceFormatterTrait::isApplicable()` returns TRUE **only** when the field's target entity type
is `commerce_product` **and** the field name is `variations`. So although the plugins declare
`field_types = { "entity_reference" }`, they only appear as options on a product's Variations field.

## viewElements() flow (the trait)

1. `getPurchasableEntities($items)` — iterates the field items, resolves each referenced purchasable
   entity via `$item->get('entity')->getTarget()->getEntity()`, and by default keeps **only
   published** entities (`$entity->isPublished()`). This filtered list drives the price.
2. `cache_entities` = the product itself plus **all** referenced entities (published *and*
   unpublished — `getPurchasableEntities($items, FALSE)`), used only for cache tags/contexts.
3. `getLowestPricedEntity($entities)` — walks the published entities and keeps the one with the
   smallest `getResolvedPrice()->getNumber()`.
4. `$multiple` flag: TRUE when there is more than one item **and** not (all prices equal AND
   `process_equal_prices_as_single` is on). Selects which label pair (single vs multiple) to use.
5. Builds a `#theme => 'commerce_from_price'` render array with `#label_before`, `#price`
   (`getPriceElement()`), `#label_after`, and `#cache` (tags + contexts).

If there are no published entities, an empty element is returned (no price shown).

## Per-formatter `getResolvedPrice()` / `getPriceElement()`

| Formatter | class | resolved price | price element |
|-----------|-------|----------------|---------------|
| plain | `FromPricePlainFormatter` | base `$entity->getPrice()` | `#theme => commerce_price_plain` (number + currency entity) |
| default | `FromPriceDefaultFormatter` | base `$entity->getPrice()` | `#markup => currencyFormatter->format(number, currency, options)` |
| calculated | `FromPriceCalculatedFormatter` | `chainPriceResolver->resolve($entity, 1, $context)` | `#theme => commerce_price_calculated` |
| calculated (with commerce_order) | `OrderFromPriceCalculatedFormatter` | `priceCalculator->calculate($entity, 1, $context, $adjustment_types)` → `getCalculatedPrice()` | `#theme => commerce_price_calculated` with `#result`, `#base_price`, `#adjustments` |

The `Context` for resolution/calculation is built from the current user and current store, keyed to
the entity's `price` field name. `OrderFromPriceCalculatedFormatter` is bound only when
`commerce_order` is enabled (via `hook_field_formatter_info_alter`); it reads the inherited
`adjustment_types` setting to decide which adjustments to include.

Note: `getLowestPricedEntity()` compares each entity's `getResolvedPrice()->getNumber()` against the
running lowest entity's raw `getPrice()->getNumber()`. For the plain/default formatters resolved ==
base so this is consistent; for the calculated formatters the comparison mixes resolved and base
numbers, so selection can differ from the displayed calculated value in edge cases where adjustments
reorder the cheapest variation. Cosmetic, not a correctness guarantee documented by the module.

## Settings (`defaultSettings` / `settingsForm` / `settingsSummary`)

Stored in the formatter's third-party display settings (no separate config schema shipped):

| setting | default | meaning |
|---------|---------|---------|
| `process_equal_prices_as_single` | `1` | when all variation prices are equal, use the *single* label set instead of the *multiple* set |
| `single_entity.label_before` | `''` | label before the price when effectively one entity |
| `single_entity.label_after` | `''` | label after the price when effectively one entity |
| `multiple_entities.label_before` | `'Starting at'` | label before the price for multiple entities |
| `multiple_entities.label_after` | `''` | label after the price for multiple entities |

Labels are plain text fields on the formatter settings form. Inherited price-formatter settings
(currency display, strip trailing zeroes, and for calculated: adjustment types) come from the parent
core classes.

## Theming

`hook_theme()` defines `commerce_from_price` with variables `label_before`, `price`, `label_after`.
Template `templates/commerce-from-price.html.twig` wraps them in `.commerce-from-price-wrapper` with
`.label-before`, `.commerce-from-price`, `.label-after` divs, each guarded by an `{% if %}`. All
three variables are printed with Twig auto-escaping (no `|raw`); `price` is a render array. Override
the template in your theme to change the markup.
