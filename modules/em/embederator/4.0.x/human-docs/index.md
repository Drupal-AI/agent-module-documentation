# Embederator — manual setup guide

**Embederator** (`embederator`) lets you manage reusable third‑party embeds —
CRM and marketing forms, iframes, widgets, tracking pixels, videos — as proper
Drupal entities instead of pasting raw HTML into every page. You author the embed
*once* as a reusable template, and then create as many lightweight instances of it
as you need, each filling in just the bits that change.

It works with two moving parts. An **embed type** (an *embederator_type*, a
configuration entity that acts as the bundle) holds the shared markup skeleton —
the HTML snippet or, alternatively, a URL to fetch server‑side — with tokens where
per‑instance values go. Each **embed** (an *embederator*, a fieldable content
entity) is one instance of a type: it supplies the values for those tokens, such
as a form ID or a campaign code. At render time the module replaces the tokens
with the instance's field values and outputs the result. A field formatter then
controls *how* the embed loads — directly, lazily after page load, or inside a
self‑resizing iframe.

The typical division of labour is that a trusted site builder authors the raw
markup on the embed type (this is powerful — the markup is rendered unfiltered,
so it can contain scripts), while content editors only ever fill in a token value
or two on the individual embeds. That keeps the risky "paste arbitrary HTML" step
behind a single permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create embed types, add embeds, use
   tokens, and choose how each embed loads.

## Where it lives in the admin menu

Embederator has **no single settings page** — you work with it in two places:

- **Embed types** (the reusable templates) live under **Structure → Embederator
  types** (`/admin/structure/embederator_type`), gated by the *Administer
  embederator types* permission.
- **Embeds** (the individual instances) live under **Content → Embederators**
  (`/admin/content/embederator`), where you add, edit and delete them like any
  other content, gated by the *view / add / edit / delete embederator entity*
  permissions.
