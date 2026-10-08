# CacheFlusher — manual setup guide

**CacheFlusher** (`cacheflusher`) adds a one-click cache-flush button to the Drupal
administration toolbar. Instead of visiting the performance settings page or running
`drush cr` every time you need to clear caches, you click the button in the toolbar
and caches are flushed on the spot. It's a small convenience aimed at developers and
site builders who clear caches often during development or content work.

The button is gated by the module's own permission, so only the roles you trust see
and use it. The action it performs is a standard full cache flush — the same
operation as the core "clear all caches" — so there's nothing exotic happening, just
a faster way to trigger it.

One thing to keep in mind: a full cache clear affects performance for **all** users
while the caches rebuild, so grant the permission only to trusted administrators and
don't treat the button as free.

The module works on Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

CacheFlusher adds its button to the **administration toolbar** for users who hold its
permission. There is no separate settings form — the only setup is granting the
permission.

## How to use it

Enable the module, then go to **People → Permissions** and grant CacheFlusher's
permission to the trusted roles that should be able to flush caches. Those users will
see the flush button in the admin toolbar; clicking it clears all caches immediately,
saving the trip to the performance page or the command line.
