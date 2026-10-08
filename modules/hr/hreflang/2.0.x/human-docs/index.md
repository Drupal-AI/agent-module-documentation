# Hreflang — manual setup guide

**Hreflang** (`hreflang`) automatically adds `hreflang` link tags to your pages so
search engines serve the correct language or regional version of a URL in their
results. Search engines use these `rel="alternate" hreflang="…"` tags to
understand that several URLs are translations of one another; getting them right
is an important part of multilingual SEO.

The module figures the tags out for you based on your site's enabled languages and
the language-switch links Drupal core already provides — you don't enter anything
per page. A key advantage over core: Drupal's **Content Translation** module only
adds hreflang tags on content-entity pages, whereas Hreflang adds them to **all**
pages (and can optionally step back and defer to Content Translation on entity
pages if you prefer).

Hreflang works as soon as you enable it on a multilingual site — on a single-
language site it simply does nothing. It has **no dependencies** and **no
submodules**, and offers a small settings form for a few fine-tuning options
(mainly around the `x-default` tag). Version 2.0 targets Drupal 11.1 and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the few optional settings, mostly
   around the `x-default` tag and deferring to Content Translation.

## Where it lives in the admin menu

Hreflang's settings form is at **Configuration → Search and metadata → Hreflang
tags** (`/admin/config/search/hreflang`, route `hreflang.admin_settings`), gated
by the **Administer site configuration** permission.

## How to use it

There's nothing to do per page. Once enabled on a multilingual site, view the HTML
source of any page and you should see one `<link rel="alternate" hreflang="…">`
tag per enabled language (plus an `x-default` tag by default). The module skips
403 and 404 pages, and preserves query strings on the tags. A few days after
Google recrawls your site you should see hreflang errors clear in Google Search
Console.
