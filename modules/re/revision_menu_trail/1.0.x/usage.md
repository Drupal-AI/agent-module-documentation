<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Menu Trail uses the current revision in the active menu trail when viewing revisions.

---

Revision Menu Trail fixes the active menu trail on revision pages — when viewing an entity revision, it
uses the current revision in the active menu trail so the menu highlights the correct active item/breadcrumb
(rather than losing the trail on revision routes). It is in the Content package.

Use it where revision pages should keep the proper menu trail/breadcrumb. It is a content-display/navigation
fix affecting the active-trail calculation on revision routes; it does not change content or access
(revision access is still governed by core revision permissions), and it has no access-control role. Enable
it to correct the menu trail on revisions.

---

- Fix the menu trail on revisions.
- Use the current revision in the active trail.
- Highlight the correct menu item.
- Correct breadcrumbs on revision pages.
- Keep the trail on revision routes.
- Not change content or access.
- Rely on core revision permissions.
- Have no access-control role.
- Enable trail correction.
- Handle revision navigation.
- Fix active-trail on revisions.
- Keep breadcrumbs correct.
- Correct the trail.
- Handle revision routes.
- Fix menu highlighting.
- Maintain the menu trail.
- Correct navigation.
- Handle revisions.
- Fix the breadcrumb.
- Correct active trail.
