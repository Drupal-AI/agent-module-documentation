# Lite YouTube — manual setup guide

**Lite YouTube** (`lite_youtube`) is a lightweight, privacy‑friendlier field
formatter for YouTube video fields. Instead of embedding YouTube's full OEmbed
iframe the moment a page loads, it renders a **facade** — just a thumbnail and a
play button. Nothing from YouTube's heavy player loads until the visitor actually
clicks play. That trims initial page‑load time and defers the third‑party
connection to YouTube until the user chooses to watch.

A privacy note worth stating plainly: this is *privacy‑friendlier*, not
zero‑contact. The video still streams from **YouTube** once the visitor clicks, so
the usual third‑party embed considerations apply from that point on — the win is
that nothing loads from YouTube until the click happens.

The module provides its formatter for YouTube video fields and depends on the
contributed **YouTube** module (`youtube`), which supplies the underlying field
type. It has no content or access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the YouTube
   dependency) with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. Its
options live in the formatter's third‑party settings on *Manage display*,
described in "How to use it" below.

## Where it lives in the admin menu

Lite YouTube adds no admin page. You use it entirely from **Structure → Content
types → *(bundle)* → Manage display**, where it appears as a display format for
YouTube video fields.

## How to use it

1. Make sure the content type has a **YouTube video field** (provided by the
   YouTube module).
2. Go to that content type's **Manage display** screen — for example **Structure →
   Content types → Article → Manage display** (`/admin/structure/types`).
3. In the **Format** column for the YouTube field, select **Lite Youtube**.
4. Click the gear/cog icon to open the formatter's **third‑party settings**. Here
   you can tune things like the play‑button title, the poster (thumbnail) quality,
   and how the poster loads.
5. Click **Update**, then **Save**. The field now renders a click‑to‑load facade,
   and the full YouTube player only loads when a visitor clicks play.
