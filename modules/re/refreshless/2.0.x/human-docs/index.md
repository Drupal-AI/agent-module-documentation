# RefreshLess — manual setup guide

**RefreshLess** (`refreshless`) makes navigating a Drupal site feel like a
single-page app — fast, smooth, no full white-flash page reload between clicks —
while keeping the site fully functional even when JavaScript fails. It intercepts
link clicks and swaps the page content in over JavaScript (a "Turbo"-style
approach) on top of Drupal's normal server-rendered HTML.

The key idea is **progressive enhancement**: the browser still receives ordinary
Drupal HTML, so if JavaScript doesn't load or breaks, navigation simply falls back
to traditional page loads and nothing is lost. You don't have to choose between a
resilient server-rendered site and an app-like experience — you get both. And
because it reuses Drupal's existing Twig templates, asset libraries, caching and
security, you avoid the cost of building a whole decoupled front end just to make
navigation feel quick.

Under the hood it builds on the **Hux** module (its one dependency) for hook
attributes, cooperates with **BigPipe** for progressive content streaming, and
adds cache contexts so render output can vary between a partial (in-place) load and
a full page load. A kill-switch service, HTTP middleware and cookie let you opt
individual responses or a whole session out of RefreshLess handling when needed.

There is no settings page, no permission and no route: RefreshLess is a pure
front-end runtime enhancement. Its security posture is benign — no user input
reaches a sink, and it makes no external calls. Enabling it (and confirming
BigPipe is available) is essentially all there is to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its Hux dependency, and confirm BigPipe.

There is **no configuration page** for this module — it has no settings form. It
works site-wide once enabled, as described below.

## Where it lives in the admin menu

RefreshLess adds no admin page. Once enabled it works site-wide, enhancing
navigation on your existing theme automatically. Developers who want to integrate
with it (custom behaviors, events, opting responses out) will find the details on
the project's documentation site linked from
[drupal.org/project/refreshless](https://www.drupal.org/project/refreshless).

## How to use it

1. Enable the module (and its **Hux** dependency).
2. Make sure core's **BigPipe** module is enabled — RefreshLess cooperates with it,
   and the module's install requirements will warn you if BigPipe support is
   missing.
3. Browse the site as a visitor. Clicking links now swaps content in place instead
   of triggering a full reload, so navigation feels faster and more fluid, and
   page transitions (and persistent elements such as media players) become
   possible.

That's it — there is nothing you *must* configure. If you ever need to disable the
enhancement for a specific response during debugging, developers can use the
kill-switch service or set the kill-switch cookie to fall back to normal page
loads.
