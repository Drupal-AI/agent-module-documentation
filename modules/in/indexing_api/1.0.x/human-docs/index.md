# Indexing API — manual setup guide

**Indexing API** (`indexing_api`) connects your Drupal site to Google's
**Indexing API** so that Google finds out about page changes the moment they
happen instead of waiting for its next scheduled crawl. Whenever a content entity
you have opted in is created, updated, or deleted, the module sends Google a
`URL_UPDATED` or `URL_DELETED` notification for that page's URL, prompting Google
to (re-)crawl or drop it.

Google designed the Indexing API primarily for short-lived, fast-changing pages —
job postings and livestream/broadcast video pages — so it is at its most valuable
on sites where content appears and disappears quickly and search freshness
matters. You choose exactly which entity types and bundles participate, so the
module never notifies Google about pages you do not want indexed.

Setting it up has two sides: a **Google side** (a Google Cloud project with the
Indexing API enabled, a service account granted owner access to your property in
Search Console, and its JSON key file) and a **Drupal side** (upload that key,
confirm the endpoint and scope, and tick the bundles to index). Both are covered
in the guides below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Google prerequisites, the
   settings form (hostname, endpoint, scope, service-account key), and choosing
   which entity bundles to index.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Indexing API**
(`/admin/config/services/indexing-api`). From there a per-entity-type "assign"
screen lets you pick which bundles are indexable. Both pages require a privileged
user (see [Configuration](configuration/index.md) for a note on the permission).
