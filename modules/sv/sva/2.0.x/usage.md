<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Views Accordion provides a Views style plugin that renders each result row as a collapsible native `<details>` element — a JavaScript-free accordion.

---

Simple Views Accordion adds a Views display style that renders results as an accordion. Each row becomes a
native HTML `<details>` element: its summary (header) is the first field of the row, or the entity label when
the display does not use fields, and the row content is the expandable body. It is a lightweight, dependency-free
way to present FAQs, feature lists or grouped content compactly, letting visitors expand the item they want. It
depends only on core Views.

In 2.0.x the module ships **no JavaScript and no library**. Exclusive behaviour — opening one item closes the
others — is produced by the browser's native exclusive-accordion support: the `<details>` elements rendered for
one display share a unique `name` attribute. Each rendered accordion gets its own unique name, so several
accordions (or grouping sections) on the same page stay independent; browsers without support simply allow several
items to be open. Three style options control it: a wrapper class, "allow multiple open at once", and "open the
first item by default". It remains a pure display/presentation style — it changes how View results are rendered,
not the results or their access; the View's own access still governs what appears.

---

- Render a View as a JavaScript-free accordion.
- Show results as collapsible native `<details>` sections.
- Build a FAQ accordion from a View.
- Present grouped content compactly.
- Let visitors expand the item they want.
- Depend only on core Views (no library, no JS).
- Select "Simple Views Accordion" as the View format.
- Use the first field of the row as the accordion summary/header.
- Fall back to the entity label as summary when the display renders entities (no fields).
- Add an excluded-from-display field at the top to set the summary without repeating it.
- Allow only one item open at a time (native exclusive accordion via the `name` attribute).
- Allow multiple items to be open at the same time instead.
- Open the first item by default on load.
- Open the first item of each group when grouping is used.
- Run several independent accordions on one page (unique per-render name).
- Set a wrapper CSS class around all rows.
- Display feature lists as an accordion.
- Change rendering, not results.
- Respect the View's access.
- Collapse rows into expandable sections.
- Use on Drupal 11.3+ or Drupal 12.
- Upgrade existing 1.0.x views without changes (plugin id auto-renamed).
