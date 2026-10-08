# Reference Blocked Users — agent index

One permission that lets non-admin roles reference **blocked** users (as well as active) in
any user entity-reference field, including the node "Authored by" (`uid`) field. No config UI
(`configure` null), no schema, no Drush, no dependencies beyond core `user`.

Mechanism: ships one `EntityReferenceSelection` plugin `default:reference_blocked_users`
(`src/Plugin/EntityReferenceSelection/ReferenceAllUsers.php`, `extends UserSelection`) with
`weight: 10`, so core's `SelectionPluginManager` auto-selects it as the handler for every
`user` reference field — no per-field setup.

- **The `reference blocked users` permission and how it gates the query** →
  [permissions/permissions.md](permissions/permissions.md)
- **How the selection handler overrides core `UserSelection` (weight, query, precedence)** →
  [extend/user_selection.md](extend/user_selection.md)

Key facts:
- Handler wins because `weight: 10` > core `default:user` (weight 0), same group `default`.
- Blocked users are returned only when the current user **lacks** `administer users` **and**
  **holds** `reference blocked users`; otherwise the stock active-only query runs.
- Query still calls `accessCheck()`, honours the `filter[role]` handler setting and the
  `include_anonymous` option; it only relaxes the `status` condition to `status >= 0`.
