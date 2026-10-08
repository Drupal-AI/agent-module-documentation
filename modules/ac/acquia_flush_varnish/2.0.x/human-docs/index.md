# Acquia Flush Varnish — manual setup guide

**Acquia Flush Varnish** (`acquia_flush_varnish`) lets administrators **purge the
Acquia platform's Varnish and associated CDN cache from inside Drupal**. When a
change is live in Drupal but visitors are still seeing a stale page served from the
edge cache, this module lets you clear that cache without leaving the admin.

It is a small **administration / performance** tool. Purging the edge cache is a
privileged operation with real consequences — every purged page has to be rebuilt
from origin on the next request — so the module ships its **own permission** and
gates the action behind it. Grant that permission only to trusted administrators.
Beyond that permission it has no content-access role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the purge permission.

## Where it lives in the admin menu

Once enabled, the flush action is available to users who hold the module's purge
permission. Assign that permission at **People → Permissions**
(`/admin/people/permissions`) before anyone can trigger a purge.

## How to use it

1. On an Acquia-hosted site, enable the module (see
   [Installation](installation/index.md)).
2. Grant the module's purge permission to your trusted administrator role at
   **People → Permissions** — and only to roles you trust, since a purge affects
   the live edge cache.
3. Trigger the flush from the admin when you need to clear stale edge-cached pages,
   for example right after publishing a change that visitors are not yet seeing.
