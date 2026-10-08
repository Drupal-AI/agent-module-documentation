<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Cards renders a grid of linked summaries — the most reused pattern on the web.

---

Three or four boxes, each with an image, a heading, a line of text and a link. Packaging it settles the questions that otherwise get answered differently on every page: how many per row at each breakpoint, what happens with an odd number, and whether the whole card is clickable or only the heading.

**The accessibility mistake card grids make most often is worth checking specifically.** If the whole card is a link, the link's accessible name must be the heading — otherwise a screen reader announces an entire paragraph as the name of a link. And a second link inside a clickable card produces invalid markup and unpredictable behaviour, which is the reason patterns like a text-only link title exist.

Beyond that it is the workhorse component: features, services, related content, team members, news teasers. If a site's component library has one thing, it is this.

---

- Show a grid of linked summaries.
- Present three feature cards.
- List services as cards.
- Show related content as cards.
- Introduce team members.
- Set cards per row per breakpoint.
- Handle an odd number of cards.
- Make the whole card clickable.
- Give the card link a sensible accessible name.
- Avoid nesting links inside a card.
- Reuse one card structure sitewide.
- Translate card content.
- Audit card grids for nested links.
- Standardise responsive card behaviour.
- Adapt the card design per project.
