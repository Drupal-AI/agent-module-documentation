# Big Pipe Paragraphs — manual setup guide

**Big Pipe Paragraphs** (`big_pipe_paragraphs`) uses Drupal's BigPipe to load
paragraphs progressively. On paragraph-heavy pages, the page's initial HTML shell is
sent quickly and the paragraph content streams in afterwards — so the page appears to
load faster even if some content arrives a moment later.

It changes only *how* paragraphs are delivered, not their content or their access.
Each paragraph still renders with its normal access checks and cacheability; the
module just defers the heavier parts so the shell can appear first. It is best suited
to pages where below-the-fold paragraphs can afford to load slightly later while the
top of the page shows immediately.

The module builds on core BigPipe and Dynamic Page Cache, the contributed Paragraphs
module, and the Preprocess module, all of which must be present for it to work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.

## Where it lives in the admin menu

There is no settings page. Once the module and its dependencies are enabled, the
progressive-loading behavior applies to paragraph rendering automatically.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. On paragraph-heavy pages, the shell now renders first and paragraphs stream in
   afterwards, improving perceived load time.
3. There is nothing to configure — paragraph access and cacheability are unchanged;
   only the delivery timing differs.
