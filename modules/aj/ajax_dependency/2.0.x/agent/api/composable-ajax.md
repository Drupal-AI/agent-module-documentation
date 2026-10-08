<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ComposableAjax and FormTool internals

Two helper classes support the dependency engine. You rarely call them directly, but they explain the wiring.

## ComposableAjax (`src/ComposableAjax.php`, `final`)

Lets multiple AJAX-response processors coexist on a single element's `#ajax` callback, so the dependency's
refresh logic composes with any existing AJAX callback the element already had.

- `ComposableAjax::addAjaxResponseProcessor(array &$element, callable $processor): void` — static entry point.
  If `$element['#ajax']['callback']` is already a `[ComposableAjax, 'ajaxSubmit']` pair, it reuses that wrapper;
  otherwise it wraps the element's existing callback (or none) in a new `ComposableAjax`. It then appends
  `$processor` and rewrites `$element['#ajax']['callback'] = [$composableAjax, 'ajaxSubmit']`.
- Immutable, private constructor + `create()` / `withProcessor()` — each `withProcessor()` returns a new instance
  with the processor appended (functional/decorator style). Holds a `$callback` (the original element callback)
  and an ordered list of `$processors`.
- `ajaxSubmit(array $form, FormStateInterface $fs): AjaxResponse` — the actual `#ajax` callback. It runs the
  original `$callback` (if any): an `AjaxResponse` is used as-is; an array is rendered through
  `main_content_renderer.ajax` (`renderResponse()` with `\Drupal::request()` / `\Drupal::routeMatch()`), first
  unsetting `#group`. With no original callback it starts an empty `AjaxResponse`. Then every registered
  processor is invoked as `$processor($response, $form, $formState)` to add its commands. Returns the response.

The dependency registers `AjaxDependencyWorker::processAjax` as one such processor; that processor appends the
`ReplaceCommand`s for each target element (see `api/dependencies.md`).

## FormTool (`src/FormTool.php`, static utilities)

- `checkAccess(&$elements)` — mirrors core `Renderer::doRender` access logic: resolves an `#access_callback`
  (via `controller_resolver` when it's a non-`::` string) if `#access` is unset, converts an
  `AccessResultInterface` to bool (merging its cacheable metadata via `addCacheableDependency`), and returns the
  resulting `#access` (or NULL). Used by the worker to decide whether a target must be mocked out.
- `addCacheableDependency(array &$elements, $dependency)` — merges cacheable metadata from `$dependency` into the
  render array.
- `insertAfter(array &$array, $key, array $insert)` — splices `$insert` into `$array` right after `$key`
  (appends if the key is absent). Used to place the no-JS submit button directly after its source element.
- `uniqueFormId(FormStateInterface $fs)` — returns the complete form's `#form_id`.
- `uniqueElementId($path, FormStateInterface $fs)` — `uniqueFormId . '-' . implode('-', $path)`; builds the stable
  per-target selector from the element's `#array_parents` (a stopgap until core issue 1852090 lands, per the code's
  own `@todo`).
- `addUnique(&$array, $value)` — initializes `$array` to `[]` if unset and appends `$value` only if not already
  present; used to attach `#after_build` / `#pre_render` callbacks idempotently.
