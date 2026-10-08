<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges Advanced Access (adva) to Drupal core's node access grant system: it registers a `node` Access Consumer and implements `hook_node_grants()` / `hook_node_access_records()` so adva Access Providers control node view/update/delete access through core's own node-grant machinery.

---

adva_na is the node integration for adva. It ships a **basic** Access Consumer plugin
(`NodeAccessConsumer`, id `node`, extends `AccessConsumer`) — basic meaning it does **not**
override the node access handler; instead node access flows through core's node grant system.
`adva_na.module` implements `hook_node_access_records($node)` (returns the consumer's
`getAccessRecords($node)` → rows written to core's `node_access` table) and
`hook_node_grants($account, $op)` (returns the consumer's `getAccessGrants($op, $account)` → the
realm/gid grants the user holds). The consumer's `onChange()` calls `node_access_needs_rebuild(TRUE)`
when provider config changes, so the admin is prompted to rebuild node permissions. Because it
uses core node grants, both the node listing queries (core's `node_access` query tag) and direct
node access are enforced consistently and fail closed — unlike adva's overriding-consumer path.
Configuration is done on the shared adva settings form (`/admin/config/people/adva`) by enabling
Access Providers for the Node consumer. No own permissions, routes, schema, or services.

---

- Restrict which nodes a user can view using adva Access Providers via core node grants.
- Expose selected nodes to anonymous users through adva's `anonymous` provider.
- Apply per-node update/delete grants driven by adva providers.
- Add a custom access dimension (e.g. department/subscription) to node access without writing node hooks.
- Integrate node access with adva's realm/grant model instead of scattered `hook_node_access`.
- Have node listing Views automatically respect adva grants (core node_access query tag).
- Trigger a node access rebuild automatically when provider config changes.
- Combine multiple adva providers to compute node grants (grants merge).
- Keep node access fail-closed and consistent across listings and direct access.
- Grant `bypass adva node access` to trusted roles to see all nodes.
- Use language-aware node grants on multilingual sites (records carry langcode).
- Model bundle/content-type-specific node access via provider config.
- Rebuild node permissions from the adva status report when flagged.
- Replace a bespoke node-grant module with a pluggable adva provider.
- Let site builders toggle node access providers from the adva UI.
- Provide search results that respect node grants (with adva's Search API processor).
- Migrate node access logic into reusable adva Access Providers.
- Enforce read restrictions on unpublished/limited nodes via grants.
