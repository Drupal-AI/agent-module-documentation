# Text with Title — manual setup guide

**Text with Title** (`text_with_title`) is a compound field type that stores a
**title** alongside a **formatted text body** in a single field. Each value
holds one title plus one rich-text area, so a repeating "heading + content"
pattern needs one multi-value field instead of two parallel ones.

That pattern is everywhere: FAQ entries (question + answer), feature blocks
(heading + description), accordion sections (label + body). If you model it with
two separate multi-value fields, you have to keep the two lists aligned by
position — reorder one and they drift out of sync, which is fragile. Paragraphs
can solve it too, but it is heavier machinery than a plain heading-and-text
really needs. Text with Title keeps the two parts together as one unit, so a
multi-value instance is a clean list of titled sections that move, sort and
delete together.

The field ships with three built-in **formatters** for displaying the values:

- a **simple list** formatter, showing each title-and-text pair in a list;
- an **accordion** formatter, rendering the pairs as a Bootstrap accordion; and
- a **tabs** formatter, rendering them as Bootstrap nav tabs.

The accordion and tabs formatters assume Bootstrap markup, but if you do not use
Bootstrap you can override the markup through the theme functions
`text_with_title_panel` and `text_with_title_tabs` respectively.

Text with Title depends only on core's **Field** module and runs on Drupal 8, 9,
10 and 11. Because it is a distinct field type, the usual caveat applies: you
choose it when the field is created, and converting existing separate fields to
it is an add-and-migrate exercise rather than an in-place change. The form widget
and display are the module's own, so check they suit your theme before committing
a lot of content to it.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module adds a new field type; there is no separate settings page:

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type (or paragraph type, or other fieldable entity), go to
   **Manage fields → Add field** and choose the **Text with Title** field type.
   Set it to allow multiple values if you want a repeating list of sections.
3. On **Manage display**, pick one of the three formatters — simple list,
   accordion or tabs — for how the titled sections should appear.
4. Editors then fill in a title and body for each value on the entity's edit
   form.
