# Backward Compatibility — manual setup guide

**Backward Compatibility** (`backward_compatibility`) restores functions and
APIs that newer versions of Drupal have removed, so older custom or contrib code
keeps running against a supported core. Every Drupal major release drops
deprecated APIs; this module puts a subset of them back so that code which still
calls them does not fatal.

The honest, legitimate use is narrow but real: a site with a five-year-old custom
module whose author has left and which has no tests. A compatibility shim is how
such a site gets onto a supported core *at all* — you restore the removed
functions, upgrade core now (so the site is at least receiving security updates),
and fix the call sites afterwards. "Just update the code" assumes a budget and an
author the site may not have. It declares compatibility with Drupal 9, 10 and 11
and lives in the *Custom* package. It ships version 1.0.2, dated 2023.

Three things to be clear about before you rely on it:

1. **It is a bridge, not a destination.** Shimmed code is unmaintained code
   running against a core that no longer expects it, and the APIs were removed
   because they had problems — often correctness or security ones — which the
   shim reintroduces.
2. **Its own maintenance is the risk.** A compatibility layer that lags behind
   core becomes the thing that breaks the *next* update. A 2023 module declaring
   support for a core major released afterwards is a declaration, not a test
   result — verify it on your site.
3. **Enumerate and track what it provides.** Each restored API is a named piece
   of technical debt. The honest use is: install it, list exactly what it is
   providing, and close that list down deliberately rather than forgetting it is
   there.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no configuration screen and no permission — the module simply provides
the removed APIs once enabled. The work is not in the module; it is in the plan
around it. Enable it as part of a core upgrade, note down which deprecated
functions your code actually needs, fix those call sites over time, and then
uninstall the shim once nothing depends on it any more. Treat it as a timed loan,
not a permanent fixture.
