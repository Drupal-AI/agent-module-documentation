# Better Search Block — manual setup guide

**Better Search Block** (`better_search`) makes Drupal's plain core search block
look and feel nicer. Out of the box, the core search block is a bare text field
and a "Search" button. This module dresses it up with a placeholder message, a
search icon, a tidier layout (the submit button is hidden by default), and one of
four subtle CSS hover animations — a background fade, a field that widens on hover,
an icon that grows, or an icon that slides in.

It's a lightweight, presentation-only module. There's no new block to place — it
restyles the search block (and optionally the search-results page's search form)
that Drupal already provides, using a form alteration plus a little CSS. There are
no templates to wrangle: you pick your options on a small settings form, and the
right stylesheet is attached automatically.

Everything is controlled from one settings page: the placeholder text, the input
size, which animation to use, and whether to also restyle the search-results page.
An "Advanced" section lets you point the styling at a different (custom or contrib)
search form if you're not using the standard one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   including the four animation styles.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Better Search**
(`/admin/config/search/better-search`), gated by the module's own **Administer
Better Search settings** permission. To actually see the styled block on your
site, make sure the core **Search** block is placed in a region via **Structure →
Block layout** (`/admin/structure/block`).
