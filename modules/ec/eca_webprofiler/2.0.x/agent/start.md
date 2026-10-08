<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Webprofiler (eca_webprofiler) — agent index

Developer/debugging integration that surfaces **ECA (Event-Condition-Action)** activity inside the
**Webprofiler** toolbar and profiler. Package `ECA`. Depends on modules **`eca`** and
**`webprofiler`**. Core `^10.4 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version-dir `2.0.x`
(installed release 2.0.2).

- **The data collector, the decorated logger channel, what is captured, and how a developer reads it** →
  [api/data-collector.md](api/data-collector.md)

## What it actually is (from source)

- **No routes, no permissions, no config/schema, no libraries, no Drush, no hooks, no submodules.** The
  entire module is two PHP classes wired in `eca_webprofiler.services.yml` plus two Twig templates.
- Service `webprofiler.eca` = `src/DataCollector/EcaDataCollector.php` (extends Symfony
  `DataCollector`, implements `HasPanelInterface`). Tagged `data_collector` with `id: eca`,
  `label: ECA`, `template: '@eca_webprofiler/Collector/eca.html.twig'`, `priority: 12`. Constructor
  arg: `@logger.channel.eca`.
- Service `eca_webprofiler.configurable_logger_channel` = `src/ConfigurableLoggerChannel.php`
  (extends core `LoggerChannel`), **decorates** `logger.channel.eca`. Args: channel name `eca`, the
  inner channel, `@config.factory`.
- Templates: `templates/Collector/eca.html.twig` (toolbar item + panel) and
  `templates/Icon/logo.svg`.

## Mechanism (one line each)

- `ConfigurableLoggerChannel::log()` only records when Webprofiler's `eca` toolbar item is active
  (`webprofilerEnabled()` reads `webprofiler.config`/`webprofiler.settings` `active_toolbar_items`);
  it captures the message plus recursively expanded ECA token data via `getTokenInfo()`.
- `EcaDataCollector::collect()` pulls `getDataCurrentRequest()`, strip_tags-cleans each token line,
  and stores `{message, tokens}` rows; `getPanel()` renders them as a "Debugging" table;
  `getNumberOfLogEntries()` feeds the toolbar count.

Everything is reachable only through Webprofiler's own permission-gated profiler UI. **Dev/staging
only** — Webprofiler adds overhead and exposes internals; not for production.
