# Inline Style Aggregation — manual setup guide

**Inline Style Aggregation** (`inline_style_aggregation`) is a performance module
that tidies up the `<style>` tags scattered through a rendered page. On many
Drupal sites, modules and editor content sprinkle small inline `<style>` blocks
throughout the `<body>`. Each one adds a DOM node and a little more work for the
browser to build its CSSOM. This module gathers all of those inline `<style>`
blocks, merges their CSS together, and emits a **single** `<style>` element in the
page's `<head>` — a smaller DOM and faster style processing, with the same visual
result.

Under the hood it works entirely on the outgoing HTML. It runs very late in
Drupal's response cycle, parses the page, removes the inline `<style>` tags,
concatenates their CSS, and appends one consolidated
`<style data-generated-by="inline_style_aggregation">` to the `<head>`. It is
careful about the details: it preserves the `media` attribute of a style block by
wrapping that CSS in an `@media` rule, it carries over any Content Security Policy
`nonce` found on the originals, and it deliberately skips BigPipe streaming
responses so it never interferes with progressive rendering. An optional minify
step strips comments and collapses whitespace in the merged block.

It complements, rather than replaces, core's CSS aggregation: core handles your
external stylesheets, while this module handles the inline styles core leaves
alone. You can roll it out gradually — starting with just the body styles, then
optionally folding in `<head>` styles too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its two
   Symfony library dependencies) and enable it.
2. [Configuration](configuration/index.md) — the settings form: the master switch,
   minification, media preservation, and how `<head>` styles are handled.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → Development →
Performance → Inline Style Aggregation**
(`/admin/config/development/performance/inline-style-aggregation`). Access to it is
controlled by a dedicated **Administer inline style aggregation** permission, which
you should grant only to trusted roles.
