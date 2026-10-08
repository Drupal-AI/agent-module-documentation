# Alter hreflang — manual setup guide

**Alter hreflang** (`alter_hreflang`) fixes a specific SEO/multilingual problem:
the **`hreflang` value** in the `<link rel="alternate">` tags Drupal puts in the
page `<head>`. Those tags tell search engines which language/region version of a
page is which. Drupal emits them using its own language codes — but sometimes that
code differs from the region-specific code search engines expect (for example
Google wants `en-US` where Drupal has `en`, or `pt-BR` where Drupal has `pt-br`).

This module lets you **remap** the code per language, so the alternate links carry
exactly the value you want, without patching core or adding a separate metatag
module. On a single-language site it emits one alternate link for the current page;
on a multilingual site it uses the language-switch links and only emits links for
the languages a page is actually translated into (and it skips 403/404 error
pages). If you don't set an override for a language, Drupal's raw language code is
used as-is.

It has no dependencies beyond core, provides no permissions or blocks, and works on
Drupal 8, 9, and 10. Its settings live in one small form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language →** *Alter
hreflang* (**`/admin/config/regional/alter-hreflang`**, route
`alter_hreflang.hreflang`), guarded by the **Administer site configuration**
permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **`/admin/config/regional/alter-hreflang`**.
3. For each enabled language you want to remap, enter the override code the search
   engines expect (for example `en-US` for English, `pt-BR` for Brazilian
   Portuguese). Languages with no override keep Drupal's raw code.
4. Save, then **clear caches** so the head-link attachments regenerate.
5. Verify by viewing a page's source and checking the
   `<link rel="alternate" hreflang="…">` tags.

> **Note:** on a multilingual page that isn't a node route, the module assumes a
> node route when building per-translation links, so some non-node pages may not
> receive per-translation alternate links.
