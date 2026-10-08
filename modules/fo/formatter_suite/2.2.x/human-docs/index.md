# Formatter Suite — manual setup guide

**Formatter Suite** (`formatter_suite`) is a collection of 18 general‑purpose field
formatters that give site builders and editors far more control over how numbers,
dates, timestamps, text, links, email addresses, files, images, and entity/user
references are displayed. Everything is configured the normal way — per field on an
entity's *Manage display* tab (and in Views) — so you get richer, settings‑driven
output without writing custom formatters or template overrides. The module is
maintained by the San Diego Supercomputer Center (SDSC).

The formatters cover several families. **Number** formatters add decimal places,
positive/negative notation styles, thousands and decimal separators, zero padding,
scientific and percentage notation, a byte‑size suffix (KB/MB/GB), a min/max
annotation, and a horizontal bar‑indicator gauge. **Date, time, and timestamp**
formatters render multi‑value date fields as lists with named or custom formats, or
as relative "time ago" text. **Link, file, email, and reference** formatters add
configurable title text, custom CSS classes, `rel`/`target` handling,
open‑in‑new‑window behavior, and list separators. **Image and text** formatters add
link wrapping around images, inline base64 `data:` URL images, and a "text with
expand/collapse buttons" formatter that truncates long text with JavaScript show/hide
controls.

There is no admin settings page and no permissions — each formatter stores its
settings in the field's display configuration, right where you pick it. Admin‑entered
strings such as custom link titles and list separators are sanitized before output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You choose a Formatter Suite formatter per field
on each bundle's **Manage display** tab — for example **Structure → Content types →
[type] → Manage display** — or in a **View**'s field format settings.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Manage display** for the entity/bundle whose field you want to restyle
   (or edit a field in a View).
3. In the **Format** column for your field, pick the relevant Formatter Suite
   formatter, then click the gear/cog to adjust its settings, and **Save**.

The formatters available, by field type:

- **Numbers** (`integer`, `decimal`, `float`): *General number* (notation style,
  decimals, separators, zero‑padding, positive/negative styles), *Number with bar
  indicator* (a gauge scaled between a min and max), *Number with min/max* (value
  shown alongside its bounds), and *Bytes with KB/MB/GB suffix* (a byte count shown
  as a human‑readable size).
- **Dates and timestamps**: *Date & time list* and *Custom date & time list* for
  `datetime` fields, *Time ago list* variants for relative text, and *Timestamp
  list* for `timestamp`/`created`/`changed` fields.
- **Links, references, email, files**: *General link*, *General file link*,
  *General Email address* (a `mailto:` link with custom text), *General entity
  reference*, *General user reference*, and *Rendered entity list* (each referenced
  entity rendered in a chosen view mode). These add title‑text options, custom CSS
  classes, `rel`/`target` and open‑in‑new‑window handling, and list separators.
- **Images and text**: *General image* (wrap the image in a link to the file,
  entity, or a custom URL), *Image with embedded data URL* (inline the image as a
  base64 `data:` URI to save a request), and *Text with expand/collapse buttons*
  (truncate long text with JS show/hide buttons and custom labels).

Because settings live in the field's display config, there is nothing global to
manage — to change behavior later, revisit that field's *Manage display* settings.
