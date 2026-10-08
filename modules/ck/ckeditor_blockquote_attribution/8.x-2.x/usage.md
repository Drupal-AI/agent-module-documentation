<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Blockquote Attribution

CKEditor 4 button that inserts a blockquote with HTML5 figure/figcaption source attribution.


## What & when

- Use it to let editors create properly-marked-up quotations with an attributed source.
- Wraps the selected text in `<figure><blockquote>…</blockquote><figcaption>Source</figcaption></figure>`.
- Targets the legacy CKEditor 4 (`ckeditor`) editor.

---

## Install & configure

- `composer require drupal/ckeditor_blockquote_attribution` then `drush en ckeditor_blockquote_attribution -y`.
- Requires the CKEditor 4 (`ckeditor`) module.
- In a text format's CKEditor settings, drag the **Blockquote Attribution** button into the toolbar.
- Ensure the text format allows `figure`, `figcaption`, `blockquote[cite]` so the markup survives filtering.
- No permissions or routes.

---

## Usage & behaviour

- Insert a quotation block and type the source in the dialog's **Source** field.
- Produce semantic, accessible quote markup (figure + figcaption) instead of a bare blockquote.
- Editing an existing attribution repopulates the Source field from the `cite` attribute.
- The dialog is provided via CKEditor 4's dialog plugin (`requires: ['dialog']`).
- Toggling on selected paragraphs wraps them; toggling off unwraps nested blockquotes.
- Handles multiple selected paragraphs and normalises common ancestry.
- Prevents nested blockquotes by unwrapping any blockquote inside the selection.
- Works with both ENTER_P and ENTER_BR editor modes.
- The button lives in the `blocks` toolbar group.
- The citation text is set via CKEditor's DOM API (setText), then filtered by the text format on output.
- Output styling is left to the theme (figure/figcaption/blockquote).
- No content is stored server-side beyond the produced HTML.
- Useful for editorial/journalistic content with quoted sources.
- Compatible alongside other CKEditor 4 plugins.
- Plugin id is `blockquote_attribution`.
