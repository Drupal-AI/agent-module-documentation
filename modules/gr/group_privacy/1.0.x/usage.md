<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Privacy allows configuring individual groups to deny all operations to anonymous and authenticated outsiders.

---

Group Privacy adds a per-group "private" setting to the Group module — a private group **denies all
operations** on the group and its group content to outsiders (anonymous and authenticated users who are not
members). It depends on the Group module, provides its own permissions, in the Group package.

Use it to make specific groups private. This is a genuine access-control feature implemented correctly and
**fail-closed**: it adds an `is_private` group field, overrides Group's permission checker so
`hasPermissionInGroup()` **returns FALSE (deny every permission)** for a non-member outsider of a private
group (unless they hold `bypass group privacy`), and — crucially — it implements `hook_query_TAG_alter()` on
the entity `_access` query tags to filter private-group content **at the query level** (so private content is
excluded from listings/search/Views for outsiders, not merely hidden on the full page — the strong, correct
pattern). When adopting: mark the groups that should be private, and treat the `bypass group privacy`
permission as sensitive (grant only to trusted admins). Configure which groups are private.

---

- Make individual groups private.
- Deny all operations to outsiders.
- Add a per-group private setting.
- Depend on the Group module.
- Provide its own permissions.
- Deny non-member outsiders every permission (fail-closed).
- Filter private-group content at the query level.
- Exclude private content from listings/search/Views.
- Override Group's permission checker.
- Treat 'bypass group privacy' as sensitive.
- Grant bypass only to trusted admins.
- Mark groups as private.
- Enforce private groups correctly.
- Configure private groups.
- Deny anonymous+authenticated outsiders.
- Use query-level enforcement.
- Restrict group access.
- Handle private groups.
- Configure privacy.
- Make groups private.
