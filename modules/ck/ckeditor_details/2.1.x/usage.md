<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Accordion (Detail Plugin) adds an "Add accordion" toolbar button to CKEditor 5 that inserts a native HTML5 `<details>`/`<summary>` accordion, so editors can create collapsible content without custom markup or JavaScript.

---

The module registers a CKEditor 5 plugin (`ckeditor_details_detail`, JS plugin `detail.Detail`) that provides a single toolbar item, **`detail`** (labelled "Add accordion"). When an editor clicks it, CKEditor inserts a `<details>` element with a `<summary>` and a `<div class="details-wrapper">` body — the browser then renders it as a click-to-expand accordion natively, no runtime JS needed. You enable it per text format on *Configuration → Content authoring → Text formats and editors*: drag the Detail button into a CKEditor 5-enabled format's toolbar, which stores it in that format's editor config, and make sure the format's HTML filter allows the elements the plugin declares (`<details>`, `<summary>`, `<div>`, `<div class="details-wrapper">`). The module also ships a legacy CKEditor 4 plugin and a CKEditor 4→5 upgrade plugin (`ckeditor_details`, mapping the old `detail` button) so formats migrated from CKEditor 4 keep working. There is no admin settings page and no module configuration of its own (`configure: null`); all configuration lives on the individual text formats. It depends only on core's CKEditor 5.

---

- Add a collapsible FAQ accordion to body content without writing HTML.
- Let editors create expand/collapse sections for long documentation pages.
- Insert a native `<details>`/`<summary>` block that works with no JavaScript.
- Provide "read more" style collapsible panels inside rich text.
- Add the accordion button to the Full HTML format for privileged editors.
- Add it to a custom "Article body" text format used by content authors.
- Structure terms-and-conditions or policy pages into collapsible clauses.
- Build a spec sheet where each section can be expanded on demand.
- Give editors accessible, semantic collapsible content (native disclosure widget).
- Migrate an old CKEditor 4 accordion/detail button to CKEditor 5 automatically on upgrade.
- Keep accordion markup clean and consistent across the site (fixed element structure).
- Allow nested content (lists, images) inside a collapsible details body via the wrapper div.
- Reduce page length by collapsing secondary information by default.
- Offer collapsible "notes" or "tips" callouts within articles.
- Ensure the format's allowed-HTML list permits `<details>`/`<summary>` so the markup survives filtering.
- Add accordions to a knowledge-base content type's rich-text field.
- Provide a toolbar-driven way to author disclosure widgets for mobile-friendly pages.
- Standardize collapsible sections instead of relying on per-theme JS accordion scripts.
- Let a marketing format include collapsible feature comparisons.
- Enable accordions only on specific formats while leaving others plain.
