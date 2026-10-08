<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Organic Groups access control enables access control for private and public groups and group content, using node access grants.

---

Organic Groups access control (og_access) enables access control for Organic Groups — making groups
and group content private or public and enforcing that access. It implements Drupal's node-access-grant
system (`hook_node_grants()` + `hook_node_access_records()`) so that access to private group content is
enforced at the **query level** — the strongest, correct way to restrict node access (it applies to
listings, Views, and any node query, not just the canonical page). It depends on the Organic Groups (og)
module.

Use it to make Organic Groups content genuinely private to members. This is a correctly-implemented access
control: because it uses node access grants, private group content is filtered out of queries for
non-members — it doesn't rely on display-time checks that could leak via alternate paths. When adopting,
verify the group visibility settings (private/public) match your intent and that the grants are rebuilt
after enabling (node access rebuild). Configure group and group-content visibility.

---

- Enforce Organic Groups access control.
- Make groups/content private or public.
- Use node access grants.
- Implement hook_node_grants + node_access_records.
- Enforce access at the query level.
- Filter private content from queries.
- Apply to listings/Views/all node queries.
- Depend on the og module.
- Not rely on display-time checks.
- Verify group visibility settings.
- Rebuild node access after enabling.
- Make group content genuinely private.
- Restrict to group members.
- Configure group visibility.
- Correctly implement access control.
- Prevent alternate-path leaks.
- Enforce private groups.
- Control group-content access.
- Use grants for strong enforcement.
- Configure OG access.
