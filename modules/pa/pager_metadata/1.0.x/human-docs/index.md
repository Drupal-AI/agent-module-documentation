# Pager metadata — manual setup guide

**Pager metadata** (`pager_metadata`) improves the SEO of any page that has a pager —
long Views listings, blog and news indexes, glossaries, archives, comment threads,
product catalogs, and the like. It fixes two common pagination problems for search
engines. First, it makes the page's canonical `<link>` **page‑aware**, so page 2 of a
listing (`?page=1`) has its own canonical instead of every page pointing back at page
1. Second, it emits `<link rel="prev">` and `<link rel="next">` head links so crawlers
understand the sequence of pages in a multi‑page listing.

The best part is that there is nothing to configure. The module is entirely automatic:
once enabled it runs a few hooks on every request, rewriting the canonical and adding
prev/next links wherever a pager appears. It works with core pagers, with **Views
Infinite Scroll** pagers, and even when a paginated View is rendered inside a block. It
has no admin form, no permissions, no dependencies beyond core, and no submodules.

There is exactly one optional tweak, and it lives in `settings.php` rather than the UI —
a flag to turn off the canonical rewriting while keeping the prev/next links. Most sites
never need it.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it. That's the whole setup.

## Where it lives in the admin menu

Nowhere — Pager metadata has no admin page, no settings form, and no menu entries. It
works silently after you enable it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). It immediately starts
   adding pager‑aware canonicals and `rel="prev"` / `rel="next"` head links to paginated
   pages.
2. To confirm it's working, load a listing page with a pager (for example
   `/your-view?page=1`) and view the page source. In the `<head>` you should see the
   canonical URL carrying `?page=1`, plus `<link rel="prev">` and `<link rel="next">`
   entries pointing at the neighboring pages. (The redundant `page=0` is dropped from
   the first page's link automatically.)

### The one optional setting

If you want to keep the prev/next links but stop the module from rewriting the canonical
URL, add this to your `settings.php`:

```php
// Default is TRUE. Set to FALSE to leave the canonical link untouched.
$settings['pager_metadata_alter_canonical'] = FALSE;
```

There is no UI for this — it is a `settings.php`‑only toggle. With it set to `FALSE`, the
`rel="prev"` / `rel="next"` links are still emitted; only the canonical rewrite is
skipped. This is handy if another SEO/metatag module already manages your canonical tags.
