# lazy-service — manual setup guide

**lazy-service** (`lazy_service`) is a developer‑oriented **proof of concept** that
makes on‑demand (lazy) loading of an injected service possible **without** having
to declare the target service as `lazy: true` up front or hand‑generate its proxy
class.

Normally in Drupal, lazy‑loading an injected service requires the module that
*defines* the service to mark it `lazy: true` and to generate a ProxyClass into that
module — which is awkward when it is the *consumer*, not the owner, who wants the
service to be lazy. lazy-service turns that around. During container build it scans
every service definition for arguments whose id is **prefixed with `lazy.`** (for
example `lazy.some_module.heavy_service`). For each one it resolves the real
service, auto‑generates a proxy class, registers it, and rewires the definition so
the consumer receives a lazy proxy that only instantiates the real service when it
is first used.

This means a heavy service that some code paths never touch is no longer loaded on
those paths — you just prefix its id with `lazy.` where you inject it. The module
comes with a `lazy_service_example` submodule that demonstrates the pattern with a
`myLazy` service consumed via an event subscriber.

Because it is a proof of concept, treat it accordingly: it is an alpha, and (for
example) array‑form service arguments are not yet recursed. It is aimed at
developers experimenting with lazy dependency injection, and the author hopes the
idea can eventually be improved enough to land in core.

This guide is written for a **human** — here, a developer working in code and on the
command line. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead. For the mechanics of the
`lazy.` prefix, see the agent [extend/lazy-prefix.md](../agent/extend/lazy-prefix.md)
note.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it is container/dependency‑injection
infrastructure, with no routes, permissions, settings form, or admin UI.

## Where it lives in the admin menu

Nowhere — lazy-service adds no admin page and no settings. It works entirely at the
service‑container level, so you use it from your module's `*.services.yml` and
`create()` methods rather than from the UI.

## How to use it

In your module's `*.services.yml`, reference the target service id **prefixed with
`lazy.`** instead of the plain id:

```yaml
services:
  my_module.consumer:
    class: Drupal\my_module\Consumer
    arguments: ['lazy.some_module.heavy_service']
```

The same works inside a `create()` method — call
`$container->get('lazy.some_module.heavy_service')` instead of the plain id. On the
next container rebuild, lazy-service detects the `lazy.` prefix, generates the proxy
class (written under the site's files directory, with the namespace path preserved
to avoid collisions), and hands your class a proxy that instantiates the real
service only on first use. Rebuild the container (clear caches) after adding a
`lazy.` reference.
