# Tracer — manual setup guide

**Tracer** (`tracer`) is a developer API module that replaces some of Drupal core's
services with **traceable** versions, so profiling and observability tools can record
spans (timed sections) for events, the request lifecycle, HTTP client calls,
controller resolution, and Twig rendering.

The most important thing to understand about Tracer is that **it does nothing on its
own**. It is the instrumentation layer, not a UI — you install it only because another
module needs it. Modules that require Tracer include **Webprofiler** and the
**Observability suite**. If you are not using such a module, you do not need Tracer.

By default Tracer uses a "no-op" backend that records nothing and adds zero overhead,
which keeps it safe even if it ends up enabled on production. A real tracing backend is
activated only when you explicitly point a `settings.php` variable at a backend class
(Webprofiler ships one). Once a real backend is active, Tracer's traceable services
feed span data to whatever tool is consuming it.

It has no configuration form, no config schema, no permissions, no Drush commands, and
no plugin manager. Backends are plain classes referenced from `settings.php`, not
discovered plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (usually as a dependency of a profiling module).

There is **no configuration page** for this module. It is activated in `settings.php`,
described in "How to activate tracing" below.

## Where it lives in the admin menu

Tracer adds no admin page. It works entirely behind the scenes by decorating core
services (the event dispatcher, HTTP kernel middleware, HTTP client, controller
resolver, and Twig). The traces it produces are surfaced by the tool that consumes
them — for example Webprofiler's toolbar and reports.

## How to activate tracing

Out of the box, Tracer's factory returns a `NoopTracer` that records nothing. To turn
on real tracing, set the `tracer_plugin` variable in your `settings.php` (or
`settings.local.php`) to the fully-qualified class name of a `TracerInterface`
implementation. When using Webprofiler, use the tracer class Webprofiler provides
(check that module's documentation for the exact class name):

```php
// In settings.php (typically only on a development or staging environment)
$settings['tracer_plugin'] = SomeTracerBackend::class;
```

Because this is per-environment, you can keep tracing off (the default no-op backend)
on production and turn it on only where you are investigating performance, with no
code changes to any module. Advanced users can write their own backend implementing
`TracerInterface` to export spans to an APM such as OpenTelemetry, Jaeger, or Zipkin —
see the sibling [agent docs](../agent/start.md) for the interface details.
