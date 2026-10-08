# Media Library Modal Dimensions — manual setup guide

**Media Library Modal Dimensions** (`media_library_modal_dimensions`) lets site
builders set the **width and height of the Media Library modal on a per‑field
basis**. Some media pickers benefit from a wider or taller dialog — image galleries
and video browsers, for example — while others are fine at core's defaults. This
module lets each field pick its own size, without custom JavaScript or global theme
overrides.

The settings are added straight into Drupal core's existing widget settings UI, so
there are no new admin pages, no custom routes, and nothing extra to manage. It
works with any field, on any entity type, that uses the Media Library widget —
content types, paragraphs, and custom entities alike. The dialog size accepts
percentages, pixel sizes (integer or decimal), or `auto`, and the module uses a
forward‑compatible wrapper pattern designed to survive expected core refactors of
the Media Library widget.

This is a UI configuration enhancement with no content or access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings form** — the new options appear directly on each
Media Library widget's settings, so configuration happens per field as described
below.

## Where it lives in the admin menu

The module adds no admin page. You set the dialog size on each field's widget
settings under **Manage form display** for the entity that uses the Media Library
widget.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage form display**
   — or the equivalent screen for any entity that uses a Media Library widget.
2. Click the **gear icon** next to a field that uses the **Media library** widget.
3. Set **Media Library dialog width** and/or **Media Library dialog height** to one
   of:
   - a **percentage** — for example `75%` or `95%`,
   - a **pixel size** — for example `900px` or `1200px`, or
   - `auto`.
4. Click **Update**, then **Save** the form display.

Leave either field empty to keep Drupal core's default of **75%**.
