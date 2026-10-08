# Bing Indexing API — manual setup guide

**Bing Indexing API** (`bing_indexing_api`) submits your content URLs to Microsoft
Bing's Webmaster URL Submission API so that pages get (re)crawled promptly. Instead
of waiting for Bing to discover changes on its own, the module pushes a URL to Bing
whenever a node is created, updated, unpublished or deleted — and it can also submit
a batch of URLs on demand.

It is an SEO helper aimed at keeping Bing's index fresh: new landing pages get
indexed sooner, updated articles get re-crawled, and removed pages can be flagged.
You choose which events trigger a submission (create/update, unpublish, delete, and
whether to restrict to published nodes only), so you can make it as automatic or as
manual as you like.

The connection uses a Bing Webmaster API key. Submissions are **outbound only** —
the module POSTs a small JSON body to Bing over HTTPS and logs the result; there are
no inbound or anonymous endpoints. All three admin screens are gated by the
`administer bing index api` permission. See [Configuration](configuration/index.md)
for the credentials and trigger settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the API key and base domain,
   choose the trigger behavior, and use the bulk-submit form.

## Where it lives in the admin menu

The module adds three screens under **Configuration → Web services**:

- Credentials — `/admin/config/services/bing-index-api`
- Settings (triggers) — `/admin/config/services/bing-index-api/settings`
- Bulk update — `/admin/config/services/bing-index-api/bulk-update`

All three require the `administer bing index api` permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your Bing Webmaster API key and base domain, and choose which content
   events submit URLs (see [Configuration](configuration/index.md)).
3. Let submissions happen automatically as content changes, use the bulk form to
   push a curated list of URLs (for example after a launch), or call the client
   service from custom code to reindex a specific URL.
