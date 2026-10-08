# Custom Search — manual setup guide

**Custom Search** (`custom_search`) enhances Drupal's core Search. It gives you a
configurable **"Custom Search" block** — a search box you can place in any region,
optionally with content‑type and taxonomy selectors so visitors can narrow a
search before they submit it — and it lets you restyle and restrict the core search
form and results pages (labels, placeholders, default text, advanced criteria,
allowed content types, and more). It's the go‑to module when the plain core search
box isn't flexible enough but you don't want to build a search UI from scratch.

The main piece is the **Custom Search block**. Beyond a plain text input, its
settings let you customise the search box (label, placeholder, hint, size, max
length), the submit button (text or an image/icon), and a set of selectors:
content‑type dropdowns or checkboxes, taxonomy‑term selectors (with a configurable
depth for child terms), and extra query criteria such as "any word / all words /
exact phrase / without the words". You can place several blocks with different
scopes — for example a news‑only search and a docs‑only search — and even route a
block to a **Search API** page instead of core search.

Custom Search also alters the **core search settings and results pages**. When
installed, it seeds per‑search‑page configuration for each core search page, letting
you control whether the search form and a collapsible advanced form appear, which
content types / criteria / languages the advanced form offers, what information is
shown per result, and an optional results filter. There's no single settings page:
you configure the block through **Block layout** and the results behaviour through
each **Search page's** settings form. The module also ships templates and a small
CSS/JS library for an optional popup search box.

It depends on core's **Search** and **Block** modules and adds no permissions of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place and configure the Custom Search
   block, and customise the core search results/advanced forms.

## Where it lives in the admin menu

There is no dedicated Custom Search settings page. You configure it in two existing
places:

- **Structure → Block layout** (`/admin/structure/block`) — place and configure the
  **Custom Search** block.
- **Configuration → Search and metadata → Search pages**
  (`/admin/config/search/pages`) — edit a search page to reach the extra options
  Custom Search injects into its settings form (advanced form, allowed types,
  displayed info, and so on).

## How to use it

Place a **Custom Search** block in a region, then configure its search box,
selectors, and criteria to scope searches the way you want. To refine what happens
on the results page — the advanced/refine form, allowed content types, per‑result
info — edit the relevant core **Search page**. Full details, field by field, are in
[Configuration](configuration/index.md).
