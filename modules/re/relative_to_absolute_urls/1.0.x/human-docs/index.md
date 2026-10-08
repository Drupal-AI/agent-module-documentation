# Absolute URLs — manual setup guide

**Absolute URLs** (`relative_to_absolute_urls`) solves a narrow but annoying
problem: when Drupal serializes content to JSON, links written as relative paths
(like `/about` or `/sites/default/files/photo.jpg`) stay relative — which is fine
inside your site but breaks when the exported data is consumed somewhere else,
where there is no notion of "your site's root." This module rewrites those
relative URLs into fully qualified **absolute** URLs (like
`https://example.com/about`) as the data is encoded, so the links resolve
correctly wherever the export ends up.

Technically, it registers a normalizer for Symfony's serialization layer that
targets the `ViewsRenderPipelineMarkup` data type and replaces its relative
output with absolute URLs when encoding to JSON. In plain terms: it's aimed at
**Views-based data exports / REST output** that contain rendered markup with
links, making sure those links carry a full domain.

There is nothing to configure and nothing to click. Once the module is enabled it
works automatically during serialization. It depends only on Drupal core and runs
on Drupal 10 and 11. Note that it is **minimally maintained**, so treat it as a
small, focused utility rather than a broad framework.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module has no settings and works
automatically once enabled.

## How to use it

There is no admin screen. After you install and enable the module, any JSON
serialization that runs the affected rendered-markup values through Symfony's
normalizer will emit absolute URLs instead of relative ones. If you export Views
data or content as JSON and need the links to carry a full domain, simply enable
the module — the transformation happens on its own during encoding.
