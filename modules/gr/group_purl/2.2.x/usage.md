<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
group_purl provides a Purl provider for Group, deriving the active group from a URL modifier.

---

group_purl provides a Persistent URL (PURL) provider for the Group module — deriving the active group
from a URL modifier (e.g. a path prefix or domain), so group context is established from the URL and Group's
per-group content/URLs work under that context. It depends on the Group and PURL modules, in the Group
package.

Use it to give groups URL-based context via PURL. It is a site-structure/group-context feature; it
**resolves** the active group from the URL but relies on the Group module's membership/permissions for actual
access (it doesn't grant access itself). It has no access-control role of its own. Configure the PURL modifier
for groups.

---

- Provide a PURL provider for Group.
- Derive the active group from the URL.
- Use a URL modifier (prefix/domain).
- Depend on Group and PURL.
- Establish group context from the URL.
- Support per-group URLs.
- Rely on Group's membership/permissions.
- Not grant access itself.
- Have no access-control role of its own.
- Configure the PURL modifier.
- Handle group context.
- Resolve groups by URL.
- Set group context.
- Configure PURL for groups.
- Handle URL-based groups.
- Provide group PURL.
- Resolve group context.
- Configure the modifier.
- Handle group URLs.
- Derive group context.
