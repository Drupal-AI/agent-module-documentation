# Fix Views Autocomplete — manual setup guide

**Fix Views Autocomplete** (`fix_views_autocomplete`) is a tiny bug‑fix module
that resolves a specific, annoying Views error. If you build a View with a block
display, add exposed filters with AJAX and autocomplete, and also have a page
display with a contextual (dynamic) argument in its path, placing that block can
break the page with an error like:

> `Parameter "view_args" for route "views_filters.autocomplete" must match
> "[^/]++" ("" given)`

The problem is that the Views autocomplete route refuses an empty `view_args`
argument. This module adjusts that route so an empty `view_args` is allowed, and
the affected Views simply go back online.

There is nothing to configure and no content or access behaviour involved — it's
purely a routing fix. It exists because the equivalent core fix has been stuck in
the issue queue for years, and patching core after every update isn't practical;
this module is a hassle‑free alternative you can enable today. If the core patch
is ever accepted, this module will likely become unnecessary on newer Drupal
versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. Enabling it is
the entire setup.

## Where it lives in the admin menu

Fix Views Autocomplete adds no admin page and no settings. Once enabled, the fix
is active automatically.
