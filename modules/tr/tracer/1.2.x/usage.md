<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tracer is a developer API module that replaces some of Drupal core's services with traceable versions so other modules (e.g. Webprofiler) can record spans for events, the request, HTTP client calls, controllers and Twig rendering.

---

Tracer provides a single `TracerInterface` (start/openSection/closeSection/stop/getEvents spans) and a `tracer.tracer` service whose concrete backend is chosen by a `TracerFactory`. By default no backend is configured, so the factory returns a `NoopTracer` that records nothing (zero overhead). A real backend is activated by setting `$settings['tracer_plugin']` in `settings.php` to the fully-qualified class name of a `TracerInterface` implementation (Webprofiler ships one). To make things traceable, Tracer decorates/replaces core services via its `TracerServiceProvider` and `tracer.services.yml`: it decorates the `event_dispatcher` with a `TraceableEventDispatcher`, wraps the HTTP kernel in a `TracesMiddleware` (http_middleware, priority 350), adds an `HttpClientMiddleware`, replaces the controller resolver with a `TraceableControllerResolver`, and registers a Twig profiler extension. Each traced integration calls `TracerInterface::start()`/`stop()` around the work it wants to measure. Tracer itself only produces data when a non-noop backend is active — it is the instrumentation layer, not a UI; tools like Webprofiler consume `getEvents()` to display the traces. It has no configuration form, no config schema, no permissions, no Drush commands and no plugin manager.

---

- Provide the tracing backbone that Webprofiler uses to profile a Drupal request.
- Instrument the event dispatcher to see which listeners fire and how long they take.
- Trace the full HTTP request lifecycle via the traceable stack middleware.
- Record outbound Guzzle HTTP client calls made by Drupal.
- Measure controller resolution time with the traceable controller resolver.
- Profile Twig template rendering through the bundled Twig profiler extension.
- Write a custom tracer backend (implementing `TracerInterface`) to export spans to your APM.
- Send spans to OpenTelemetry/Jaeger/Zipkin by plugging in a compatible backend class.
- Keep zero tracing overhead in production by leaving the default `NoopTracer` active.
- Enable tracing only on a staging environment by setting `tracer_plugin` in that env's settings.php.
- Give performance-investigation tools a uniform span API across core subsystems.
- Collect timing data for a specific request path to find slow listeners or controllers.
- Build a developer dashboard that reads `tracer.tracer` `getEvents()` output.
- Wrap custom code in `start()`/`stop()` spans to include it in the trace.
- Decorate additional services in your own module using the same traceable pattern.
- Diagnose which event subscribers dominate bootstrap time.
- Correlate HTTP client latency with overall request time during debugging.
- Provide traceable services without patching Drupal core (uses decoration/replacement).
- Toggle a real backend on/off per environment without code changes to modules.
- Serve as a dependency for observability/profiling contrib modules that need span data.
