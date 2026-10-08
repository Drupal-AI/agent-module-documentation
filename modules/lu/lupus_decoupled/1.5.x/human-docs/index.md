# Lupus Decoupled — manual setup guide

**Lupus Decoupled** (`lupus_decoupled`) is a ready‑to‑go, opinionated setup for
running Drupal as a **decoupled backend for a Nuxt.js front end**. Its central
bet is different from the usual "JSON:API plus a component library" approach:
rather than exposing raw entity data and rebuilding all of Drupal's rendering in
the front end, Drupal keeps rendering — field formatters, text formats, view
modes, menus, access‑aware markup — but renders into `<drupal-…>` **custom
elements**, and Nuxt turns those into components. The content model stays
Drupal's problem; presentation stays the front end's.

The pay‑off is that you keep the Drupal capabilities decoupled builds usually
lose: cookie‑based authentication, the caching system (page cache and tag‑based
invalidation), editorial control of pages, paths, and layouts (via Layout
Builder, Paragraphs, CKEditor embeds), previews, nice URLs, and metatag
generation. The API is clearly defined, so the backend and front end can evolve
and be tested separately, and you can deploy the front end statically or
server‑rendered thanks to Nuxt.js.

Lupus Decoupled is a **suite of fifteen submodules**. Three are required by the
top‑level module — the custom‑elements API itself, the CORS configuration a
cross‑origin setup cannot avoid, and the menu bridge — and the rest are
**bridges** for the things that are genuinely hard in a decoupled build precisely
because they are not plain data: forms, webforms, contact forms, Views, blocks,
Layout Builder, structured metadata, and so on. You enable only the bridges you
need. Full documentation and demos live at
[lupus-decoupled.org](https://lupus-decoupled.org/).

> **Integration note worth knowing up front.** The `lupus_decoupled_ce_api`
> submodule **replaces Drupal's `file_url_generator` service** with its own
> implementation. This is legitimate — it implements the same interface — but any
> other module that type‑hints the *concrete* `Drupal\Core\File\FileUrlGenerator`
> class (rather than the interface) will fatal once this suite is installed. If a
> feature breaks right after you adopt Lupus Decoupled, a concrete type hint on a
> decorated service is the first thing to check.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer,
   enable the base module and its required submodules, and add the bridges you
   need.

Configuration is spread across the individual submodules (for example CORS
settings and the Custom Elements UI) and across the companion Nuxt front end
rather than a single settings form, so it is not documented as one page here —
see [lupus-decoupled.org](https://lupus-decoupled.org/) for the end‑to‑end setup.

## Where it lives in the admin menu

Lupus Decoupled does not add a single top‑level settings page. Once installed, it
exposes the custom‑elements API (reachable via a `/ce-api/` prefix), and its
submodules add their own configuration where relevant — for example CORS
configuration and the Custom Elements UI. The typical way to stand up a full
stack quickly is via the project's
[base recipes](https://www.drupal.org/project/lupus_decoupled) and project
template, which include a Drupal + Nuxt front end with DDEV support.

## How to use it

1. Install the suite and enable the base module plus its required submodules (see
   [Installation](installation/index.md)).
2. Enable the additional bridge submodules for the features your front end needs
   (forms, webforms, Views, blocks, Layout Builder, and so on).
3. Configure CORS for your front‑end origin via the `lupus_decoupled_cors`
   submodule.
4. Point a Nuxt.js front end (the project provides a ready starter and several
   example setups) at the custom‑elements API and render the `<drupal-…>`
   elements as components.
