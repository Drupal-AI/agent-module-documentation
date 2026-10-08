<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: Format — agent index

A one-function theming shim: implements `hook_preprocess_HOOK()` for `views_view_row_rss` so
each RSS item's element `attributes` array (enclosure `url`/`length`/`type`, media:content
`bitrate`/`width`/`height`, guid `isPermaLink`, etc.) renders as real XML attributes in the row
Twig template. No config, no elements of its own, no settings page.

- **What it does, and why every attribute-bearing element from other submodules depends on it**
  → [theming/attribute-passthrough.md](theming/attribute-passthrough.md)

Key fact: if this module is disabled, any element with `attributes` (enclosure, media:content,
media:thumbnail, media:category, cloud, guid) will not render its attributes correctly — see
the parent's [api/build-rss-feed.md](../../../../2.4.x/agent/api/build-rss-feed.md) for how a
feed View is assembled overall.
