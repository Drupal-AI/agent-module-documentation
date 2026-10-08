<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
W3CSS Paragraphs is a page-building component set for Drupal Paragraphs styled with the standalone W3.CSS framework (no jQuery grid, no Bootstrap). The base project provides three paragraph types — Simple, Image and a reusable multi-column/tab "Shared" container — plus a dedicated image media type; 23 bundled submodules add the richer components (card, hero, tabs, accordion, slideshow, 3D carousel, modal, parallax, columns, views, webform and more), each enabled independently.

---

Each bundle carries a large set of `w3css_display_*` option fields (background/text/border colors and their hover variants, opacity, borders, rounded corners, card shadow, margin, padding, width) exposed as fixed W3.CSS allowed-value lists, so editors compose a component's look from dropdowns without writing CSS; the Simple bundle adds one free-text `w3css_display_classes` field for arbitrary extra W3.CSS class names. Rendering is done entirely in Twig template overrides (`paragraph--w3css-simple`, `paragraph--w3css-image`, `paragraph--default`, and an entity-reference-revisions field wrapper) that merge the selected options into the container's class list via `attributes.addClass()` and compose an inline `rgba()` background from the color + opacity fields. The module ships no settings form, no permissions and no Drush; all behavior lives in `config/optional` config entities and templates. Its CSS/JS libraries are bundled locally (no CDN) and depend on `core/jquery`/`core/drupal`/`core/once`; the full W3.CSS grid/color framework itself is expected from the companion theme (W3CSS, being renamed **Solo**), with **Paragraphs Bundles** named as this module's successor. Contrib dependencies (`paragraphs`, `entity_reference_revisions`, `field_group`) are declared unpinned (`*`) in composer.json.

---

- Build a landing page from ready-made W3.CSS components.
- Add a hero unit without writing custom theme code.
- Give editors cards, tabs and accordions as paragraphs.
- Build a two- or three-column section with nested paragraphs.
- Add a slideshow or 3D carousel paragraph.
- Embed a view inside a page component (via the views submodule).
- Place a webform as a page section (via the webform submodule).
- Add a modal or 3D flip-box component.
- Use a CSS framework that does not require jQuery for layout.
- Enable only the component submodules a site actually needs.
- Prototype a page layout quickly from dropdown-styled blocks.
- Give a small site a reusable component library.
- Add a parallax section.
- Embed a Drupal block or custom block content as a paragraph.
- Build a quicklinks panel.
- Let editors pick background/text/border colors from W3.CSS option lists.
- Add rounded corners, card shadows, margins and padding per paragraph.
- Add an image overlay component.
- Reference a media image inside a styled paragraph.
- Set a per-paragraph background color with adjustable opacity.
- Add arbitrary extra W3.CSS classes to a Simple paragraph.
- Wrap a paragraph image in a link with a title attribute.
- Support a site still on Drupal 9, 10 or 11.
