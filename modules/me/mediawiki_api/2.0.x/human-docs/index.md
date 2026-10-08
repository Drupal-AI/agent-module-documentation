# MediaWiki API — manual setup guide

**MediaWiki API** (`mediawiki_api`) lets Drupal display content written in
**MediaWiki syntax** by using an existing MediaWiki instance's own API to render it.
It provides an **input filter** that takes text marked up in MediaWiki (wiki) syntax
and sends it to the MediaWiki API's *parse* feature, which returns HTML that Drupal
then displays. In other words, you author with the full MediaWiki formatting
language — including any extensions installed on that wiki — and Drupal shows the
rendered result.

The design deliberately avoids any tight coupling to the MediaWiki codebase: all
re‑use of MediaWiki's rendering happens over its API, so the module should keep
working across future MediaWiki releases and give you the latest supported syntax.
The wiki's API URL is configured by an administrator (on the text format's filter
settings), not supplied by end users, so the module only ever talks to the trusted
wiki you point it at.

MediaWiki API has **no module dependencies** beyond Drupal core and works on Drupal
8 through 11. There is no standalone module settings page — you enable and point the
filter from within a text format's configuration, described under "How to use it"
below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated module configuration page** — the filter is enabled and
pointed at your wiki from within a text format's settings, described in "How to use
it" below.

## Where it lives in the admin menu

The module adds no settings page of its own. You configure its filter under
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on whichever text format(s) should render
MediaWiki syntax.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format you want to author wiki content in (or add a new one dedicated to
   it).
2. Under **Enabled filters**, enable the **MediaWiki** filter.
3. In that filter's settings, set the **MediaWiki API URL** to the `api.php`
   endpoint of the wiki whose renderer you want to use (for example
   `https://your-wiki.example.com/w/api.php`).
4. Mind the **filter order** so the MediaWiki filter runs appropriately relative to
   other filters, then save the format.
5. Content entered in a field using that format is now sent through the wiki's parse
   API and displayed as rendered HTML.

> **Outbound requests.** Rendering makes a server‑side HTTP request from Drupal to
> the configured wiki API for each parse. Ensure your Drupal server has outbound
> network access to that wiki, prefer an **HTTPS** endpoint, and remember that
> render performance depends on that remote call — caching the rendered output helps.
> Because the API URL is set by an administrator rather than by content authors,
> there is no user‑controlled request target.
