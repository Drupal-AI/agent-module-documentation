# Tocbot — manual setup guide

**Tocbot** (`tocbot`) builds an automatic, clickable table of contents from the
headings on a page. It wraps the popular [Tocbot](https://tscanlin.github.io/tocbot/)
JavaScript library and exposes it as a placeable Drupal block called **"Tocbot
TOC"**. Drop that block into a region (a sidebar is typical), and on any page with
enough headings it renders a nested list of links — one per heading — that jump to
each section, optionally highlighting the current section as you scroll
(scrollspy).

It is aimed at long-form content: documentation, manuals, knowledge-base articles,
FAQs, and lengthy blog posts that would benefit from in-page navigation. Tocbot
scans a configurable content container (default `#content`) for headings (default
`h2`–`h6`) and only builds the list when there are at least a minimum number of
them (default 3), so short pages stay clean. It can even generate the heading `id`
anchors for you, so the links work without any other module.

To render a table of contents you must place the block — the module does nothing on
its own until it is placed. Everything else is optional tuning: a settings form at
**Configuration → Content authoring → Tocbot** exposes roughly 30 Tocbot options
(which headings to include, the activation threshold, smooth scrolling, sticky
positioning, CSS class names, and so on). The Tocbot library loads from a CDN by
default, but if you drop the library files into `/libraries/tocbot/dist/` the module
serves them locally instead — handy for offline or CSP-restricted sites. Tocbot has
no dependencies beyond Drupal core, defines no permissions of its own, and ships no
submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) host the Tocbot library locally.
2. [Configuration](configuration/index.md) — placing the block and the settings
   form, option by option.

## Where it lives in the admin menu

- The block is placed from **Structure → Block layout**
  (`/admin/structure/block`) — look for **"Tocbot TOC"**.
- The settings form sits at **Configuration → Content authoring → Tocbot**
  (`/admin/config/content/tocbot`), gated by the core *Administer site
  configuration* permission.

## How to use it

The short version: enable the module, place the **Tocbot TOC** block in a sidebar,
and make sure your content pages have at least three matching headings inside the
container named by `content_selector`. See [Configuration](configuration/index.md)
for the full walkthrough and the meaning of each setting.
