<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracer — agent index

Developer API module. Replaces some core services with **traceable** versions and exposes a
`TracerInterface` so profiling tools (e.g. Webprofiler) can record spans. **No config form, no
config schema, no permissions, no Drush, no plugin manager.** By default it does nothing
(`NoopTracer`); a real backend is activated in `settings.php`.

- **The `TracerInterface`/`tracer.tracer` service, activating a backend, what it decorates,
  writing your own backend** → [api/tracing.md](api/tracing.md)

Key facts:
- Service `tracer.tracer` (interface `Drupal\tracer\TracerInterface`) is built by
  `Drupal\tracer\TracerFactory` from `Settings::get('tracer_plugin')`. If unset → `NoopTracer`
  (records nothing). Set `$settings['tracer_plugin'] = SomeClass::class;` in `settings.php` to
  activate real tracing.
- `TracerInterface` methods: `start(string $category, string $name, array $attributes = []): object`,
  `openSection(object $span): object`, `closeSection(object $span): object`,
  `stop(object $span): void`, `getEvents(): array`.
- Decorated/replaced services (`tracer.services.yml` + `TracerServiceProvider`): `event_dispatcher`
  → `TraceableEventDispatcher`; HTTP kernel wrapped by `TracesMiddleware` (http_middleware,
  priority 350); `HttpClientMiddleware` (http_client_middleware); controller resolver →
  `TraceableControllerResolver`; Twig profiler extension.
- There is an `@Tracer` annotation class but **no plugin manager** — backends are plain classes
  referenced from settings, not discovered plugins.
