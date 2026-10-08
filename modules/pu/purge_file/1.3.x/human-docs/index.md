# Purge File — manual setup guide

**Purge File** (`purge_file`) automatically clears file URLs out of an external
cache — Varnish, CloudFront, Acquia, or any CDN or reverse proxy — through the
**Purge** module whenever a file is inserted, updated, or deleted. It solves a
specific, common problem: when an editor replaces a file (a logo, a PDF, an image)
but keeps the same filename and URL, the edge cache keeps serving the old copy.
Purge File hands the file's URL to Purge so the stale version is invalidated and
anonymous visitors get the new one.

The module watches file entity lifecycle events and, when a file genuinely
changes, sends its URL(s) to Purge for invalidation. On an update it is careful:
it only purges when the file's URI or size actually changed, and it purges the
original URL too if the URL changed. It works only when your site replaces file
contents in place and serves those files through an external, anonymous cache.

You control the behavior from one small settings form: whether invalidations run
**immediately** or are added to the **Purge queue** for later processing (for
example on cron), which **invalidation type** to use (full URL, path, or their
wildcard variants), optional **base URLs** for sites split across multiple
domains, and a **debug logging** toggle for troubleshooting. It also adds a status‑
report check that warns if no URL‑capable purger is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Purge prerequisites).
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Performance → Purge
File** (`/admin/config/development/performance/purge-file`), as a tab under the
Performance page. It requires the core **Administer site configuration**
permission — the module defines no permissions of its own.

## How to use it

Make sure the Purge module is set up with at least one purger that can invalidate
URLs or paths and at least one processor. Then open the Purge File settings form,
choose your workflow and invalidation type to match your purger, and save. From
then on, replacing or deleting a file automatically invalidates it at the edge —
no per‑file action needed. Check the site status report to confirm a URL‑capable
purger is enabled.
