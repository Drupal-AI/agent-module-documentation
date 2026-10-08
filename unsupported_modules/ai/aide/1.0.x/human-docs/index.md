# Aide — manual setup guide

**Aide** (`aide`) is a small developer library. Despite living in the `ai/`
grouping, it has nothing to do with AI — the name is a play on "aide" (helper). It
provides a single static utility class, `Drupal\aide\Aide`, of convenience helpers
for the routine lookups developers repeat inside Drupal hooks: the current path
(alias‑aware), the current request URI, the current route name, the current node,
the current user, plus helpers for image styles, responsive image styles, and
blocks.

Each method wraps a standard core API and caches the underlying service in a
static, so repeated calls in hook code stay cheap. The point is to let you write
terser `hook_preprocess` and similar implementations without copy‑pasting
`\Drupal::service(...)` boilerplate every time. The class docblock is explicit
that **dependency injection is still preferred inside services** — Aide is meant
for hook code where a container isn't already injected.

It is a pure library: no routes, no permissions, no configuration, no services,
no database tables. Enabling it simply makes the `Aide` class autoloadable, and
because every method wraps a core API read‑only, it has no security‑relevant
surface of its own.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Aide has no admin UI, settings form, or menu items. It is a code‑only
helper you call from your own module or theme.

## How to use it

There is nothing to configure. Once the module is enabled, call the static
helpers from your hook code, for example:

```php
use Drupal\aide\Aide;

$node = Aide::getCurrentNode();
$path = Aide::getCurrentPath();
$user = Aide::getCurrentUser();
```

Inside a service, prefer constructor dependency injection over these static calls.
