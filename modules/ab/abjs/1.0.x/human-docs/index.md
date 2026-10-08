# A/B Test JS — manual setup guide

**A/B Test JS** (`abjs`) runs client-side split tests entirely inside Drupal.
Instead of loading a hosted optimisation tool that injects a third-party script,
sends visitor data elsewhere, and often flickers the page while it rewrites it,
this module keeps the whole apparatus on your own server: the test logic lives in
Drupal, and nothing about your visitors leaves the site.

It works with three building blocks. A **condition** is a snippet of JavaScript
that decides whether a visitor is eligible for a test (for example, only visitors
on a particular page, or only logged-in users). An **experience** is a snippet of
JavaScript that changes the page (a different headline, a new button colour, an
alternate layout). A **test** ties conditions and experiences together and splits
traffic between the variants. Run a test, keep the winning experience.

The most important thing to understand before you hand out access is the
**permission split**, which the module draws deliberately. Writing conditions and
experiences means writing JavaScript that runs on every page view — effectively
the same power as deploying code — so that is locked behind a restricted
permission. Creating and running tests from already-approved snippets is a
separate, unrestricted permission meant for marketers. See
[Configuration](configuration/index.md) for exactly how to split those roles.

Two delivery realities are worth remembering: client-side variants can **flicker**
unless the variant is applied before the page first paints, and they interact
badly with aggressive **page caching** — the traffic split has to be decided
somewhere the cache does not flatten it.

This guide is written for a **human** working through the admin UI. If you want
the terse, token-cheap reference written for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where the admin screens live, the
   conditions/experiences/tests model, and the all-important permission split.

## Where it lives in the admin menu

Once enabled, the module is administered under **Configuration → User interface →
A/B Test JS** (`/admin/config/user-interface/abjs`), where you manage the
conditions, experiences, and tests.
