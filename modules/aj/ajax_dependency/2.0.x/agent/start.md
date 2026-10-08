<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Dependency (ajax_dependency) — agent index

Developer helper for the Drupal Form API: make one form element's rendering (access, value, properties)
depend on another element's value, refreshed **server-side over AJAX** (not client-side `#states`). The
dependent (target) element is re-rendered on each source change and its `#access` is re-evaluated. No admin
UI, no routes, no permissions, no config in the main module — all wiring is code.

- **Machine name:** `ajax_dependency` · **Version:** 2.0.1 (2.0.x) · **Core:** `^9 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies:** none (main module). PHP/Composer: none.
- **Submodule:** `ajax_dependency_example` (demo form at `/ajax-dependency-example-form`) — [nested docs](../modules/ajax_dependency_example/2.0.x/agent/start.md).

## Public API (all static, class `Drupal\ajax_dependency\AjaxDependency`)
- `dependsOn(&$source, &$target, FormStateInterface $fs)` — refresh `$target` via AJAX when `$source` changes.
- `accessIf($condition, &$source, &$target, $fs)` — set `$target['#access'] = (bool) $condition`, then `dependsOn`.
- `contentIf($condition, &$source, &$target, $fs)` — if `!$condition` blank `$target['#value']`, then `accessIf`.

Call these from `buildForm()` or `hook_form_alter()`; the form must rebuild (AJAX / `setRebuild()`) for updates.

## Classes / building blocks (in `src/`)
- `AjaxDependency` — thin static facade over the worker (above).
- `AjaxDependencyWorker` (`implements TrustedCallbackInterface`) — the engine: marks source/target, injects a
  no-JS submit button, adds `#after_build`/`#pre_render` callbacks, wraps a target selector div, and emits
  `ReplaceCommand`s in `updateForm()` / `processAjax()`. A no-access target is replaced with an empty mock div.
- `ComposableAjax` (`final`) — composes multiple AJAX response processors on one element's `#ajax` callback
  so the dependency can coexist with an element's existing AJAX callback.
- `FormTool` — static utilities: `checkAccess()`, `insertAfter()`, `uniqueFormId()`, `uniqueElementId()`, `addUnique()`.

## Solution docs
- [agent/api/dependencies.md](api/dependencies.md) — the `AjaxDependency` API, how the worker wires it, no-JS fallback, access handling.
- [agent/api/composable-ajax.md](api/composable-ajax.md) — `ComposableAjax` and `FormTool` internals.
- Example submodule: [nested tree](../modules/ajax_dependency_example/2.0.x/agent/start.md).
