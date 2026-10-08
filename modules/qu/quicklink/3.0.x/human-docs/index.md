# Quicklink — manual setup guide

**Quicklink** (`quicklink`) integrates Google's Quicklink JavaScript library into
Drupal to make navigation feel instant. As a visitor reads a page, Quicklink
watches which links are currently visible in the browser viewport and, during the
browser's idle time, quietly **prefetches** those pages in the background. When
the visitor then clicks one, it is often already loaded — so the next page appears
nearly immediately. This improves *perceived* performance and Core Web Vitals
without any server-side changes.

Prefetching only affects how fast pages feel; it never changes what a page
renders. The module attaches the Quicklink library on every page and drives all
of its behavior from a single settings form, where you control what to skip
(admin paths, AJAX links, anchor links, downloads, arbitrary URL substrings, CSS
selectors), when to load the library at all (anonymous visitors only, not during
PHP sessions, opting specific content types out), and how aggressively to
prefetch (request limits, concurrency, idle and viewport timing). There is also a
debug mode that logs exactly what is and isn't being prefetched.

Quicklink works the moment you enable it — the sensible defaults already ignore
admin paths, AJAX links, hashes, downloads, and the logout link, and load only
for anonymous users. It requires core's **Node** module and works on Drupal 10.2+
and 11. The Quicklink library itself loads from a CDN by default, but you can host
it locally — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally host the library locally.
2. [Configuration](configuration/index.md) — the settings form, tab by tab.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Performance →
Quicklink** (`/admin/config/development/performance/quicklink`), gated by the core
*Administer site configuration* permission.

## How to use it

Enable the module and prefetching starts working immediately with its defaults.
If you want to tune what gets prefetched — for example excluding a `/cart` path,
scoping prefetching to your main content region, or allowing logged-in users —
open the settings form and adjust the relevant tab. See
[Configuration](configuration/index.md).
