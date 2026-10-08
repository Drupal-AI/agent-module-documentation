<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Field Display Mode Formatter provides a formatter that renders links (to entities) with another display mode instead of just the link text.

---

Link Field Display Mode Formatter provides a formatter for Link fields that renders the linked entity
using a chosen display mode — so instead of just showing the link text/URL, it renders the referenced
entity (for internal links) in a selected view mode (teaser, card, etc.). This turns a link into an embedded
rendering of its target. It depends on core Link.

Use it where a link should display as a rendered preview of its target rather than a plain link. It is a
content-display/formatter feature; the linked entity is rendered respecting its own access (only accessible
targets render), and it has no access-control role. Select the formatter and display mode on the link
field.

---

- Render a link's target in a display mode.
- Show the linked entity, not just text.
- Embed the target as teaser/card.
- Depend on core Link.
- Turn a link into an embedded preview.
- Respect the target's access.
- Have no access-control role.
- Select the formatter and view mode.
- Render internal-link targets.
- Show a rendered preview.
- Configure the display mode.
- Embed referenced entities.
- Display links as content.
- Render link targets.
- Configure on the link field.
- Preview linked content.
- Show target view mode.
- Embed link targets.
- Render as another mode.
- Display linked entities.
