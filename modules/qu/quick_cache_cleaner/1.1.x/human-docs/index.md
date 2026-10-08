# Quick Cache Cleaner — manual setup guide

**Quick Cache Cleaner** (`quick_cache_cleaner`) is a deliberately simple module that
adds an **administrative menu item for clearing caches**. Click it and the module
flushes all Drupal core caches and Views caches, then drops you back in the
administration menu — a quick alternative to the Performance settings page or a Drush
command when you just want to see your latest change.

It is aimed at content contributors who need to bust a cache so their edits appear,
without giving them access to the full Performance page. Under the hood it simply
calls the cache‑clearing functions Drupal core already provides.

Because clearing caches is a privileged action with a real (if temporary)
performance cost — the site rebuilds its caches afterward — the module gates the
menu item behind its own permission. Grant that permission only to trusted
administrators and editors, not to untrusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — it adds a single cache‑clear action
to the admin menu and one permission that controls who may use it.

## How to use it

After enabling, grant the module's cache‑clear permission at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be allowed to flush caches.
Those users will then see a cache‑clear item in the administration menu; clicking it
clears the core and Views caches and returns them to the admin menu. There is
nothing to configure.
