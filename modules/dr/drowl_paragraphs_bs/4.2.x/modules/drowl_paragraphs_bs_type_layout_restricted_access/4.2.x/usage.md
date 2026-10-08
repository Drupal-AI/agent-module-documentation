<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Layout Paragraphs layout bundle whose display (and all its children) can be restricted to selected roles.

---

This sub-module installs the `layout_restricted_access` Paragraph type: a DROWL/Bootstrap Layout Paragraphs layout (one- to six-column DROWL layouts, UI-Styles options, optional background media) that carries a `field_access_by_role` field from the `entity_access_by_role_field` contrib module. Editors pick which roles may view the layout; the actual access enforcement is performed by `entity_access_by_role_field` (a server-side paragraph access check), so restricted layouts are not rendered for users without a matching role. The field is configured to enforce only the `view` operation, with an empty-roles fallback of `neutral`; its help text notes that if no role is selected, only the creator has access.

---

- Restrict an entire layout section (and everything nested in it) to selected roles.
- Make a section public by selecting both Guest and Authenticated user.
- Make a section login-only by selecting only Authenticated user.
- Limit a section to specific roles for member-only content.
- Build the section with DROWL Bootstrap column layouts via Layout Paragraphs.
- Add a background image/video to the restricted section.
- Apply UI Styles (spacing, borders, colors, etc.) to the section.
- Rely on server-side view access (content is not rendered for unauthorized users).
