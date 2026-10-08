<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug Bar Twig (debugbar_twig) — agent index

Submodule of Debug Bar that adds a Twig template profiler pane. Version dir `1.0.x`. Core `^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Development-only, like its parent.

## What it is
Decorates the parent `debugbar.debugbar` service and registers a Twig profiler so the debug bar gains a pane listing rendered Twig templates with counts and timing.

## Dependencies
- Drupal module: `debugbar` (parent). Transitively `vendor_stream_wrapper` + `maximebf/debugbar`.
- No config, no routes, no permissions, no schema of its own.

## Services (`debugbar_twig.services.yml`)
- `debugbar.debugbar_twig` → `Drupal\debugbar_twig\TwigDebugBar`, `decorates: debugbar.debugbar`. Args: `@debugbar.logger`, `@current_route_match`, `@request_stack`, `@debugbar.twig_profile`. `__construct()` calls the parent `DrupalDebugBar` constructor then `addCollector(new NamespacedTwigProfileCollector($profile))`.
- `debugbar.twig_profiler` → `Twig\Extension\ProfilerExtension` (tagged `twig.extension`), arg `@debugbar.twig_profile`.
- `debugbar.twig_profile` → `Twig\Profiler\Profile` (the shared profile object both services reference).

## How it works
The `ProfilerExtension` records rendering into the shared `Profile`; the decorated bar service adds a `NamespacedTwigProfileCollector` built from that same `Profile`, so the collected data appears as a pane in the bar rendered by the parent module.

## Related
Parent module docs: `../../../1.0.x/agent/start.md`.
