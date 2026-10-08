# rh_group — agent start

Rabbit Hole integration for **Group** entities (requires the contributed Group module).
Registers a `RabbitHoleEntityPlugin` (`entityType = "group"`), so the "Rabbit Hole settings" tab
appears on group type and group edit forms. No config or API of its own — behavior comes from
the base module.

- Configure group behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer group`, `rabbit hole bypass group`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
