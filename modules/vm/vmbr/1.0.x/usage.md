<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VMBR provides a view mode for each user role.

---

VMBR (View Mode by Role) **provides a view mode per user role** — so an entity can render with a different
view mode depending on the viewing user's role (e.g. a fuller display for editors, a limited one for anonymous).
It works across core 8–11.

Use it to vary entity display by role. It is a content-display/site-building feature and it controls
**presentation, not access** — choosing a view mode changes which fields are *displayed*, but it is **not**
field access control; a field omitted from a role's view mode is still readable via other paths (JSON:API/REST/
other view modes). Use real field/entity access to actually restrict data; use this for presentation only. It
has no access-control role. Configure the per-role view modes.

---

- Provide a view mode per role.
- Render differently by viewer role.
- Vary entity display.
- Serve content display/site building.
- Choose the view mode by role.
- Show role-specific displays.
- Control PRESENTATION, not access.
- NOT be field access control (omitted fields still readable elsewhere).
- Use real field/entity access to restrict data.
- Have no access-control role.
- Configure the per-role view modes.
- Handle role view modes.
- Vary display.
- Configure the view modes.
- Show by role.
- Handle the display.
- Choose displays.
- Render by role.
- Not hide data by view mode.
- Provide role view modes.
