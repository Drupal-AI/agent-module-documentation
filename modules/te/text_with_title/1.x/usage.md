<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text with Title is a field type that stores a title alongside a formatted text body in a single field, so a repeating "heading plus content" pattern needs one multi-value field instead of two parallel ones.

---

The pattern is everywhere: FAQ entries (question + answer), feature blocks (heading + description), accordion sections (label + body). Modelled with two separate fields, a multi-value version forces you to keep two field deltas aligned by position, which is fragile — reorder one and they drift apart. Paragraphs solves it but is heavier than a single heading-and-text needs.

This field type keeps the two parts together. Each value holds a title and a formatted text area, so a multi-value instance is a clean list of titled sections that move, sort and delete as units. It is the right weight for the case that is genuinely just "a heading and some text, repeated" — lighter than a paragraph type, sturdier than two parallel fields.

Being a distinct field type built on core `field`, the usual caveat applies: it is chosen when the field is created, and converting existing separate fields to it is an add-and-migrate exercise, not an in-place change. It also means the display and form widget are the module's, so check they suit your theme before committing content to it. For the repeating titled-section case, it is a small, fitting tool.

---

- Store a title with a text body.
- Model FAQ entries as one field.
- Build repeating titled sections.
- Keep heading and content aligned.
- Avoid two parallel fields.
- Make an accordion's label and body one unit.
- Reorder titled sections safely.
- Use a lighter alternative to Paragraphs.
- Add feature blocks with headings.
- Keep multi-value sections consistent.
- Sort titled sections as units.
- Delete a section without misalignment.
- Choose the field type at creation.
- Plan a migration from two fields.
- Render a list of titled text blocks.
- Model a simple heading-plus-text repeater.
- Keep the data model simple.
- Build a structured content list.
- Use core field storage.
- Author titled content inline.