# rh_commerce — agent start

Rabbit Hole integration for **Commerce products**. Registers a `RabbitHoleEntityPlugin`
(`entityType = "commerce_product"`), so the "Rabbit Hole settings" tab appears on product type
and product edit forms. No config or API of its own — behavior comes from the base module.

- Configure product behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer commerce_product`, `rabbit hole bypass commerce_product`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
