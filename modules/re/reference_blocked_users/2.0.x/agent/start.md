<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reference Blocked Users (reference_blocked_users) — agent index

One permission that lets non-admin roles reference **blocked** users (as well as active) in
any user entity-reference field, including the node "Authored by" (`uid`) field, and lets
holders match users by **email** as well as username. No config UI (`configure` null), no
schema, no services, no Drush, no dependencies beyond core `user`. Requires Drupal 11.3+ / 12.

Mechanism: ships one `EntityReferenceSelection` plugin `default:reference_blocked_users`
(`src/Plugin/EntityReferenceSelection/ReferenceAllUsers.php`, `extends UserSelection`, declared
with the `#[EntityReferenceSelection]` attribute) with `weight: 10`, so core's
`SelectionPluginManager` auto-selects it as the handler for every `user` reference field — no
per-field setup.

Provides:
- Permission `reference blocked users` (`reference_blocked_users.permissions.yml`).
- Selection plugin `default:reference_blocked_users` (`ReferenceAllUsers`).
- Kernel test `ReferenceBlockedUsersSelectionTest` (`tests/src/Kernel/`).

Docs:
- **The `reference blocked users` permission and how it gates the query** →
  [permissions/permissions.md](permissions/permissions.md)
- **How the selection handler overrides core `UserSelection` (weight, query, email match)** →
  [extend/user_selection.md](extend/user_selection.md)

Key facts:
- Handler wins because `weight: 10` > core `default:user` (weight 0), same group `default`.
- Blocked users are returned only when the current user **lacks** `administer users` **and**
  **holds** `reference blocked users`; otherwise the stock active-only query runs.
- The all-users query calls `accessCheck(TRUE)`, honours the `filter[role]` handler setting and
  the `include_anonymous` option, relaxes `status` to `>= 0`, and matches the typed text on both
  `name` and `mail` (core matches `name` only).
