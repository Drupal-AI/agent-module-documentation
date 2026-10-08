# Universal Media formatter — manual setup guide

**Universal Media formatter** (`umf`) adds a single field formatter that renders a
media‑reference field as a responsive image, straight from the referencing
entity. Normally, to display referenced media at a particular image style you'd
have to create a dedicated media view mode for each size. This module removes that
chore: you pick a **responsive image style** right in *Manage display*, and it
renders each referenced media item's thumbnail through that style — no extra view
modes required.

It's aimed at the common case of an entity‑reference field pointing at Media
(images especially), and it's smart about edge cases: JPEG/PNG thumbnails render
through core's responsive image formatter (keeping `srcset`/`sizes` output), SVGs
render as‑is through the plain image formatter, and video media falls back to
rendering the media entity in a view mode you choose (so you get the video, not a
generic still). It reuses the referenced media's alt text automatically, respects
each media item's view access so restricted media isn't leaked, and sets proper
cache tags so everything invalidates correctly when an image style or media item
changes.

There is no global settings page, no permissions, and no schema — every option is
set per formatter instance on a display. The module requires the core **Media**
and **Responsive Image** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus its Media/Responsive Image dependencies).
2. [Configuration](configuration/index.md) — enable the formatter on a field and
   set its options.

## Where it lives in the admin menu

The formatter has no page of its own. You enable and configure it per field under
**Structure → (content type or other entity) → Manage display**
(`/admin/structure/types/manage/<type>/display`), on any entity‑reference field
whose target is Media.

## How to use it

Go to a bundle's **Manage display**, find an entity‑reference‑to‑Media field, and
set its **Format** to **Universal Media formatter**. Open the settings gear to
choose a responsive image style and the other options. See
[Configuration](configuration/index.md) for a field‑by‑field walkthrough.
