<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Read More Link shows a "Read more" link **only when there is more to read** — that is, when the teaser is actually shorter than the full text.

---

Drupal's read-more link is unconditional: it appears on every teaser, including the ones where the body is two sentences long and the teaser shows all of it. Clicking it then loads a page identical to what the visitor was already looking at, which is a small but persistent annoyance on any listing of mixed-length content, and a real one for screen-reader users navigating by links. This formatter compares the trimmed output with the full value and emits the link only when they differ. That comparison is the whole idea and the whole module: `src/` holds the formatter, with no routes, permissions or configuration, on core `^9 || ^10 || ^11`.

> **Documented from a development checkout.** In this environment composer resolved
> `drupal/smart_read_more_link` to **`2.0.x-dev`** — a git clone rather than a packaged release —
> even though tagged releases exist up to 2.0.7. The installed copy therefore has no `version:`
> line in its info file and carries a `.git` directory on disk. Pin a tagged version explicitly
> when installing it for real.

---

- Hide the read-more link when the teaser is complete.
- Avoid links that lead to identical content.
- Improve a mixed-length article listing.
- Reduce pointless links for screen-reader users.
- Clean up a teaser display.
- Show read-more only for trimmed text.
- Improve a news listing's usability.
- Avoid confusing short-content teasers.
- Reduce clutter in a card grid.
- Improve link quality for accessibility.
- Handle summary-or-trimmed fields correctly.
- Reduce bounce from unhelpful links.
- Improve a blog index page.
- Apply per field display.
- Support a listing of short notices.
- Improve a search results display.
- Reduce visual noise on teasers.
- Keep read-more meaningful.
