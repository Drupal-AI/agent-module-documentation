# Heading — manual setup guide

**Heading** (`heading`) gives you a structured way to store and render HTML headings
as field data instead of hardcoding markup in Twig. It provides a **`heading` field
type** that stores a text string plus a heading level (h1–h6) and renders it as a
real heading element — and, separately, a **`heading_text` formatter** that lets you
output an existing plain-text or formatted-text field as a heading of your chosen
level.

The `heading` field type is ideal when editors should choose both the text *and* the
level of a heading — a "section title" on a paragraph, a banner heading on a hero
component, or FAQ item titles. Its widget shows a text input and a size selector, and
you can constrain which levels editors may pick (for example only h2 and h3). Lock it
to a single level and the selector disappears, applying that level automatically.

The `heading_text` formatter is the lightweight option: it needs no new field. Point
it at an existing `string` or `text` field, choose a size, and the field's value is
wrapped in a heading of that level on display. Both the field type and the formatter
skip empty values, so you never get an empty `<h2></h2>` in your markup.

The module registers a `heading` theme hook (with a `heading.html.twig` template you
can override in your theme) and exposes `size` and `text` tokens for every heading
field. It has no admin settings page, no permissions, and no Drush — everything is
configured through the entity's *Manage fields* and *Manage display* screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Heading has no settings page of its own. You use it through the standard field
screens on any content type, paragraph, media type, or other entity:

- **Manage fields** — to add a `heading` field.
- **Manage display** — to apply the `heading` or `heading_text` formatter.

## How to use it

### Add a `heading` field

1. On a bundle's **Manage fields** page, add a field of type **Heading**.
2. In the field settings, adjust:
   - **Label** — the label shown above the text input in the editing form (default
     "Heading").
   - **Allowed sizes** — checkboxes for which levels (h1–h6) editors may choose. Tick
     only h2 and h3, for example, to constrain the heading hierarchy. If you allow
     exactly one size, the widget hides the selector and applies that level
     automatically.
3. Editors then get a text field plus a size selector when creating content, and the
   value renders through the `heading` formatter as `<h2>Your text</h2>` (using the
   `heading.html.twig` template).

### Render an existing field as a heading (`heading_text` formatter)

Use this to output a plain `string` or `text` field as a heading without adding a new
field:

1. Go to the entity's **Manage display** (for example
   `/admin/structure/types/manage/article/display`).
2. On a **string** or **text** field's row, choose the **Heading** format.
3. Click the cog, pick the **Size** (h1–h6, default h2), **Update**, then **Save**.

The field value is wrapped in a heading of that level — `text` fields are rendered
through their text format, and `string` fields keep line breaks. Empty values are
skipped.

### Tokens and theming

- Every heading field advertises `size` and `text` tokens (for example
  `[node-field_section_heading:size]`), usable in metatags, pathauto, and anywhere
  tokens are accepted.
- Override the markup site-wide by copying `heading.html.twig` into your theme; it is
  simply `<{{ size }}>{{ text }}</{{ size }}>`.
