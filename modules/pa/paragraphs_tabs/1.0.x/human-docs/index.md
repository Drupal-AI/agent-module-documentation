# Paragraphs Tabs — manual setup guide

**Paragraphs Tabs** (`paragraphs_tabs`) lets you present paragraph content as
**horizontal or vertical tabs**. Instead of a long single column of stacked
content, editors can organise sections into switchable tabs, so a visitor clicks
between them rather than scrolling — good for things like feature comparisons,
FAQs broken into topics, or any content that reads better in discrete panels.

The tab content is ordinary authored paragraphs, so it respects the normal access
of whatever paragraphs you place inside. This is a presentation feature: it
affects how paragraph content is displayed and has no access‑control role of its
own. It depends on the Paragraphs module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Paragraphs.

There is **no global settings page** for this module — it has no configuration
form of its own. You build tabbed content using the paragraph types it provides,
described in "How to use it" below.

## How to use it

Once enabled, the module makes tabbed‑content paragraphs available for use in your
Paragraphs fields:

1. Add (or reuse) a Paragraphs field on the content type where you want tabbed
   sections.
2. When editing that content, add the module's tabs paragraph and choose whether
   it should present its sections as **horizontal** or **vertical** tabs.
3. Add the content for each tab as paragraphs within it.
4. Save and view the content — the sections render as a set of switchable tabs.
