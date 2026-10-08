<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA data collector & logger channel

How `eca_webprofiler` captures ECA activity and shows it in Webprofiler. Source:
`eca_webprofiler.services.yml`, `src/ConfigurableLoggerChannel.php`,
`src/DataCollector/EcaDataCollector.php`, `templates/Collector/eca.html.twig`.

## Install / enable

`composer require drupal/eca_webprofiler` then `drush en eca_webprofiler`. It requires `eca`
(`^2 || ^3`) and `webprofiler` (`^10.1 || ^11`). No configuration form ships with this module; you
turn its output on/off from **Webprofiler's** settings by enabling the **`eca`** toolbar item (see
"Enabling capture" below). Capture and display only happen when Webprofiler itself is active for the
request, which is a developer/staging setup gated by Webprofiler's own access control.

## Services (`eca_webprofiler.services.yml`)

- `webprofiler.eca` → `Drupal\eca_webprofiler\DataCollector\EcaDataCollector`, arg
  `@logger.channel.eca`. Tag: `data_collector` `{ id: eca, label: ECA, title: ECA, priority: 12,
  template: '@eca_webprofiler/Collector/eca.html.twig' }`.
- `eca_webprofiler.configurable_logger_channel` →
  `Drupal\eca_webprofiler\ConfigurableLoggerChannel`, `decorates: logger.channel.eca`, args
  `['eca', '@eca.configurable_logger_channel.inner', '@config.factory']`. Because it decorates the
  ECA logger channel, everything ECA logs flows through it.

## ConfigurableLoggerChannel (the capture side)

Extends core `LoggerChannel`. Key members:

- `webprofilerEnabled(): bool` — computed once per request. Reads
  `webprofiler.config` then `webprofiler.settings` `active_toolbar_items` and returns whether the
  `eca` item is enabled. If not, capture is skipped entirely.
- `log($level, $message, array $context)` — the override. Returns immediately when
  `webprofilerEnabled()` is FALSE or when a re-entrancy guard `$alreadyLogging` is set (prevents
  recursion). Otherwise it:
  - builds a `FormattableMarkup` of the message + context;
  - fetches ECA token data via the lazily resolved `eca.service.token` service
    (`token()` — deliberately **not** constructor-injected to avoid a circular reference), and
    explicitly adds the ambiguous token names `entity`, `user`, `event`, `form` when present;
  - calls `getTokenInfo()` to recursively describe every token/data value;
  - appends the formatted token lines to the message and records
    `[$level, $fullMessage, $tokens, $context]` into `$dataCurrentRequest`.
- `getTokenInfo(&$context, &$tokens, $data, $prefix, $level)` — recursion that, per value, emits a
  line `- <key> (%<prefix>_<key>)` and a type description: `EntityInterface` →
  `Entity <type>[/<bundle>]/<id>/<label>`; `DataTransferObject` → `DTO` plus its recursively
  expanded properties (or `DTO - properties not available` on `MissingDataException`); scalars →
  `<type> "<value>"`; `PrimitiveInterface`/`TypedDataInterface` → value/data-type; `NULL` → `NULL`;
  else the class name.
- `getDataCurrentRequest(): array` — accessor the collector reads.
- `setRequestStack()`, `setCurrentUser()`, `setLoggers()`, `addLogger()` simply forward to the inner
  decorated channel.

## EcaDataCollector (the display side)

Extends Symfony `DataCollector`, implements `HasPanelInterface`, uses Webprofiler's
`DataCollectorTrait`/`PanelTrait`. `getName()` returns `'eca'`.

- `collect(Request, Response, ?Throwable)` — iterates `logger->getDataCurrentRequest()`; for each
  entry runs every token line through `strip_tags((string) new FormattableMarkup($value, $context))`
  and stores a row `['message' => <fullMessage>, 'tokens' => implode('<br>', <lines>)]` into
  `$this->data`.
- `getNumberOfLogEntries(): string` — `count($this->data)`; drives the toolbar's "Log entries"
  number.
- `getPanel(): array` — returns `No debugging data available.` when empty, else a
  `webprofiler_dashboard_section` "Debugging" table with header `Step | Tokens`; each row is the
  step message (`webprofiler__key`) and the tokens rendered via an `inline_template` `{{ data|raw }}`
  (the values were already `strip_tags`-cleaned at collect time).

## Templates

`templates/Collector/eca.html.twig` defines `{% block toolbar %}` (the logo icon +
`collector.numberoflogentries` "Log entries" and a "Token" piece, status always `green`) and
`{% block panel %}` which calls `collector.panel()`. `templates/Icon/logo.svg` is the toolbar icon.

## Enabling capture / reading it

1. Enable Webprofiler and its toolbar for the environment.
2. In Webprofiler settings, enable the **`eca`** toolbar item (this is what `webprofilerEnabled()`
   checks) so ECA logging is captured.
3. Browse the site to trigger ECA models. The Webprofiler toolbar shows the "ECA" item with the log
   entry count; open the request's profile and the **ECA** panel to read the "Debugging" table of
   steps and their token values.

Nothing here is exposed on its own route or permission — it is available only inside Webprofiler's
gated profiler pages, so keep it to development/staging.
