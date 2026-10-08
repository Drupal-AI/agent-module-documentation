<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, collectors and the debug bar API

Defined in `debugbar.services.yml`.

## `debugbar.debugbar` — `Drupal\debugbar\DrupalDebugBar`
Extends `DebugBar\DebugBar`. Constructor args: `@debugbar.logger`, `@current_route_match`, `@request_stack`.

On construction it:
- Sets the default var dumper to `Drupal\debugbar\VarDumper`.
- Registers collectors in order: `PhpInfoCollector`, `MemoryCollector`, the injected logger (`DebugBarLogger`, a `MessagesCollector`), `RequestDataCollector`, a `ConfigCollector` seeded with `Settings::getAll()`, a `ConfigCollector` named `route` holding `{name: routeName, parameters: routeParams}`, and `ExceptionsCollector`.
- For non-AJAX requests, calls `useHtmlVarDumper()` on every collector that supports it.
- Disables AJAX auto-show (`setAjaxHandlerAutoShow(FALSE)`) and disables the library's bundled jQuery (`disableVendor('jquery')`).

Retrieve a collector elsewhere via `$this->debugBar->getCollector('exceptions')` (see the event subscriber).

## `debugbar.logger` — `Drupal\debugbar\DebugBarLogger`
Tagged `logger`, so Drupal's logger factory routes all channel messages here. Extends `DebugBar\DataCollector\MessagesCollector`. Constructor arg: `@logger.log_message_parser`.

`log($level, $message, $context)` translates Drupal's RFC-5424 integer levels to PSR-3 string levels (`$levelTranslation` map mirroring `LoggerChannel::$levelTranslation`), then substitutes Drupal-style placeholders using `LogMessageParserInterface::parseMessagePlaceholders()` before calling the parent collector (the library expects PSR-3 placeholders, Drupal does not use them). Reference: drupal.org issue 3062351.

## `debugbar.kernel_subscriber` — `Drupal\debugbar\EventSubscriber\KernelEventSubscriber`
Tagged `event_subscriber`. Args: `@debugbar.debugbar`, `@current_route_match`.
- `KernelEvents::EXCEPTION` → `onException()`: `$this->debugBar->getCollector('exceptions')->addThrowable($event->getThrowable())`.
- `KernelEvents::RESPONSE` → `onResponse()`: AJAX responses get `getDataAsHeaders('phpdebugbar', 4096, 128000)`; redirect responses call `stackData()` unless the route is `vendor_stream_wrapper.vendor_file_download` or `debugbar.fonts`.

## Var-dumper classes
- `Drupal\debugbar\VarDumper` extends `DebugBar\DataFormatter\DebugBarVarDumper`; `getDumper()` returns a `NonPrefixedHtmlDumper` (applying any configured `styles`).
- `Drupal\debugbar\NonPrefixedHtmlDumper` extends `DebugBar\DataFormatter\VarDumper\DebugBarHtmlDumper`; overrides `getDumpHeaderByDebugBar()` to return `getDumpHeader()` (no CSS-selector prefixing), preventing a clash with the Devel var dumper.

## Extending the bar
Decorate `debugbar.debugbar` to add collectors — this is exactly what the `debugbar_twig` submodule does (`decorates: debugbar.debugbar`, adds a `NamespacedTwigProfileCollector`). See `../../../modules/debugbar_twig/1.0.x/agent/start.md`.
