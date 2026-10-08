<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WebProfiler is a Symfony-style profiler for Drupal: it collects detailed information about every request (database queries, services, routes, timing, memory, cache, forms, mail, and more) and shows it in a toolbar on each HTML page plus a dedicated dashboard under Reports.

---

Part of the Devel family, WebProfiler creates a profile file for every request and renders the collected data two ways: a **toolbar** injected into every HTML response and a **back-office dashboard** at `/admin/reports/profiler`. The data comes from a set of Symfony `data_collector` services (Database, Services, Routing, Events, Time, Memory, Cache, Config, Forms, Views, Blocks, Assets, Mail, Logs, Http, User, Theme, State, Translations, Extensions, Devel, Frontend, …); which ones appear in the toolbar is controlled by the `active_toolbar_items` config. It is configured from a settings form at `/admin/config/development/devel/webprofiler` (config object `webprofiler.settings`) where you set excluded paths, whether to intercept redirects, whether to purge profiles on cache clear, database-query display options, and the IDE link format for jumping to source. Some features are opt-in via `settings.php`: `$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;` enables time metrics, and `$settings['webprofiler_error_page_disabled'] = TRUE;` turns off its custom error handler. Two permissions gate it — `access webprofiler` (dashboards, reports, settings; restricted) and `view webprofiler toolbar`. Because it replaces several Drupal subsystems to collect data, it is a development tool and **must not be used in production**. Requires `devel` and `tracer`.

---

- See every database query a page ran, with timings, and highlight slow queries.
- Inspect which services, event subscribers, and route matched on a request.
- Profile request time and memory usage per page during development.
- View a per-request dashboard of collected data at /admin/reports/profiler.
- Show a debug toolbar on every HTML page while building a site.
- Choose which collectors appear in the toolbar via the active_toolbar_items setting.
- Run EXPLAIN on a logged query from the database panel.
- Jump from a profiled file reference straight into your IDE (PhpStorm, VS Code) via the IDE link setting.
- Exclude noise paths (contextual, toolbar, AJAX, JS/CSS) from profiling with exclude_paths.
- Intercept redirects so you can inspect the profiler on a response that would otherwise redirect.
- Keep or purge stored profiles automatically when the cache is cleared (purge_on_cache_clear).
- Enable time-metric collection by setting the Stopwatch tracer plugin in settings.php.
- Send trace data to an external store (e.g. Grafana Tempo) via the tracer module.
- List and revisit previously saved profiles by token from the reports list.
- Debug form build/validation by inspecting the Forms collector.
- Audit which config objects and cache bins a page touched.
- Review rendered Views and blocks for a page from their collectors.
- Inspect mail that would have been sent during a request (Mail collector).
- Disable WebProfiler's custom error handler when it conflicts with another error-handling module.
- Threshold detailed query output so pages with very many queries stay responsive.
- Collect Core Web Vitals / frontend navigation timing via the frontend collector endpoints.
- Diagnose performance regressions locally before they reach production.
- Restrict profiler access to trusted developers with the access webprofiler permission.
