# rh_user — agent start

Rabbit Hole integration for core **Users**. Registers a `RabbitHoleEntityPlugin`
(`entityType = "user"`), so the "Rabbit Hole settings" tab appears on user forms. No config or
API of its own — behavior comes from the base module. (Ships a `post_update` hook only.)

- Configure user behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer user`, `rabbit hole bypass user`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
