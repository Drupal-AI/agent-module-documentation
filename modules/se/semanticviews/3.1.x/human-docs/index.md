# Semantic Views — manual setup guide

**Semantic Views** (`semanticviews`) gives site builders precise control over the
**HTML markup a view outputs** — the exact element and attributes used for the
wrapper, the list, each row, and each field — right from the Views UI, without
writing a Twig template.

Out of the box, Views wraps things in generic `<div>`s. If your design system or
accessibility requirements call for `<article>` rows, a real `<ul>`/`<ol>` list, a
definition list, `<time>` elements around dates, or specific classes and ARIA
attributes, you'd normally override a template. Semantic Views lets you set all of
that through form fields instead. It's a pure markup tool: it changes the HTML a
view emits, not the data the view selects.

The module adds two Views plugins. The **style** plugin ("Semantic Views Style")
is an alternative to "Unformatted list" and controls the grouping title, the list
wrapper, and the rows — including striping classes and "first/last" classes. The
**row** plugin ("Semantic Views Row") controls, per field, the element and
attributes for both the field value and its label, plus a "skip empty fields"
toggle. Attributes are entered one per line in a simple `attribute|value` syntax,
and values accept Views tokens plus a `{{ row_index }}` token for the row number.
Semantic Views **requires only core Views**, has **no settings page, permissions,
or Drush commands**, and stores everything inside the view's own configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including every plugin
option, the attribute syntax, and the templates — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Semantic Views has no page of its own. You use it inside the **Views UI**
(**Structure → Views**), by choosing its plugins in a view's *Format* section.

## How to use it

1. Edit a view at **Structure → Views** (`/admin/structure/views`).
2. In the **Format** section, click the current **Format** (for example
   "Unformatted list") and choose **Semantic Views Style**. Apply it.
3. Click **Settings** next to the style to set the element type and attributes for
   the **grouping title** (default `h3`), the **list** wrapper (none, `ul`, `ol`,
   `dl`, or `div`), and each **row** (default `div`). Here you can also add row
   **striping classes** (default `odd even`), a **first** and **last** class, and a
   "first/last every nth" interval — handy for CSS grids.
4. For per-field control, also set the row format to **Semantic Views Row**. Its
   settings let you choose the element and attributes for each field's value and
   its label, and whether to skip empty fields.

**Entering attributes.** In any attributes box, put one attribute per line as
`attribute|value` (a line with no `|` is used as both the name and the value). For
example `class|card` or `role|listitem`. Values are run through Views token
replacement, and you can use `{{ row_index }}` to insert the zero-based row number
— useful for staggered styling or data attributes.

Because the settings live in each display, you can give the page and block
displays of the same view different markup.
