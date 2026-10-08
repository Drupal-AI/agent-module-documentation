<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Table of Contents builds a "Page with sections" node type from nested Paragraphs and auto-generates an in-page table of contents from that structure — one jump link per paragraph.

---

The module is a small, configuration-driven package (its author calls it "basically a proof of concept") that turns Paragraphs into navigable long-form pages. Installing it ships a `ptoc_page` node type ("Page with sections") whose `field_ptoc_sections` field references paragraphs, four paragraph types (`ptoc_text`, `ptoc_container`, `ptoc_image`, `ptoc_links` — each with a `field_ptoc_title`), a `ptoc` ("Table of Contents") view mode for both paragraphs and nodes, and a `ptoc` View exposing a **ToC block** that renders the current node in the `ptoc` view mode using the page's node ID as a contextual argument. The mechanism is almost entirely core Field/View-mode/Views configuration plus a thin `.module` glue: `ptoc_preprocess_paragraph()` stamps `id="paragraph-<pid>"` onto each paragraph in the **default** view mode so it can be an anchor target and copies the first `ptoc`-mode field into `ptoc_link_text`; `ptoc_theme_suggestions_paragraph()`/`_node()` swap in the module's `ptoc-paragraph.html.twig` / `ptoc-node.html.twig` templates for the `ptoc` view mode; the paragraph template emits `<a href="#paragraph-<pid>">{{ link_text }}</a>` where `link_text` is the rendered content of the first enabled field. Anchors are therefore keyed on the **stable numeric paragraph id**, not on heading text, so shared deep links survive edits. There are no headings-parsing, no regex/DOM scanning, and no PHP string building of markup — the link label is a rendered field render-array, auto-escaped by Twig. A single admin form at `/admin/structure/paragraphs_type/ptoc` (permission `administer paragraphs types`, also the `configure` link) selects which paragraph types get the `ptoc` display mode and which of their fields appear in it (the first enabled field becomes the link text), and toggles a **debug** mode (`ptoc.settings:debug`) that outlines every paragraph via the `ptoc/ptoc-debug` CSS library. To add a ToC to an existing content type you re-use `field_ptoc_sections`, enable the `ptoc` display, and point the View/block at that bundle. Version `8.x-1.4`, core `^8 || ^9 || ^10 || ^11`, with a wide dependency list (`block`, `entity_reference_revisions`, `field`, `file`, `image`, `link`, `menu_ui`, `node`, `paragraphs`, `path`, `text`, `user`, `views`) because it ships the paragraph types as well as the contents logic.

---

- Build a long "Page with sections" node from nested paragraphs.
- Auto-generate an in-page table of contents from paragraph structure.
- Place the ToC block in a sidebar for jump navigation.
- Add a contents list to a policy or handbook page.
- Structure a long report into titled sections.
- Keep a contents list in step with content without manual editing.
- Give each section a stable `#paragraph-<id>` anchor for deep links.
- Show nested sub-sections in the ToC via container paragraphs.
- Choose which paragraph field supplies each ToC link's text.
- Add a ToC to an existing content type by re-using `field_ptoc_sections`.
- Enable additional paragraph types for the ToC via the config form.
- Hide non-title fields from the ToC display mode.
- Turn on debug mode to outline paragraphs while laying out a page.
- Build a guidance or specification page with in-page navigation.
- Structure a course or manual into modules and lessons.
- Provide keyboard-reachable, screen-reader-navigable section links.
- Clone the ToC View/block to target different pages or bundles.
- Render the current node's sections as links via a Views block argument.
- Give a knowledge-base article a sidebar contents panel.
- Add jump links to an annual report or legal document.

