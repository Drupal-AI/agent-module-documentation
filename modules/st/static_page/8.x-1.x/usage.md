<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Page lets you designate node types whose entire page output is the verbatim contents of a single text-area field, bypassing Drupal's theme layer.

---

Some pages are just a self-contained block of authored HTML — a landing page, an embed target, a one-off document — where the site's regions, blocks, navigation and theme are unwanted. Static Page turns a chosen long-text field of a node type into the whole HTTP response: you map each content type to one of its `string_long`, `text_long` or `text_with_summary` fields on the settings form at `/admin/config/content/static_page`, and a request subscriber returns that field's stored value directly as the page when a node of that type is viewed (canonical or revision route). The node title is used only in the admin UI; the field holds the complete source code of the page, including any head, CSS or JS the author wants. Nothing from the Drupal theme is added. It is a small, focused way to serve raw authored pages from ordinary nodes while keeping them editable through the normal content workflow.

---

- Serve a node whose body is the entire HTML document.
- Build a one-off landing page with no site chrome.
- Produce an iframe/embed target that renders only the authored markup.
- Map a content type to its long-text field for static output.
- Create a "Static page" content type dedicated to raw markup.
- Bypass Drupal's theme layer for selected node types.
- Author a complete HTML page (head, style, script) in one text area.
- Keep static pages editable via the standard node edit form.
- Manage which content types are static from a single settings screen.
- Change the mapped field per content type at any time.
- Turn static behavior off for a type by selecting "-- None --".
- Serve a page with no sidebars, blocks, or menus.
- Host a bespoke marketing page inside a Drupal site.
- Provide a minimal maintenance/notice page as a node.
- Serve custom-styled campaign pages authored by editors.
- Use node revisions of a static page (the revision view also renders raw).
- Restrict who can reach the settings form via `administer site configuration`.
- Keep static content under version-controllable config (`static_page.fields`).
- Apply to multiple content types simultaneously.
- Serve exact hand-written HTML for pixel-perfect layouts.
- Deliver a page whose output must not include Drupal wrappers.
- Prototype a standalone page while reusing node storage.
- Publish documentation or embed snippets as raw pages.
- Confirm the mapped field type before enabling on a content type.
- Pair with a dedicated content type so normal pages are unaffected.
