<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Animated Counter is a configurable Drupal block that renders one or more animated "count-up" number tiles which count from 0 to a target value when scrolled into view.

---

Animated Counter provides a single block plugin (`animated_counters_block`, "Animated Counters (Multiple)") whose configuration form lets an editor build a draggable list of counter tiles — each with a numeric target value, an optional suffix (%, +, K…), a label, a Font Awesome icon class and color, an optional link URL, and a per-tile animation duration in milliseconds. Block-level settings choose the column layout (auto / 2 / 3 / 4), a style preset (card / bordered / minimal), a background gradient preset (none / blue / purple / sunset / green), an optional click "ripple" effect, an optional rich-text region shown above the tiles, and a custom wrapper CSS class. The count-up is animated client-side: `js/counter.js` uses an `IntersectionObserver` (threshold 0.4) so each tile animates once when it becomes visible, using `requestAnimationFrame`; a live preview inside the admin form is drawn by `js/admin-preview.js`. It depends on core Block and on the contrib `block_animate` module (installed automatically on enable). There are no config entities, routes, permissions, services, or config schema — only the one block plugin and a theme hook/template.

---

- Show a row of animated statistics on a landing page (e.g. "10,000+ customers", "99% uptime").
- Display company KPIs or achievements as count-up tiles.
- Highlight milestones (years in business, projects delivered, awards won).
- Build a "by the numbers" section for a marketing or SaaS site.
- Present case-study result figures with animated emphasis.
- Add a scroll-triggered stats block that only animates when it enters the viewport.
- Place the counters block in any region (footer, sidebar, hero) via the Block layout UI.
- Configure a suffix such as `%`, `+`, `K`, or `M` per counter tile.
- Set a different animation speed (duration in ms) for each counter.
- Choose a 2-, 3-, or 4-column layout, or let it auto-size to the number of tiles.
- Apply a card, bordered, or minimal visual style preset.
- Apply a background gradient preset (blue, purple, sunset, green) to the tiles.
- Add a Font Awesome icon above each counter and pick its color.
- Make a counter tile a clickable link to another page or external site.
- Add an intro/heading rich-text region above the counters.
- Reorder counter tiles by dragging rows in the block configuration table.
- Add or remove counter tiles dynamically from the block form.
- Add a custom wrapper CSS class to target the block from your theme.
- Enable a click "ripple" visual effect on linked counter tiles.
- Preview the counters live inside the admin form before saving the block.
- Reuse the same block configuration across pages by placing it in a shared region.
