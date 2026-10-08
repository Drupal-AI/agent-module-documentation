# Search API Site Studio processor — manual setup guide

**Search API Site Studio processor** (`search_api_sitestudio_processor`) makes the
text inside **Acquia Site Studio** (formerly Cohesion) components searchable. If
you build pages with Site Studio's drag-and-drop layout canvas, the words you type
into those components are stored as a JSON layout structure, not as ordinary field
text — so Drupal's standard Search API field indexing simply misses them. This
module bridges that gap.

It provides a Search API **processor** that acts as a translator for the layout
canvas: for each item being indexed it loads the Site Studio layout, decodes the
component tree (following nested child components), pulls out the human-readable
text from each component — stripping tags and entities from rich text — and adds
that combined text to the search index. The result is that landing-page copy built
entirely in Site Studio finally shows up in your site search.

By default it indexes the text of every component it finds, which is the simplest
way to get comprehensive coverage. If you would rather keep the index lean or
exclude purely decorative components, you can narrow it down — to whole component
categories, or to individual named components — through the field's configuration
form. All of the canvas parsing is wrapped in error handling: if a single
malformed layout can't be decoded, the module logs the problem and re-queues the
item for reindexing rather than letting indexing fail.

It depends on the **Search API** module, and at runtime on a working Acquia Site
Studio install (`cohesion` / `cohesion_elements`). It exposes no routes,
permissions or external calls — everything happens server-side during indexing.
This release (1.0.x) is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the field to your index and
   choose which components feed it.

## How it surfaces

There is no site-wide settings page. The feature appears as a new field you can
add to a Search API index — labelled **Sitestudio Components** — and adding that
field automatically activates the processor. All of the tuning is done on that
field. See [Configuration](configuration/index.md).
