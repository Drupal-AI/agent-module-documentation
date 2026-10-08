# Tracer — manual setup guide

**Tracer** (`tracer`) is a developer‑focused API module that replaces some of
Drupal core's services with "traceable" versions, so profiling and observability
tools can record **spans** — timed measurements — for things like events, the
overall request, outbound HTTP calls, controller resolution and Twig rendering.
It is the instrumentation layer that **Webprofiler** and similar tools build on.

Tracer is not something you look at directly — it has no UI, no reports and no
dashboard. It simply provides a common `TracerInterface` and a `tracer.tracer`
service, and it decorates a handful of core services so the work they do can be
measured. A consuming tool (Webprofiler, or a custom backend you write) reads the
recorded spans and displays them.

Crucially, Tracer does **nothing by default**. Until you activate a real backend,
the service resolves to a "no‑op" implementation that records nothing and adds
zero overhead — which makes it safe to have enabled in production. You turn real
tracing on by naming a backend class in `settings.php` (see below), typically only
in a development or staging environment.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent — including the full `TracerInterface` method table and how
to write your own backend — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Tracer has **no settings form, no config, no permissions and no admin
links**. It is a code‑level instrumentation layer. The only "setting" is a single
line in `settings.php` that activates a backend.

## How to use it

For most people, Tracer is a dependency of another tool: you enable it because
Webprofiler (or another profiler) needs it, and that tool takes care of switching
on a real backend and showing you the results.

If you want to activate tracing yourself, add a line like this to `settings.php`,
pointing at a class that implements `TracerInterface` (Webprofiler ships one):

```php
$settings['tracer_plugin'] = 'Drupal\\my_module\\MyTracer';
```

- If `tracer_plugin` is **unset** (the default), Tracer uses its built‑in
  `NoopTracer`, which records nothing — zero overhead.
- Set it only where you want tracing, e.g. a staging environment's `settings.php`,
  so production stays untouched.

Once a real backend is active, Tracer automatically instruments the event
dispatcher, the HTTP request lifecycle, the Guzzle HTTP client, controller
resolution and Twig rendering. Developers can also wrap their own code in
`start()`/`stop()` spans to include it in the trace. See the
[`agent/`](../agent/start.md) docs for the exact API and an example backend.
