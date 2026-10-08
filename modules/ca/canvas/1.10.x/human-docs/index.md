# Drupal Canvas — manual setup guide

**Drupal Canvas** (`canvas`) is a visual, in-browser experience builder for Drupal
11. It lets content creators and site builders compose a page by dragging reusable
**components** (single-directory components / SDCs, blocks, or JavaScript "code
components") into a stored **component tree**, wiring each component's props to
Drupal data — all without writing code beyond basic JSX and CSS. It was originally
developed under the working name "Experience Builder."

Where classic Drupal is data-first, Canvas inverts the model: you lay out the page
first and then bind data to it through shape-matched "prop sources," while still
leveraging Drupal's strengths — structured content, fine-grained access control,
and reuse across coupled and headless channels. The editor itself is a React
single-page app backed by an internal HTTP API, with an auto-save draft/publish
workflow.

A few things to set expectations. Canvas is a large, **actively developed** module
that requires **Drupal 11.3+ and PHP 8.3**, and it pulls in a broad set of core
modules (CKEditor 5, Media Library, Image, Link, Path, and more). It does **not**
work on enable alone in a meaningful way: you need to supply a **component system**
(build your own SDCs / code components, or start from an existing set such as the
Mercury theme). Importantly, Canvas 1.x ships **no stable public PHP or HTTP API** —
all of its classes and endpoints are marked internal and may change, so don't build
integrations against them yet. It also provides **no Drush commands**.

Canvas ships a number of **submodules**, most of them hidden and/or
experimental/developer-only (AI assistance, OAuth for the external API, a decoupled
headless frontend, Vite hot-module-reloading, and several `canvas_dev_*` feature
flags). Only enable those you specifically need, and keep the dev ones off in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP/
   core requirements, enable the module, and choose submodules.
2. [Configuration](configuration/index.md) — where Canvas lives in the admin menu,
   the config entities it manages, and what you need to supply to make it useful.

## Where it lives in the admin menu

Canvas's `configure` link points to the **Components** collection at **Appearance →
Components** (`/admin/appearance/component`, route `entity.component.collection`),
where you manage and enable components. You'll also find **Pages** under
**Content → Pages** (`/admin/content/pages`) for standalone Canvas pages, and the
Canvas editor itself boots at `/canvas` (and `/canvas/editor/{entity_type}/{entity}`
to edit a specific entity's layout).

## How to use it

At a high level: install a component system, enable/curate the components you want
under **Appearance → Components**, then build pages either as standalone **Canvas
Pages** or by editing an entity's layout in the Canvas editor. Inside the editor
you drag components onto the canvas, arrange them into a tree, and bind their props
to static values or entity fields, with changes auto-saved as a draft until you
publish.
