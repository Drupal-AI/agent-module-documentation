<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the invisible 'Anchor' Paragraphs bundle whose only job is to place a linkable in-page HTML anchor.

---

A one-bundle submodule of DROWL Paragraphs for Bootstrap. The `anchor` paragraph type renders no visible content: its template outputs an empty `<div>` carrying the editor-supplied anchor id and, when set, a `data-anchor-menu-title`/scrollspy data attribute. It is meant to be dropped between other paragraphs so links (`#anchor`) and one-page / scrollspy navigation menus can jump to that position.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Add a jump target inside a long landing page so a `#section` link scrolls to it.
- Build a single-page (one-pager) site where a sticky menu scrolls between anchored sections.
- Give an editor a named waypoint without exposing raw HTML.
- Feed a scrollspy/on-site menu using the anchor's `data-anchor-menu-title`.
- Mark a position referenced from another page via `page#anchor`.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
