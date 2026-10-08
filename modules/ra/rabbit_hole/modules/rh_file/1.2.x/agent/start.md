# rh_file — agent start

Rabbit Hole integration for **File entities** (requires the contributed File Entity module).
Registers a `RabbitHoleEntityPlugin` (`entityType = "file"`), so the "Rabbit Hole settings" tab
appears on file type and file edit forms. No config or API of its own — behavior comes from the
base module.

- Configure file behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer file`, `rabbit hole bypass file`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
