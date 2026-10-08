<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug Bar (debugbar) — agent index

On-page debug bar for the current request, wrapping the `maximebf/debugbar` PHP library. Version dir `1.0.x` (installed as `dev-1.x`, git-describe `1.0.0-alpha4`). Core `^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Development-only tool — maintainers advise not enabling it in production.

## What it is
Renders the PHP Debug Bar at page bottom via `hook_page_bottom()` and injects its inline head assets via `hook_page_top()` (`debugbar.module`). Collectors gather PHP info, memory, Drupal log messages, request data, all site settings, route name/params, and exceptions.

## Dependencies
- Drupal module: `vendor_stream_wrapper` (serves the library's `vendor/`-bundled JS/CSS/fonts).
- Composer: `maximebf/debugbar:^1.16`.
- No config schema, no permissions file, no Drush commands, no plugin types, no settings route.

## Services (`debugbar.services.yml`)
- `debugbar.debugbar` → `Drupal\debugbar\DrupalDebugBar` (extends `DebugBar\DebugBar`; registers the collectors, disables vendored jQuery, disables AJAX auto-show).
- `debugbar.kernel_subscriber` → `Drupal\debugbar\EventSubscriber\KernelEventSubscriber` (EXCEPTION + RESPONSE events).
- `debugbar.logger` → `Drupal\debugbar\DebugBarLogger` (a `logger` channel; `MessagesCollector` that maps RFC-5424 to PSR-3 levels).

## Routes (`debugbar.routing.yml`)
- `debugbar.fonts` — `/fonts/{filename}` → `FontsController::getFont` — redirects to the library's Font Awesome font via `vendor_stream_wrapper_create_url()`. Requirement `_permission: 'access content'`.

## Other classes
- `LazyBuilder` — `TrustedCallbackInterface`; `renderDebugBar()` lazy-builder renders the bar markup.
- `VarDumper` / `NonPrefixedHtmlDumper` — Symfony var-dumper integration without prefixed CSS selectors (devel compatibility).

## Submodule
- `debugbar_twig` — decorates `debugbar.debugbar` with `TwigDebugBar` to add a Twig profiler pane. Documented at `../../modules/debugbar_twig/1.0.x/`.

## Solution docs
- Install / operate: `usage/operate.md`
- Services & collectors API: `api/services.md`
- Fonts route & assets: `api/fonts-and-assets.md`
