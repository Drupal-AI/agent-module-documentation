# Body Index — manual setup guide

**Body Index** (`body_index`) builds a table of contents from the headings inside
a long‑form text field and displays it as a linked index. It is a **field
formatter**: you apply it to a formatted‑text field (such as a node's Body), and
when the content renders, the module scans the field's HTML headings and outputs
a jump‑to navigation of the page's sections.

It is aimed at long content — documentation, handbooks, in‑depth articles — where
readers benefit from being able to skip straight to a section. The index stays in
step with the content because it is generated from the headings actually present
in the field, and it is rendered through the module's own Twig template with no
third‑party JavaScript. This release targets Drupal 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the formatter
and template file names — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The table of contents is switched on per field, on the entity's display settings:

1. Go to the **Manage display** screen for the content type (or other entity)
   whose field you want to add an index to — for example
   **Structure → Content types → [type] → Manage display**.
2. For the formatted‑text field (such as **Body**), choose the **Body Index**
   formatter from the format dropdown.
3. Adjust any formatter settings offered, then save.

When that content renders, Body Index parses the field's headings and outputs a
linked index of its sections.
