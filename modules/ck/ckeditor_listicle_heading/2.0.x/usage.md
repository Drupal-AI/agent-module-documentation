<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Listicle Heading

CKEditor 4 plugin to insert numbered "listicle" headings (number + separator + title).


## What & when

- Use it to insert stylised numbered headings for listicle-style articles ("1. First tip", "2. Second tip").
- Produces a `div.listicle-heading` containing a heading (h1–h6) with `span.number`, `span.separator`, `span.title`.
- Targets the legacy CKEditor 4 editor.

---

## Install & configure

- `composer require drupal/ckeditor_listicle_heading` then `drush en ckeditor_listicle_heading -y`.
- Requires the CKEditor 4 (`ckeditor`) editor (used as an editor plugin).
- In a text format's CKEditor settings, add the **Listicle Heading** button to the toolbar.
- Allow the produced markup (`div`, `h2`/etc, `span[class]`) in the text format so it survives filtering.
- No permissions or routes.

---

## Usage & behaviour

- Insert a numbered heading via a dialog: pick the heading level, a number, and the title text.
- Edit an existing listicle heading; the dialog re-reads the number and title from the spans.
- The title field is required (validated non-empty in the dialog).
- Choose heading level h1–h6 from the dialog select (default h2).
- The number span gets class `number`, the separator `separator` (". "), the title `title`.
- The wrapper div carries class `listicle-heading` (and `has-number` when a number is set).
- Values are set via CKEditor's DOM API (setText/createElement), then filtered by the text format on output.
- A context-menu item is also registered for quick access inside div elements.
- Provides English language strings (`lang/en.js`).
- Styling of the numbered heading is left to the theme.
- Good for magazine/blog listicle layouts.
- No server-side data is stored beyond the produced HTML.
- Compatible with other CKEditor 4 plugins.
- Plugin id is `listicleheading`.
- The button is placed in the `insert` toolbar group.
