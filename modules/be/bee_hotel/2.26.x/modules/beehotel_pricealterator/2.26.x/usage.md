Bee Hotel Price Alterator defines the plugin type, manager and base machinery (weekly base-price table + season resolver) that drive Bee Hotel's dynamic per-night pricing.

---

This submodule provides the PriceAlterator plugin system used by bee_hotel's Commerce price resolver. Each alterator is an annotated plugin (@PriceAlterator with id/type/status/weight) implementing alter(array $data, array $pricetable): array. The Alter service loads a unit's weekly base-price table (PreAlter::baseTable), gathers enabled alterators from the plugin manager, filters them by annotation status and UI-enabled flag, and applies each per night, recording a per-night price stack in the session and returning an averaged amount. Administrators fill a weekly base-price table per unit and configure the season calendar (JSON) via the module's admin routes. Developers add pricing rules by declaring new PriceAlterator plugins.

---

- Provide the PriceAlterator plugin type consumed by the Commerce price resolver.
- Maintain a weekly base-price table per unit at /node/{node}/basepricetable.
- Resolve low/high/peak seasons from an admin-defined JSON season calendar.
- Run the alterator chain once per night and average the result for the order item.
- Filter alterators by annotation status and per-alterator UI enable flag.
- Expose an admin 'Price alterators' overview page listing the active chain.
- Let developers register custom pricing rules as annotated plugins.
- Ship base plugins GetSeason and PriceFromBaseTable as the pricing starting point.
- Record a per-night price breakdown in the session for debugging/preview.
- Gate base-table editing behind the 'admin pricealterator' permission.
