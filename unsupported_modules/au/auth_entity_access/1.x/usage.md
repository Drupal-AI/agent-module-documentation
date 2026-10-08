<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticated Entity Access hides individual nodes from anonymous users via an edit-form checkbox.

---

Authenticated Entity Access allows restricting access to individual nodes via a simple checkbox on the node edit form — when checked, the node is forbidden to anonymous users. Enforcement is via the authoritative `hook_entity_access` (`AccessResult::forbiddenIf($restricted && !$account->isAuthenticated())`), so the canonical page, `entity->access()` checks, and JSON:API/REST all deny anonymous access.

Consideration: it implements `hook_entity_access` but NOT node-access grants (`hook_node_grants`/records), so raw node-listing queries (some Views) that rely on the node-access grants table are not query-filtered — a restricted node could still appear (title/teaser) in such a listing to anonymous, though opening it 403s. For full listing-level hiding, pair it with a grants-based approach. Configuration is gated by `configure auth entity access`. Supports Drupal 8.8 through 11.

---

- Restrict individual nodes to authenticated users.
- Use a node-edit checkbox.
- Forbid anonymous to restricted nodes.
- Enforce via `hook_entity_access` (authoritative).
- Protect canonical page + JSON:API/REST.
- Use `AccessResult::forbiddenIf`.
- NOT implement node-access grants.
- Note Views listings aren't query-filtered.
- Pair with grants for full listing hiding.
- Gate config with `configure auth entity access`.
- Support Drupal 8.8 through 11.
- Restrict per node.
- Hide from anonymous
- Configure restriction
- Protect content.
- Follow entity access.
- Restrict nodes.
- Gate by authentication
