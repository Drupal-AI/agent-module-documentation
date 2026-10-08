# Imperva Cache Purger — manual setup guide

**Imperva Cache Purger** (`imperva_cache_purger`) connects Drupal's cache
invalidation to the [Imperva](https://www.imperva.com/) CDN. If you run Imperva as
a reverse proxy in front of your whole site, the edge caches your pages — which is
great for speed, but means that when content changes, visitors can keep seeing the
stale version until the edge cache is cleared. This module fixes that: it is a
purger plugin for the [Purge](https://www.drupal.org/project/purge) module that
forwards Drupal's invalidations to Imperva's API, so the edge drops the stale copy
and re‑fetches fresh content.

It slots into the Purge pipeline like any other purger — you enable it, give it
your Imperva API credentials, and Purge does the rest. Imperva supports
invalidation both by path and by cache tag; the recommended approach is by **cache
tag**, since Drupal emits cache tags out of the box and they invalidate exactly the
right pages when content changes.

The one thing to guard carefully is the credential. The Imperva **API ID** and
**API key** you enter can purge (and, depending on their scope, potentially
reconfigure) your CDN, so treat them as production secrets — store them in an
environment variable and keep them out of committed config (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Purge.
2. [Configuration](configuration/index.md) — add the purger to the Purge pipeline
   and enter your Imperva credentials.

## Where it lives in the admin menu

You configure this purger from the Purge module's own screen at **Configuration →
Development → Performance → Purge**
(`/admin/config/development/performance/purge`). There you add the Imperva purger
to the pipeline and open its **Configure** modal to enter credentials.
