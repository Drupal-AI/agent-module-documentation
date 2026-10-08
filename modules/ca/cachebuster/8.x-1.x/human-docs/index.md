# Cache Buster — manual setup guide

**Cache Buster** (`cachebuster`) is a front-end development helper that makes browsers
always fetch fresh CSS. While you are iterating on styles, Drupal's CSS aggregation
and caching can keep serving stale stylesheets, so your changes don't show up until
you clear caches. Cache Buster sidesteps that: it rewrites every non-external CSS file
as an external reference (prefixing its path with `/`), which bypasses aggregation so
edits appear immediately.

It is deliberately blunt and deliberately temporary. Because it disables CSS
aggregation site-wide, the module also prints an admin warning on every request
reminding you to uninstall it outside development. It has no configuration screen, no
routes, and no permissions — the entire behaviour lives in one `hook_css_alter()`
implementation, and you switch it on or off simply by enabling or disabling the
module.

The module works on Drupal 8, 9, and 10.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Cache Buster has no settings form, routes, or permissions. Its only visible
sign is the warning message it shows administrators reminding you to remove it before
production.

## How to use it

Enable the module on your **local or development** environment when you're actively
working on CSS. Edit your stylesheets and reload — the changes appear without a cache
clear, because aggregation is bypassed. When you're done, **uninstall it** (or at
least disable it) so it never reaches production, where disabling CSS aggregation
would hurt performance for real visitors.
