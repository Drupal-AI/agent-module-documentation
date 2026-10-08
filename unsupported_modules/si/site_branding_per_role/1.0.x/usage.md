<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Branding Per Role provides a block like core Site Branding, but the logo's link destination is resolved from the current user's role, and each branding element can be toggled.

---

The `SiteBrandingPerRoleBlock` renders the site logo, site name and slogan (each shown only if its checkbox is enabled). Its block configuration form lists every role and asks for a URL per role; on save these are stored as `logo_link[<role>]`. At render time `getCurrentRoleLink()` picks the link for the viewer: administrator first, then anonymous, then a non-default authenticated role, then plain authenticated — falling back to `<front>`. The chosen path is prefixed with the base path and passed to the template as the logo link. The block validates each role URL on save (`blockValidate()`), requiring it to start with `#`, `?` or `/` (or be `<front>`) and to pass `PathValidatorInterface::isValid()`.

The block merges `system.site` cache tags so name/slogan changes invalidate correctly. Site name and slogan are output as `#markup` sourced from `system.site` config (admin-controlled), and the logo URL comes from the theme setting; there is no user-supplied input in the render path, and per-role link values are validated on entry. Configuration is entirely through the block placement form — no routes, permissions, or services are added. Typical setup: place the "Site branding per role block", enable the elements you want, and set a logo link URL for each role.
---
- Point the logo link to a different URL depending on the visitor's role
- Send administrators to an admin dashboard when they click the logo
- Send anonymous visitors to the front page from the logo
- Send a specific role to a role-specific landing page
- Toggle display of the site logo in the block
- Toggle display of the site name in the block
- Toggle display of the site slogan in the block
- Replace core Site Branding with a role-aware variant
- Validate per-role logo URLs on save
- Use <front> as a role's logo destination
- Keep branding cache-correct via system.site cache tags
- Place the block in any theme region
- Provide role-based navigation entry points from the header
- Localize/theme the branding via the bundled template
- Configure all role links from one block form
