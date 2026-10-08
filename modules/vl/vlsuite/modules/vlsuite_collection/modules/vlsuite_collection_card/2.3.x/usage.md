<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Collection Card renders a set of cards — the grid of linked summaries that appears on almost every landing page.

---

The card grid is the most reused pattern in web design and the one most often rebuilt: three or four boxes, each with an image, a heading, a line of text and a link. Doing it as a collection means the grid behaviour, the responsive breakpoints and the card structure are defined once.

The design questions this settles are the ones that otherwise get decided per page: how many cards per row at each breakpoint, what happens with an odd number, whether the whole card is the link or only the heading. A collection encodes those answers so pages are consistent.

One accessibility point that a card grid gets wrong more than anything else: if the whole card is clickable, the link's accessible name must be the heading, not the whole card's text — otherwise a screen reader announces a paragraph as a link name. And nesting a second link inside a clickable card produces invalid markup and unpredictable behaviour, which is what `link_title_formatter` and similar exist to avoid.

---

- Show a grid of linked summaries.
- Present three feature cards on a landing page.
- Set cards per row at each breakpoint.
- Handle an odd number of cards.
- Make the whole card clickable.
- Give a card link a sensible accessible name.
- Avoid nesting links inside a card.
- Reuse one card structure sitewide.
- Style cards with utility classes.
- Save a card grid to the section library.
- Translate card content.
- Show related content as cards.
- Audit card grids for nested links.
- Standardise responsive card behaviour.
- Adapt the card design per project.
