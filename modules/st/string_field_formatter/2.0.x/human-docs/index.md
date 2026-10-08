# String Field Formatter — manual setup guide

**String Field Formatter** (`string_field_formatter`) adds one display
formatter, **"Plain string formatter"**, for plain-text `string` and
`string_long` fields. Its job is simple: it wraps the field's output in an HTML
tag of your choosing — a heading, a `<span>`, a `<blockquote>`, and so on — with
optional CSS classes, so you can turn a plain-text field into properly marked-up,
styleable output without writing a Twig template or reaching for a formatted-text
field.

A typical use is a "Subtitle" or "Section title" string field that you want
rendered as a real `<h2>` heading. Instead of overriding a template, you select
this formatter on the bundle's *Manage display* page, pick the wrapper tag, and
add whatever classes your CSS or JavaScript needs to target. When you leave the
wrapper tag set to its default of *none*, the output is identical to core's
string formatter — so it is safe to switch to.

This is a **display-only** module: there is no settings page, no permissions, no
Drush commands, and nothing to configure globally. Everything happens on the
*Manage display* form, per field and per view mode.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full list of
wrapper tags and the stored config keys — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The formatter appears automatically on any `string` or `string_long` field:

1. Go to the bundle's **Manage display** page — for example
   **Structure → Content types → Article → Manage display**
   (`/admin/structure/types/manage/article/display`).
2. Find your plain-text field and set its **Format** to **Plain string
   formatter**.
3. Click the gear/cog icon on that row to open the settings, then choose:
   - **Wrapper tag** — the HTML element to wrap each value in. Options include
     `h1`–`h6`, `p`, `blockquote`, `pre`, `span`, `div`, `code`, `em`, `strong`,
     `time`, and many more semantic tags. Leaving it at **- None -** produces the
     same output as core's string formatter (no wrapper).
   - **Classes for wrapper tag** — a space- or comma-separated list of CSS
     classes to put on the wrapper (each is cleaned up into a valid class name).
4. Click **Update**, then **Save**. The display summary will read something like
   *"Wrapper tag: H2 / Classes: field-title"*.

Because settings are stored per view mode, you can render the same field
differently in different contexts — for instance an `<h2>` on the full page and a
plain `<span>` in a teaser. The formatter also keeps core's **Link to the
Content** option, so you can still link the value to its entity.
