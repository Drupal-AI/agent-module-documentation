# Field Limiter — manual setup guide

**Field Limiter** (`field_limiter`) is a small display helper that renders only a *slice*
of a multi‑value field — say the first three tags out of twenty, or every value except the
first — without touching how the field is stored. It's a **wrapping formatter**: you pick
Field Limiter as a field's format, tell it which *real* formatter to wrap (any formatter
valid for that field type), and then set how many leading values to skip and how many to
show. Field Limiter trims the list and hands the survivors to the wrapped formatter, so the
items still render exactly as they normally would — there are just fewer of them.

This is handy in a lot of everyday display situations: show only the first referenced entity,
cap a long taxonomy list in a teaser while keeping the full list on the detail page, render
a "featured first item" separately from the rest, or reduce page weight by rendering fewer
images from a heavy multi‑value field. Because you can set it differently per view mode, the
same field can show one item in a teaser and all of them in the full display.

A couple of practical notes. Field Limiter only does something on fields whose **cardinality
is greater than 1** (multi‑value or unlimited) — on single‑value fields it offers no options.
And although it's advertised for entity‑reference fields, the module actually makes it
available on **every** field type on your site (text, number, link, image, media, and so on).

There is no settings page — you configure it per field on the **Manage display** tab. It has
no submodules, but it does require the contrib **Field Formatter** module (which provides the
wrapping machinery).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Field Formatter
   dependency) with Composer and enable both.

## Where it lives in the admin menu

Field Limiter has no admin page of its own. You use it on the **Manage display** tab of any
fieldable entity — for content types that's **Structure → Content types → [type] → Manage
display** (`/admin/structure/types/manage/{type}/display`).

## How to use it

1. Enable Field Limiter and its **Field Formatter** dependency (see
   [Installation](installation/index.md)).
2. Go to the **Manage display** tab for the entity/view mode you want to change.
3. For a multi‑value field, set its **Format** to **"Limit the number of rendered items"**.
4. Click the field's gear/settings icon and configure:
   - **Wrapped formatter** — choose the actual formatter you want to render the kept items
     (for example *Label* for an entity reference, or a specific image style). Its own
     settings appear here too, and they're preserved untouched.
   - **Skip items** *(offset, default 0)* — how many leading values to drop. Use this to hide
     a "primary" item you're showing elsewhere, or to render a windowed slice.
   - **Display items** *(limit, default 0)* — how many values to show. **0 means "show all
     remaining"** after the skip.
5. Click **Update**, then **Save** the display. The field now renders just the slice you asked
   for. The settings summary reads something like *"Limited to 3 values, starting at 1."*

Combine an offset and a limit for a "skip 2, show 3" window, or set different limits in
different view modes to get, say, a short list in teasers and the full list on the detail page.
