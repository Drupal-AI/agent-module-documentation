<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX Placeholder (ajax_placeholder) — agent index

Render-element building block: place `#type => ajax_placeholder` with a `#callback` in any render array; the initial render emits only a small placeholder, then a JS behaviour fetches the real content from `/ajax/placeholder/{hash}` and swaps it in. Improves cacheability and perceived performance; unlike BigPipe the fragments load asynchronously in parallel. Version **1.0.2**, core `^10 || ^11`. No config, no dependencies, no permissions of its own.

## What it provides
- **Render element** `ajax_placeholder` — `src/Element/AjaxPlaceholder.php` (`@RenderElement`). `#callback` (required, `[target, args]`), `#markup` (optional loading text). `preRender()` stores `{url, callback}` in shared tempstore keyed by `md5(Json::encode(#callback))` and emits a `container` with class `js-ajax-placeholder` + `data-hash`, attaching `ajax_placeholder/ajax`.
- **Service** `ajax_placeholder.callback` → `Drupal\ajax_placeholder\AjaxPlaceholderBuilder` (args `@tempstore.shared`, `@controller_resolver`, `@current_user`).
- **Route** `ajax_placeholder.ajax` — `/ajax/placeholder/{hash}` → `ajax_placeholder.callback:ajaxCallback`, requirement `_permission: 'access content'`.
- **Library** `ajax_placeholder/ajax` — `js/ajax-placeholder.js` (deps `core/drupal.ajax`, `core/once`).

## How the callback resolves
`AjaxPlaceholderBuilder::ajaxCallback($hash)`: reads the tempstore entry; if empty → empty `AjaxResponse`. Re-checks access via `Url::fromUserInput($data['url'])->access()`. Resolves the callback string (`::` → `[class, method]`; no `::` → `controllerResolver->getControllerFromDefinition()`), then runs it through `DoTrustedCallbackTrait::doTrustedCallback()` and returns a `ReplaceCommand` targeting `[data-hash="…"]`.

## Solution docs
- [Render element + AJAX callback API](api/render-element.md) — how to place a placeholder, the `#callback` contract, tempstore flow, and the callback resolution/access model.
