<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Published Referenced Entity provides field formatters that respect publish status.

---

Published Referenced Entity provides **field formatters that display a referenced entity only when it is
published** — id, label and rendered-entity formatters that check the referenced entity's published status and
skip unpublished references in the output. It depends on core Field, in the Published referenced entity package.

Use it to avoid showing unpublished referenced items in a display. Understand its scope: this is a
**display-layer publish filter**, not access control — it changes what a given formatter renders, based on
`isPublished()`. It is presentation only: the referenced entity's **actual access** is still governed by core on
other paths (JSON:API/REST/Views/search), so do not rely on these formatters to *protect* unpublished content —
use entity access for that. (When rendering, prefer that referenced entities also pass their own view access;
these formatters gate on publish status, which is not identical to view access.) It has no independent
access-control role. Configure the formatters on reference fields.

---

- Display references only when published.
- Provide id/label/rendered formatters.
- Skip unpublished references.
- Depend on core Field.
- Serve content display.
- Check isPublished() in the formatter.
- BE a display-layer publish filter, not access control.
- Be presentation only.
- Not rely on it to protect unpublished content.
- Use entity access to actually protect content.
- Have no independent access-control role.
- Configure the formatters.
- Handle published references.
- Filter by publish status.
- Configure the formatter.
- Show published refs.
- Handle the display.
- Hide unpublished refs.
- Use access for protection.
- Provide published-reference formatters.
