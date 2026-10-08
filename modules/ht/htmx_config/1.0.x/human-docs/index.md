# HTMX Config — manual setup guide

**HTMX Config** (`htmx_config`) is developer plumbing rather than an end-user
feature. It provides a single, canonical API for gathering HTMX configuration in
one place and delivering it to the browser. HTMX is the small hypermedia library
that lets you build AJAX-style interactions using plain HTML attributes; this
module gives Drupal a consistent way to configure that behavior so different
modules aren't each inventing their own approach.

On its own, HTMX Config does not add any visible pages, content, or functionality.
Its value is as a **foundation** — other HTMX-related modules (such as
[HTMX Extras](https://www.drupal.org/project/htmx_extras)) build on top of it so
that HTMX configuration is aggregated and provided to the client in one canonical
way.

Because it is a developer API, there is nothing to click through and nothing to
tune in the admin UI. You enable it because another module needs it, or because you
are writing HTMX-powered features yourself and want a clean place to manage the
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it exposes a developer API,
not a settings form. You interact with it from code, or simply enable it so a
dependent module can use it.

## How to use it

Enable the module (see [Installation](installation/index.md)). From there it is
consumed programmatically: your code, or a module that depends on it, uses the
HTMX Config API to register and aggregate HTMX configuration, which the module then
delivers to the client. If you installed it only because another module listed it
as a dependency, there is nothing further for you to do.
