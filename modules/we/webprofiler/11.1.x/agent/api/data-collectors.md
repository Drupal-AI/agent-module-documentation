<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data collectors & extending WebProfiler

WebProfiler's panels come from **Symfony data collectors** — services tagged `data_collector`,
gathered by `Compiler\ProfilerPass`. These are *not* a Drupal plugin type (no annotation/
manager); you register one as a service in your module's `*.services.yml`.

## Shipped collectors (`src/DataCollector/`)

`Assets`, `Blocks`, `Cache`, `Config`, `Database`, `Devel`, `Events`, `Extensions`, `Forms`,
`Frontend`, `Http`, `Logs`, `Mail`, `Memory`, `Request`, `Routing`, `Services`, `State`,
`Theme`, `Time`, `Translations`, `User`, `Views`.

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
- `priority` — toolbar/dashboard ordering (higher = earlier; shipped ones run 1000–1100+).

## Base classes / interfaces

- `DataCollector\DataCollector` + `DataCollectorTrait` — base for a Drupal-flavoured collector;
  implement `collect(Request, Response, ?\Throwable)` and getters for your template.
- `DrupalDataCollector` — richer base with panel helpers.
- `HasPanelInterface` / `PanelTrait` — for collectors that render a full dashboard panel.
- `TemplateAwareDataCollectorInterface` — declare the panel template.

A collector's data is serialized into each request's profile, so keep collected values small
and serializable.

## Tracer integration (time)

Time metrics rely on the `tracer` module. Enable the stopwatch tracer in `settings.php`:
`$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;`
(there is a `Plugin/Tracer/` namespace here — that *is* a real plugin, unlike the collectors).
