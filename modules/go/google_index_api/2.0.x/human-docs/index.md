# Google Index API — manual setup guide

**Google Index API** (`google_index_api`) notifies **Google's Indexing API** when a
page is published, updated, or removed, so Google prioritises crawling that URL
instead of waiting for its next sitemap fetch. Sitemaps are only a hint that Google
acts on at its own pace — fine for a blog, but inadequate when content is
time‑sensitive, such as a job posting that closes in three days.

The module wires the Indexing API into Drupal through the official Google API PHP
client. It provides a settings form, a **bulk update** form for submitting many URLs
at once (handy after a migration or a large content change), and a **service class**
with two methods — `updateUrl()` and `deleteUrl()` — that you can call from your own
code, typically in an entity update or delete hook.

> **Important scope limit.** Google documents the Indexing API as being **for job
> postings and livestream content specifically**, not general pages. Using it outside
> that scope is unsupported behaviour, however well the calls succeed — for general
> content, an XML sitemap is the right tool. Also note Google limits you to roughly
> **200 calls per day**, so use the module accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Google API PHP client) and enable the module.
2. [Configuration](configuration/index.md) — supply a Google service‑account key and
   set up the API, then use the bulk‑update form.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Google Index API**
(`/admin/config/services/google-index-api`), and the bulk update form is at
`/admin/config/services/google-index-api/bulk-update`. Both are gated by the
**Administer Google Index API** permission.

## How to use it

For automatic notifications, call the service from an entity hook, for example:

```php
/**
 * Implements hook_ENTITY_TYPE_update() for node entities.
 */
function YOUR_MODULE_node_update(\Drupal\node\NodeInterface $node) {
  \Drupal::service('google_index_api.client')->updateUrl($node->toUrl()->toString());
}
```

For a backlog of URLs (after a migration or a big change), use the **bulk update**
form instead of calling the API one URL at a time.
