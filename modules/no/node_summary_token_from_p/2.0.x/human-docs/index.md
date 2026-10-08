# Node Summary Token From P Tags — manual setup guide

**Node Summary Token From P Tags** (`node_summary_token_from_p`) makes Drupal's
`[node:summary]` token work for nodes that have **no body field**. Out of the box,
that token is derived from the body field's summary, so any node you build without a
classic body — from Paragraphs, Layout Builder, or a set of custom fields — leaves
`[node:summary]` empty. Anything that relies on it (a Metatag meta‑description
pattern, an RSS feed summary, teaser text) then comes up blank.

This module fills that gap. When something asks for `[node:summary]` on a bodyless
node, it renders the node's HTML, pulls the first three sentences it finds inside the
`<p>` tags of that output, and returns them as the summary. The result is cached per
node so the page isn't re‑rendered every time the token is requested. It depends only
on core's **Node** module.

There is nothing to configure — the module is purely a token replacement that plugs
into Drupal's token pipeline (so it respects the usual sanitization and cache‑metadata
handling). Enable it, and the token starts resolving wherever it is already used. A
common pairing is a Metatag description pattern set to `[node:summary]`: on bodyless
content it now produces a sensible auto‑summary instead of an empty string.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, `[node:summary]` simply works on nodes without a body field.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Use `[node:summary]` wherever you need a summary — most often in a **Metatag**
   description pattern under **Configuration → Search and metadata → Metatag**, or in
   any other token‑driven field.
3. For a node that has a body field, the token behaves exactly as core does. For a
   node **without** a body field, the module derives the summary from the first three
   sentences in the rendered `<p>` tags.

Because the derived summary is cached per node, editing the content and clearing the
node's cache (or a general cache rebuild) refreshes it.
