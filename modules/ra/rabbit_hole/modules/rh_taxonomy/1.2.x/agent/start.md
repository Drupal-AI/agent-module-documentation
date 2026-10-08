# rh_taxonomy — agent start

Rabbit Hole integration for core **Taxonomy**. Registers a `RabbitHoleEntityPlugin`
(`entityType = "taxonomy_term"`), so the "Rabbit Hole settings" tab appears on vocabulary and
term edit forms. No config or API of its own — behavior comes from the base module.

- Configure term behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer taxonomy_term`, `rabbit hole bypass taxonomy_term`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
