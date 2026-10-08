# jQuery Deprecated functions — manual setup guide

**jQuery Deprecated functions** (`jquery_deprecated_functions`) is a compatibility
shim for Drupal 11. Drupal 11 ships **jQuery 4**, which removed a number of utility
functions that older jQuery plugins, contrib modules, and themes still call — things
like `$.trim`, `$.isFunction`, `$.camelCase`, and `$.parseJSON`. When code calls one
of those removed functions on jQuery 4 it throws a JavaScript error, and whatever
feature depended on it stops working. This module re-adds the missing pieces so that
legacy code keeps running while you wait for upstream fixes.

It is a pure front-end module with **nothing to configure**. Enabling it registers a
single JavaScript asset library that re-attaches the removed APIs onto the global
`jQuery`/`$`, and that library is loaded on **every page** — early, in the page
header, before other scripts run, so the shims exist by the time anything needs them.
There is no admin UI, no routes, no permissions, and no PHP API to call. You install
it, and it works.

Among the functions it restores are `$.isFunction`, `$.type`, `$.trim`, `$.isArray`,
`$.camelCase`, `$.isWindow`, `$.nodeName`, `$.isNumeric`, `jQuery.now`,
`jQuery.parseJSON`, and `$.unique` (as an alias of `uniqueSort`), plus a few
objects/properties such as `jQuery.fx.interval`, `jQuery.cssNumber`, and
`jQuery.cssProps`. Its one dependency is core's jQuery (`core/jquery`).

Think of it as a bridge: enable it to keep a site working through a Drupal 11 upgrade,
and — ideally — remove it once the contrib modules and libraries that relied on those
removed functions have released jQuery 4-compatible versions. It is also a quick
diagnostic: toggling it on and off tells you whether a JavaScript breakage is caused
by one of the removed jQuery utilities.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the full list of restored
APIs and how the library is attached — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to use and nothing to set up. Once you enable the module, the shim
library is attached to every page automatically and the removed jQuery functions are
available again to any script that runs. You do not choose which functions load — it
is all-or-nothing per page, by design.

To confirm it is working, load a page that was throwing a jQuery error and check the
browser console: the error (for example "`$.trim is not a function`") should be gone.
When the third-party code that needed these functions has been updated for jQuery 4,
you can safely disable and uninstall this module.
