<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PriceAlterator plugin API & pricing chain

## The plugin type

- Annotation `@PriceAlterator` (`src/Annotation/PriceAlterator.php`): keys `id`, `description`,
  `type` (usually `"optional"` / `"mandatory"`), `status` (0/1 default), `weight` (chain order),
  `alteration`, `data`, `provider`.
- Interface `PriceAlteratorInterface`: `public function alter(array $data, array $pricetable): array;`
- Base class `PriceAlteratorBase` (extend this).
- Manager service `plugin.manager.beehotel.pricealterator`
  (`PriceAlteratorPluginManager`, parent `default_plugin_manager`), discovers plugins under any
  module's `src/Plugin/PriceAlterator/`.

## The chain (`Alter::alter($data)`)

Called by `bee_hotel`'s `SalepriceResolver`. For each night of the stay
(`$data['norm']['dates_from_search_form']['days']`):

1. `PreAlter::baseTable($data)` loads the unit's **weekly base-price table**.
2. `PriceAlteratorPluginManager::alterators($data)` lists candidate plugins.
3. `checkStatus()` (annotation `status`) then `checkEnabled()` (per-alterator UI config) filter them.
4. Each plugin's `alter($data, $basetable)` mutates `$data['tmp']['price']`.
5. Per-night prices accumulate; `alterators_current_stack` is stored in the **session** and the
   returned `amount` is the **average** night price (multiplied by nights as order-item quantity).

Prices are computed entirely server-side; the buyer supplies only dates and guest count.

## Base plugins

- `Plugin/PriceAlterator/PriceFromBaseTable` — seeds `price` from the weekly base table.
- `Plugin/PriceAlterator/GetSeason` — resolves the season (low/high/peak) for a date from the
  JSON season calendar in config `beehotel_pricealterator.pricealterator.GetSeason.settings`
  (edit at `/admin/beehotel/pricealterator/alterators/getseason`).

## Weekly base-price table

Form `Form\UnitBasePriceTable` + controller `Controller\UnitBasePriceTable`, route
`/node/{node}/basepricetable` (perm **`admin pricealterator`**). A *Base Table* local task appears
on unit nodes for users with `administer bee_hotel`.

## Admin overview

`Form\AlteratorsList` at `/admin/beehotel/pricealterator/alterators` (perm `administer bee_hotel`)
lists the alterator chain; `Plugin/Block/PriceAlteratorDebugBlock` can expose the current stack.

## Add a custom alterator

Create `mymodule/src/Plugin/PriceAlterator/MyRule.php` extending `PriceAlteratorBase` with a
`@PriceAlterator` annotation (unique `id`, a `weight`, `status = 1`), and implement
`alter(array $data, array $pricetable): array` setting `$data['tmp']['price']`. It is auto-discovered
by the manager and joins the chain at its weight.
