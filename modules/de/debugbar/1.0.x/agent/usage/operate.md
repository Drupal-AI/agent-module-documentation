<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install and operate Debug Bar

## Install
1. Require with Composer so the library is pulled in: `composer require drupal/debugbar` (installs `maximebf/debugbar:^1.16`).
2. Ensure the `vendor_stream_wrapper` module is present (it is a hard dependency in `debugbar.info.yml`) — Composer/Drupal will require it.
3. Enable: `drush en debugbar` (add `drush en debugbar_twig` for the Twig profiler pane).

There is no settings form and no configuration (`configure` is null; README: "There is no configuration"). Enabling the module immediately starts rendering the bar on HTML page responses.

## How rendering works
- `debugbar_page_top()` (`debugbar.module`) pulls `getAssets('inline_head')` from the library's JS renderer and prints each as `#markup`.
- `debugbar_page_bottom()` adds a `#lazy_builder` pointing at `LazyBuilder::renderDebugBar` (with `#create_placeholder = TRUE`) and attaches the `debugbar/debugbar` library.
- `debugbar_library_info_build()` builds the `debugbar` asset library dynamically: local `js/debugbar.js` plus every JS/CSS asset the library reports, referenced through `vendor://maximebf/debugbar/src/DebugBar/Resources/...` (external type). Library deps: `core/drupal`, `core/jquery`.
- `LazyBuilder::renderDebugBar()` calls `debugbar.debugbar` service `->getJavascriptRenderer()->render()` and returns it as `Markup`. `LazyBuilder` implements `TrustedCallbackInterface` (declares `renderDebugBar` in `trustedCallbacks()`).

## Event handling — `KernelEventSubscriber`
Subscribes to `KernelEvents::EXCEPTION` and `KernelEvents::RESPONSE`:
- `onException()` adds the thrown error to the `exceptions` collector.
- `onResponse()`:
  - For `XmlHttpRequest` (AJAX) responses: adds debug data as headers via `getDataAsHeaders('phpdebugbar', 4096, 128000)`.
  - For redirect responses: calls `stackData()` so collected data carries to the next page — except when the current route is `vendor_stream_wrapper.vendor_file_download` or `debugbar.fonts` (avoids polluting collectors with asset responses).

## Var dumper
`DrupalDebugBar` sets `DataCollector::setDefaultVarDumper(new VarDumper())`. `VarDumper` returns a `NonPrefixedHtmlDumper` (extends `DebugBarHtmlDumper`) whose `getDumpHeaderByDebugBar()` returns the un-prefixed dump header, so it does not conflict with the Devel/Symfony var dumper CSS. HTML var dumping is enabled on all collectors only for non-AJAX requests (AJAX would make headers too large).

## Operational notes
- The bar renders on rendered HTML pages; AJAX debug data travels in response headers (auto-show is off — `setAjaxHandlerAutoShow(FALSE)`).
- Vendored jQuery is disabled (`disableVendor('jquery')`) because Drupal already provides jQuery.
- To turn it off, uninstall the module (`drush pmu debugbar`). This is a development aid; the project advises against production use.
