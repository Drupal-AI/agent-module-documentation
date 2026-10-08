# Fallback Media — manual setup guide

**Fallback Media** (`fallback_media`) displays a configured default media item
whenever a media field is empty. A teaser or listing that has no image of its own
would normally show a gap; with Fallback Media it shows the fallback you chose
instead, keeping layouts consistent and tidy.

It works as a **field formatter** for media fields. You set it up on a field's
*Manage display*, pick the media item to fall back to, and from then on any entity
whose field is empty renders that fallback in place of nothing. It is a
display‑only feature — it does not change stored content or access — and depends only
on core's Media module.

There is no separate settings page: the fallback is chosen per field display, so the
"configuration" for this module lives on the *Manage display* screen described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Media.

There is **no module‑wide settings page** — the fallback is configured on each media
field's display, described in "How to use it" below.

## Where it lives in the admin menu

Fallback Media adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display**, on the media field
you want a fallback for.

## How to use it

1. Have a media field on your entity (for example an *Image* or *Media* reference on a
   content type) and at least one media item to use as the default.
2. Go to the bundle's **Manage display** and find that media field.
3. Set the field's **format** to the Fallback Media formatter.
4. In the formatter settings, choose the **fallback media item** to show when the
   field is empty, along with any display options the formatter offers.
5. Save. Entities that have their own media render it as usual; entities with an empty
   field now render the fallback instead of a gap.

Use it anywhere a missing image would break a layout — card grids, teasers, hero
regions — so every item always shows something.
