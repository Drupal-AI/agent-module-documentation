<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Storyline is a configuration-only Drutopia feature that ships two Storyline Paragraphs types plus a node field so editors can build a simple chronology or timeline out of a sequence of paragraphs.

---

Drutopia Storyline installs one `entity_reference_revisions` field, `field_storyline` (multi-value, target type paragraph), on the node entity type, and two Paragraphs bundles that populate it: `storyline_header` (a single `string` field `field_storyline_header`) and `storyline_item` (a `string` heading `field_storyline_heading` plus a `text_long` body `field_text`). Each bundle gets a default form display and a default view display; the `storyline_item` view display wraps its heading and text in a `field_group` `html_element` group named `group_storyline_content`. Everything is delivered as `config/install/` YAML — there is no PHP `src/`, no `.module`/`.install`, no routes, permissions, services, config schema, or Drush commands. It is a Drutopia `features` bundle (`drutopia_storyline.features.yml`: `bundle: drutopia`, `required: true`) and depends on the Drutopia family (`drutopia_core`, `drutopia_page`) plus Paragraphs, Entity Reference Revisions, Field Group, Field, Node and Text. The project directory also bundles a companion sub-feature, `drutopia_page_storyline`, that attaches `field_storyline` to the Basic page content type; that companion is documented separately. To use the module you enable it (importing the paragraph types, fields and displays), attach `field_storyline` to your content type (or install the companion for Basic page), and let editors add a storyline_header followed by repeatable storyline_item paragraphs.

---
- Build a simple chronology or timeline on a content page.
- Add a repeatable sequence of storyline entries to a node.
- Provide editors a structured alternative to hand-written timeline HTML.
- Give a storyline an introductory header line via the `storyline_header` paragraph.
- Add individual timeline entries with the `storyline_item` paragraph.
- Give each timeline entry a short heading (`field_storyline_heading`).
- Give each timeline entry a formatted body (`field_text`, `text_long`).
- Group an item's heading and text together in the display via Field Group.
- Reorder timeline entries by dragging the Paragraphs items in the node form.
- Reference the storyline paragraphs from any node type via `field_storyline`.
- Attach a storyline to the Basic page type using the bundled companion module.
- Reuse the same storyline paragraph types across multiple content types.
- Keep the storyline structure exportable and consistent as site configuration.
- Translate storyline heading, header and text (fields are translatable).
- Render storyline items with hidden field labels for a clean timeline layout.
- Exclude storyline fields from Search API excerpts (configured in the view display).
- Ship a Drutopia site with a ready-made timeline/story feature.
- Extend the storyline_item body formatting by changing the text format used.
- Customize the storyline markup by overriding the paragraph view displays.
- Combine storyline paragraphs with other paragraph types in a page body.
