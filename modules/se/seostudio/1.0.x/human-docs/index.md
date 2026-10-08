# SEO Studio — manual setup guide

**SEO Studio** (`seostudio`) gives editors a real-time preview of how a page's
meta tags will look across the major search engines and social platforms — the
search-result snippet, the Facebook / Open Graph card, the Twitter/X card, and so
on — so you can tune your titles, descriptions, and images before you publish.

It adds a new **SEO** tab to your nodes, sitting right next to the *Edit* and
*Delete* tabs, so previewing is one click away and nothing about your existing
setup changes. The preview shows how the content will appear on the various
platforms, and it also includes a **Raw metatags** fieldset that displays the
actual meta tag code the node produces. SEO Studio is built as a layer on top of
the widely used **Metatag** module (plus its Open Graph and Twitter Cards
submodules), so it enhances your SEO management without altering your technical
structure. It is backwards-compatible with Drupal 8 and 9, works well on
multilingual sites, and supports both the Claro and Gin admin themes.

The module needs a little configuration before you use it: the preview feature
relies on an external preview service, which you connect with an **API key** on
the settings page. Because that key is a credential for a third-party service,
store it as a secret. SEO Studio is an editorial / SEO aid that works alongside
Metatag — it previews and helps you refine meta tags and plays no access-control
role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Metatag and its submodules.
2. [Configuration](configuration/index.md) — enter the API key that powers the
   preview service.

## Where it lives in the admin menu

The settings form is reached at
**`/admin/config/search/flaregpt/metatags`** (route `seostudio.settings`).

## How to use it

Once configured, open any node where you want to check the metadata and click the
**SEO** tab (or visit `/node/{node}/seo`). You will see how the page renders as a
search result and as Facebook and Twitter/X cards, plus the raw meta tag code for
that node. Adjust your titles, descriptions, and images (through Metatag) until
the previews look right, then publish.
