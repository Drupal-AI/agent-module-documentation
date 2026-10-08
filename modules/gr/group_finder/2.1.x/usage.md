<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group finder allows you to find a group in different scenarios, providing a pluggable way to resolve the relevant group.

---

Group finder provides a pluggable API for locating the relevant Group (from the Group module) in
different scenarios — shipping finder plugins such as "group by content", "group by route" and "create
group", so code/features can resolve which group applies in a given context (the current route, a piece of
content, etc.). It depends on the Group module, in the Group package.

Use it as a developer building block where "which group are we in?" must be resolved consistently. It is a
developer/API helper for group resolution; it locates groups but does **not** itself grant or check group
access (group membership/permissions still govern access), and it has no access-control role of its own. Use
the finder plugins in group-aware code.

---

- Find the relevant group per scenario.
- Provide group-finder plugins.
- Resolve group by content.
- Resolve group by route.
- Support a create-group scenario.
- Depend on the Group module.
- Resolve which group applies.
- Not grant or check access itself.
- Rely on group membership for access.
- Have no access-control role of its own.
- Use finder plugins in group code.
- Locate groups consistently.
- Build group-aware features.
- Resolve group context.
- Find groups.
- Provide group resolution.
- Handle group finding.
- Use the finder API.
- Resolve groups.
- Locate the group.
