# Document Loader Plugin - Webpage — manual setup guide

**Document Loader Plugin - Webpage** (`document_loader_webpage`) is a **loader plugin
for [Document Loader](../../../document_loader/2.0.x/human-docs/index.md)** that fetches
a **web page** and converts it for ingestion. Given a URL, it makes a server-side
`GET` request (via Guzzle), cleans the returned HTML, and returns the content in a
normalized form so a remote page can flow into your content or AI pipelines the same
way a file would.

Once enabled it becomes one of the loaders Document Loader can dispatch to. It is a
web-services / developer feature with **no admin form and no permissions of its
own** — it is configured through Document Loader and driven in code, and it depends
on the **Document Loader** module (supports Drupal 10.3+ and 11).

Because it fetches the given URL **from your server** rather than from the visitor's
browser, point it only at trusted, expected pages. In typical use the URL comes from
an administrator or a fixed ingestion pipeline; keep control of which URLs the loader
is allowed to fetch and who can set them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. After enabling it, the Webpage
plugin appears at **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`); the URL and options are supplied when the
loader is invoked, not through a per-plugin form.

## Where it lives in the admin menu

The plugin is listed in the Document Loader configuration at **Configuration → Media
→ Document Loader** as an available loader. It adds no settings page of its own —
keep control of *which URLs it is allowed to fetch and who can set them* (see the
overview above).
