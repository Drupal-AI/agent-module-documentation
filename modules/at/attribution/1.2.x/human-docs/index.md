# Attribution — manual setup guide

**Attribution** (`attribution`) lets you attach author, source, licensing, and
even AI-provenance information to your content — any fieldable entity (nodes,
media, and so on) — and to the whole site via a block. It's built around a
configurable list of **licenses** drawn from the standard SPDX license list, so
you can credit content properly and declare how it may be reused.

The problem it solves comes up whenever content isn't purely your own: you reuse a
photo under Creative Commons, you publish work that funders require you to license
a certain way, or — increasingly — you need to disclose whether content was
**human-created, AI-generated, or AI-modified**. Attribution captures all of that
in one reusable field type: the source name and link, the author name and link, a
chosen license, plus AI-provenance fields (creation type, the AI tool used, the
prompt, and who edited the prompt) that appear only when the content is marked as
AI-generated or AI-modified.

On the display side it ships several **formatters**, from plain text and one-line
text to HTML and preformatted Creative Commons variants with license badges and AI
icons. Two **blocks** — Attribution and Copyright — render a site-wide license or
copyright notice (with Token support, so `[current-date:html_year]` and
`[site:name]` fill themselves in). Licenses are stored as configuration entities:
the module installs ten common defaults (CC0, the CC-BY family, GPL-2.0-or-later,
All Rights Reserved, and an "Uncertain copyright status" entry), and an admin can
import any of the 400+ licenses from the bundled SPDX list or add custom ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — manage the license list, add an
   attribution field, and place the blocks.

## Where it lives in the admin menu

The license list is managed at **Structure → Attribution licenses**
(`/admin/structure/attribution-license`), gated by the **administer
attribution_license** permission. Attribution fields are added to content types
and media at **Structure → *(type)* → Manage fields**, and the Attribution and
Copyright blocks are placed at **Structure → Block layout**.

## How to use it

There are two independent ways to use the module, and you can use either or both:

- **Per-content attribution** — add an **Attribution** field to a content type or
  media type, choose one of the widgets (from license-only up to "Source, Author &
  License"), and pick a formatter on the display. Editors then credit each item and
  select its license; on rendered pages the attribution shows with license badges
  and, for AI content, the provenance details.
- **Site-wide notice** — place the **Attribution** or **Copyright** block (for
  example in the footer) to show a single license or copyright line for the whole
  site, with a disclaimer you can write using Token placeholders.
