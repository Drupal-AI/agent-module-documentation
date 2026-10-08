<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Replicate (localgov_replicate) — agent index

**Integration glue for the Replicate/Replicate UI stack on LocalGov Drupal: relabels the clone tab to "Clone" and grants `replicate entities` to LocalGov roles.**

- **Version:** 1.0.x (1.0.0)  ·  **Core:** ^10 || ^11  ·  **Package:** LocalGov Drupal
- **Depends on:** replicate, replicate_ui (these provide the actual clone route, UI and `replicate entities` permission).
- **Hooks:** `hook_localgov_roles_default()` grants `replicate entities` to the LocalGov Editor role; `hook_menu_local_tasks_alter()` + `hook_entity_operation_alter()` rename "Replicate" → "Clone".
- **Submodule `localgov_replicate_microsites`:** grants `replicate entities` to Microsites Controller / Editor roles.
- **No routes/entities/services of its own.**

**Security:** access is entirely delegated to Replicate UI — the clone tab and `/{entity}/replicate` require the `replicate entities` permission. Module tests confirm editors-with-permission get the tab/200 (even for content they don't own), while authenticated-without-permission and anonymous users get no tab and 403; revoking the permission revokes access. No anonymous or unauthenticated clone path. No security findings.

See [configure/roles.md](configure/roles.md).