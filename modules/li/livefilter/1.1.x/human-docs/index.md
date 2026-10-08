# LiveFilter — manual setup guide

**LiveFilter** (`livefilter`) brings the "type to narrow the list instantly"
experience — the one you get on Drupal's own Extend page — to any list or table on
your site, without writing a line of JavaScript. You place a LiveFilter **block**
next to a list of content — a glossary, a staff directory, a product catalogue, a
FAQ section — and visitors filter it in real time as they type. There's no page
reload and no server round‑trip; the filtering happens in the browser.

It's deliberately small and self‑contained: pure JavaScript with no external
libraries, and a plain text input you can style however your theme needs. It works
on Drupal 9, 10, and 11, and the stable release is covered by the Drupal security
advisory policy.

One important thing to understand about *any* client‑side filter, LiveFilter
included: because it filters content that has **already been rendered and sent to
the browser**, it's a presentation convenience, not a security boundary. Every
filterable row is already in the page, so LiveFilter must never be used to "hide"
sensitive rows from people who shouldn't see them — only render rows the user is
allowed to see in the first place. LiveFilter plays no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form**. You configure each LiveFilter instance
right where you place its block, described in "How to use it" below.

## Where it lives in the admin menu

LiveFilter adds no admin settings page. You work with it from **Structure → Block
layout** (`/admin/structure/block`), where you place and configure a LiveFilter
block in whichever region sits next to the list you want to filter.

## How to use it

The block configuration uses CSS/XPath selectors to tell LiveFilter *what* to
search and *what* to filter. Here's the common example — filtering the standard
Drupal front‑page view:

1. Go to **Structure → Block layout** and place a **LiveFilter** block in the
   region of your choice (usually just above the list you want to filter).
2. In the block configuration:
   - Set the **Elements selector** field to the wrapper for each list row — for
     the front page view, `.views-row`.
   - Set the **Text XPath** field to the element whose text should be searched
     within each row — for the front page view, `.//article`.
3. Save the block. Now typing in the LiveFilter input narrows the list instantly
   as the visitor types.

Adjust the selectors to match the markup of whatever list you're filtering — a
directory, a catalogue, a glossary, and so on.
