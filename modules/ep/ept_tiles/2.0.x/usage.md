<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Tiles adds a ready-made **Tiles** paragraph type — a responsive grid of one to four columns where each tile carries a title, WYSIWYG text, a media image and an optional link — as part of the Extra Paragraph Types family, sharing `ept_core`'s design settings for spacing, background and container width.

---

Paragraphs supplies the mechanism for component-assembled pages and, deliberately, no components: every project defines its own card grid and rebuilds the same one. EPT is a library of those pre-built types, with a shared `ept_core` providing the common design widget — CSS box (margins/padding/borders), background colour/image, edge-to-edge, container width — so each type stays small and mutually consistent. Tiles is the grid one. It ships **two** paragraph types: the container `ept_tiles` (with a Title, an optional intro Text, the `field_ept_settings` design field, and `field_ept_tiles` holding the child tiles) and the item `ept_tiles_item` (per tile: `field_ept_tiles_title`, `field_ept_tiles_text` rich text, `field_ept_tiles_image` referencing a Media image, a `field_ept_tiles_link`, and a `field_ept_clickable_tile` boolean that wraps the whole tile in the link's anchor). A "Styles" radio on the container — one/two/three/four columns (default three) — selects which CSS library is attached, and a Links sub-form toggles `target="_blank"` and `rel="nofollow"` on the tile links. Version **2.0.1**, requiring `ept_core` and `paragraphs` (and Media, pulled in by `ept_core` for background and tile images), with a core requirement of `^10.1 || ^11 || ^12` that reaches into a core major that does not yet exist. What to weigh: a pre-built type is quick to adopt and awkward to diverge from — the markup and field set are the module's, so a design the settings don't cover means overriding its Twig templates, and at that point a locally defined type may be cheaper. It also becomes a dependency of the content: removing it later leaves paragraph entities with no type. Good case — a site that wants a competent card grid now with no strong opinion about its markup; poor case — a design system with definite ideas.

---

- Add a responsive grid of tiles/cards to a page or Layout Builder region.
- Build a services overview as three feature boxes.
- Show product or content categories as a grid of image tiles.
- Make each whole tile clickable through to a landing page.
- Add a grid of links, each with a title and short rich-text blurb.
- Build a "why choose us" benefits row.
- Lay out a team overview with a photo and bio per tile.
- Present a resources or downloads grid.
- Switch a section between one, two, three or four columns without touching CSS.
- Open tile links in a new tab for outbound/partner links.
- Add `rel="nofollow"` to tile links for SEO control on user-facing link grids.
- Give editors a ready-made card component instead of hand-building one.
- Prototype a homepage feature section quickly.
- Add a container title above a grid of items.
- Apply consistent EPT spacing/background settings to a grid section.
- Show a set of icon-plus-text feature tiles.
- Build a portfolio or case-study grid.
- Create an image-led navigation grid on a landing page.
- Add a media-backed section with an overlay via ept_core background settings.
- Reuse one shared component library across many pages for visual consistency.
