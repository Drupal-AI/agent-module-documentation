<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group context: Path prefix provides a group context based on a URL path prefix, resolving the active group from the path.

---

Group context: Path prefix provides a group context for the Group module based on a URL path prefix —
resolving the "active group" from a prefix in the URL (e.g. `/team-a/...` maps to group A), so group-aware
features know which group applies from the path. It depends on the Group module, in the Custom package.

Use it to derive the active group from the URL path on Group-based sites. It is a group-context provider; it
**resolves** which group is active but relies on the Group module's membership/permissions for actual access
(it doesn't grant access itself). It has no access-control role of its own. Configure the path-prefix
mapping.

---

- Resolve the active group from a path prefix.
- Map /prefix/ to a group.
- Provide a group context.
- Depend on the Group module.
- Derive group from the URL.
- Support group-aware features.
- Rely on Group's membership/permissions.
- Not grant access itself.
- Have no access-control role of its own.
- Configure the path-prefix mapping.
- Set the active group by path.
- Handle group context.
- Resolve groups by URL.
- Configure prefixes.
- Map paths to groups.
- Provide path-based context.
- Determine the group.
- Handle path prefixes.
- Configure group context.
- Resolve group context.
