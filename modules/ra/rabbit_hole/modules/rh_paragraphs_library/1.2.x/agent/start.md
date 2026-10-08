# rh_paragraphs_library — agent start

Rabbit Hole integration for **Paragraphs library items** (requires Paragraphs' `paragraphs_library`).
Registers a `RabbitHoleEntityPlugin` (`entityType = "paragraphs_library_item"`), so the "Rabbit
Hole settings" tab appears on the library item forms. No config or API of its own — behavior
comes from the base module.

- Configure library-item behaviors (action, redirect, override) → [../../../rabbit_hole/1.2.x/agent/configure/settings.md](../../../rabbit_hole/1.2.x/agent/configure/settings.md)
- Per-entity-type permissions (`rabbit hole administer paragraphs_library_item`, `rabbit hole bypass paragraphs_library_item`) → [../../../rabbit_hole/1.2.x/agent/permissions/permissions.md](../../../rabbit_hole/1.2.x/agent/permissions/permissions.md)
