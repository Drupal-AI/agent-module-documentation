<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Header Field (Navigation) adds a jump-menu block that builds an in-page anchor navigation from Advanced Header Field headings the editor opts in.

---

This submodule of Advanced Header Field lets a page offer a "jump menu" — a list of in-page anchor links between the sections marked by Advanced Header Field headings. It adds two options to each header value in the widget: a **Show in Jump Menu** checkbox and an optional **Short Title** used as the menu label. Headings that opt in render with `data-in-jump-menu` (and `data-short-title`) attributes on their `<header>` wrapper. A `Jump Menu` block (placeable via Block Layout) outputs an empty `<nav id="jump-menu">`, and its attached JavaScript scans the page for those headings and builds an unordered list of anchor links pointing at each heading's id. Requires the parent `advanced_header_field` module.

---

- Add an in-page "on this page" navigation to long content.
- Let visitors jump between page sections marked by Advanced Header Field headings.
- Opt individual headings into the jump menu with the Show in Jump Menu checkbox.
- Give a heading a shorter menu label via Short Title when the heading text is long.
- Place the jump menu anywhere via Block Layout (the "Advanced Header Field Jump Menu" block).
- Build the anchor links client-side so no extra server routes or queries are needed.
- Reuse each heading's generated or custom anchor id as the link target automatically.
- Fall back to the heading's own text as the menu label when no short title is given.
- Provide a themeable `<nav class="jump-menu">` wrapper (`ahf-navigation-jump-menu.html.twig`).
- Style the generated list with `jump-menu__list` / `jump-menu__list-item` BEM classes.
- Add a table-of-contents style navigation to landing pages, documentation, or FAQs.
- Keep the menu in sync with content: only opted-in, currently rendered headings appear.
- Work with any entity type that carries an Advanced Header Field.
- Add section navigation to Layout Builder pages built from header fields.
- Avoid manual anchor bookkeeping — anchors and labels come from the heading values.
