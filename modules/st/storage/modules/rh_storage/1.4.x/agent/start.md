<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rh_storage — agent index

Glue submodule of **Storage Entities** that adds **Rabbit Hole** behaviour to the `storage`
entity type. No config of its own, no permissions, no Drush, no settings page. Requires
`rabbit_hole` + `storage`.

- **What it wires up, the base fields it adds, the rabbit-hole actions, how to set them** →
  [configure/rabbit-hole.md](configure/rabbit-hole.md)

Key facts:
- Registers a `RabbitHoleEntityPlugin` (id `rh_storage`, `entityType = "storage"`).
- `hook_entity_base_field_info()` adds Rabbit Hole base fields to `storage`:
  **`rh_action`**, `rh_redirect`, `rh_redirect_response`, `rh_redirect_fallback_action`.
- `rh_action` holds a Rabbit Hole behavior plugin id: `display_page`, `access_denied`,
  `page_not_found`, `page_redirect` (plus the bundle default).
- All actual behaviour comes from the parent `rabbit_hole` module.
