<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebProfiler — agent index

Symfony-style profiler for Drupal (part of Devel). Collects per-request data via
`data_collector` services and renders a **toolbar** on every HTML page plus a **dashboard**
under Reports. Development-only — it replaces subsystems and must not run in production.

- **Settings form + config keys + `settings.php` flags** →
  [configure/settings.md](configure/settings.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Data collectors: the list, and how to add your own** →
  [api/data-collectors.md](api/data-collectors.md)

Key facts:
- `configure` route `webprofiler.settings` at `/admin/config/development/devel/webprofiler`.
  Config object `webprofiler.settings`. Reports/dashboard under `/admin/reports/profiler`.
- Permissions: `access webprofiler` (dashboards/reports/settings; `restrict access: TRUE`) and
  `view webprofiler toolbar`.
- Depends on `devel` and `tracer`. Time metrics need
  `$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;`.
- Collectors are Symfony services tagged `data_collector` (id/label/template/priority); the
  toolbar shows those listed in the `active_toolbar_items` config.
