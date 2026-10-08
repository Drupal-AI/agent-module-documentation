<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An extra protection layer against node deletion, by content type.

---

Node Secure provides an extra protection layer for node deletion by content type — so nodes of configured content types are protected from deletion (guarding critical content against accidental/unauthorised removal).

Security: it enforces this via **`hook_node_access()` returning `AccessResult::forbidden()`** for the delete operation on protected types — authoritative access control that is respected on all delete paths (UI, VBO, programmatic, API), not just the form. Depends on core `node`; supports Drupal 10.3+ and 11.

---

- Protect nodes from deletion.
- Apply per content type.
- Guard critical content.
- Prevent accidental removal.
- Enforce via `hook_node_access` forbidden.
- Be authoritative on all delete paths.
- Depend on core `node`.
- Support Drupal 10.3+ and 11.
- Configure protected types.
- Aid content safety.
- Handle delete protection.
- Secure nodes
- Support Drupal.
- Support Drupal.
- Support Drupal.
