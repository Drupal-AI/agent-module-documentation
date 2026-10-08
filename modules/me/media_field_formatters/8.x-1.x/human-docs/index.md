# Media Field Formatters — manual setup guide

**Media Field Formatters** (`media_field_formatters`) is a small collection of
miscellaneous field formatters for working with media entities — extra ways to
render media reference (and related core Media/Image) fields beyond what core
offers out of the box. Rather than adding an admin page or new content types, it
simply gives you additional options in the **Format** dropdown when you configure a
field's display. It depends only on Drupal core's Media module and runs on Drupal
10.3 and 11.

There is nothing to configure globally: you pick one of the provided formatters on
a field's *Manage display* and adjust that formatter's own settings there. The
media still renders respecting its own access — only media a visitor is allowed to
see is shown — and the module adds no access‑control role of its own.

The project is a grab‑bag of formatters designed to be handy for common media
display needs, and its maintainers welcome patches that add more. Which formatters
you see depends on the version you install; look for the module's options in the
Format list once it is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from a field's *Manage display*, described in "How to use it"
below.

## Where it lives in the admin menu

Media Field Formatters adds no admin page. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display**, where the
module's formatters appear in the **Format** column for eligible media/image
fields.

## How to use it

1. Go to the display settings for the entity whose field you want to format — for
   a content type, that is **Structure → Content types → *(type)* → Manage
   display** (`/admin/structure/types`), and similarly for media types,
   taxonomy, and so on.
2. Find the media reference (or Media/Image) field you want to change, and open the
   **Format** dropdown.
3. Choose one of the formatters provided by Media Field Formatters.
4. Click the formatter's settings gear to adjust its options, then **Save**. The
   new rendering takes effect immediately on the front end.
