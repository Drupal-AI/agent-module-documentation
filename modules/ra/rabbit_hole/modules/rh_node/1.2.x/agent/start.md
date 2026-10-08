# rh_node — agent start

Rabbit Hole integration for core **nodes**. Registers a `RabbitHoleEntityPlugin`
(`entityType = "node"`), so the "Rabbit Hole settings" tab appears on content type and node
edit forms. No config or API of its own — all behavior comes from the base module.

- Configure node behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer node`, `rabbit hole bypass node`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
