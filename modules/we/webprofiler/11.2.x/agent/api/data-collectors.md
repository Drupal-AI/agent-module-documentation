<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data collectors & extending WebProfiler

WebProfiler's panels come from **Symfony data collectors** — services tagged `data_collector`,
gathered by `Compiler\ProfilerPass`. These are *not* a Drupal plugin type (no annotation/
manager); you register one as a service in your module's `*.services.yml`.

## Shipped collectors (`src/DataCollector/`)

`Ai`, `Assets`, `Blocks`, `Cache`, `Config`, `Database`, `Devel`, `Events`, `Extensions`,
`Forms`, `Frontend`, `Http`, `Logs`, `Mail`, `Memory`, `Messenger`, `Request`, `Routing`,
`Services`, `State`, `Theme`, `Time`, `Translations`, `User`, `Views`.

Most are registered in `webprofiler.services.yml`. Some register conditionally from
`WebprofilerServiceProvider` only when a host module is enabled:

- `Ai` (id `ai`) — when the `ai` module is enabled; collects calls to AI providers by
  subscribing to the `ai.pre_generate_response` / `ai.post_generate_response` events.
- `Messenger` (id `messenger`, service `data_collector.messenger`) — when the `sm` (Symfony
  Messenger) module is enabled; collects messages dispatched through Messenger buses.
- `Logs` (id `logs`) — when `monolog` is enabled.
- `Views` (id `views`) — when `views` is enabled.
- `Blocks` (id `blocks`) — when `block` is enabled.

The `active_toolbar_items` config decides which of these render in the toolbar; all enabled
collectors still appear on the dashboard.

## The service tag

```yaml
services:
  my_module.data_collector.things:
    class: Drupal\my_module\DataCollector\ThingsDataCollector
    tags:
      - { name: data_collector, template: '@my_module/Collector/things.html.twig', id: 'things', label: 'Things', priority: 500 }
```

- `id` / `label` — panel identity; `id` is also what you'd add to `active_toolbar_items`.
- `template` — a Twig template rendering the panel (extend WebProfiler's collector layout).
- `priority` — toolbar/dashboard ordering (higher = earlier; shipped ones run 25–1100).

## Base classes / interfaces

- `DataCollector\DataCollector` + `DataCollectorTrait` — base for a Drupal-flavoured collector;
  implement `collect(Request, Response, ?\Throwable)` and getters for your template.
- `DrupalDataCollector` — richer base with panel helpers.
- `HasPanelInterface` / `PanelTrait` — for collectors that render a full dashboard panel
  (e.g. the Time, Memory, AI and Messenger collectors implement `HasPanelInterface`).
- `TemplateAwareDataCollectorInterface` — declare the panel template.

A collector's data is serialized into each request's profile, so keep collected values small
and serializable.

## Tracer integration (time)

Time metrics rely on the `tracer` module. Enable the stopwatch tracer in `settings.php`:
`$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;`
(there is a `Plugin/Tracer/` namespace here — that *is* a real plugin, unlike the collectors).

## Drush

- `webprofiler:export-database-data` (`src/Drush/Commands/ExportDatabaseDataCommands.php`) —
  exports a stored profile's collected database queries as a CSV file.
