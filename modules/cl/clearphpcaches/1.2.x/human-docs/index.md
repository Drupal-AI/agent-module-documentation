# Clear PHP Caches — manual setup guide

**Clear PHP Caches** (`clearphpcaches`) adds a button to the Drupal admin toolbar
that flushes PHP's own bytecode caches — **OPcache** and **APC** — from the
browser, without needing to restart PHP-FPM or touch the server. This is aimed
squarely at operations and deployment work: after a code deploy, OPcache can hold
onto stale compiled PHP, and being able to clear it from the UI (rather than
restarting the PHP process) is a genuine convenience.

The flush is triggered from a menu link the module adds to the admin toolbar, which
calls an admin action at `/admin/flush/phpcaches`. Because it adds this link to the
toolbar, the module **depends on the Admin Toolbar module** — Drupal will pull it
in for you. It supports Drupal 10 and 11.

The action is protected by a dedicated **`clear php caches`** permission. Grant it
only to trusted administrators: clearing OPcache causes a brief performance dip
while PHP recompiles, so it isn't something you want casually triggered. Note the
module is *minimally maintained* (maintenance fixes only) and is not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.

There is **no configuration page** for this module — it has no settings form. The
only setup beyond enabling it is granting the `clear php caches` permission,
described under "How to use it" below.

## How to use it

1. Grant the **`clear php caches`** permission to your trusted admin role(s) at
   **People → Permissions**.
2. In the admin toolbar, use the menu link the module adds. It triggers the flush
   action at `/admin/flush/phpcaches`, clearing PHP's OPcache/APC on the server.

Use it after a deployment when PHP may be serving stale compiled code. Expect a
brief performance impact immediately afterwards while PHP recompiles.
