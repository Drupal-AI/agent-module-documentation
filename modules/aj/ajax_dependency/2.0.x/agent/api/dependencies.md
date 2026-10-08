<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wiring AJAX field dependencies

Enable: `drush en ajax_dependency`. No config, no permissions, no routes — it is a code-only Form API helper.
All work happens in a form build (or `hook_form_alter`) by calling static methods on
`Drupal\ajax_dependency\AjaxDependency` (`src/AjaxDependency.php`).

## The three API methods

```php
use Drupal\ajax_dependency\AjaxDependency;

// $source and $target are references to Form API render arrays (elements).
AjaxDependency::dependsOn($source, $target, $formState);
AjaxDependency::accessIf($condition, $source, $target, $formState);
AjaxDependency::contentIf($condition, $source, $target, $formState);
```

- `dependsOn(&$source, &$target, $fs)` — registers `$target` to be re-rendered via AJAX whenever `$source`
  changes. Delegates to `AjaxDependencyWorker::setDependency()`.
- `accessIf($condition, &$source, &$target, $fs)` — sets `$target['#access'] = (bool) $condition`, then calls
  `dependsOn`. Use to show/hide the target based on a computed condition.
- `contentIf($condition, &$source, &$target, $fs)` — if `!$condition`, sets `$target['#value'] = NULL`
  (blanks the value so a hidden required field doesn't retain stale input), then calls `accessIf`. This is the
  method most examples use.

Pass elements **by reference** (`&$form['field_x']`) — the methods mutate them in place. `$condition` is any
truthy/falsy value you compute from the source's current selection.

## How you evaluate the condition (important)

During an AJAX rebuild the form usually has **not** been validated, so `FormStateInterface::getValue()` is
often empty. The shipped example reads raw input instead:

```php
$selectorInput = $form_state->getUserInput()['selector'] ?? NULL;
AjaxDependency::contentIf($selectorInput['one'] ?? NULL, $form['selector'], $form['variant_one'], $form_state);
```

(See `ajax_dependency_example/src/AjaxDependencyExampleForm.php`.) Raw input is used only to **toggle which
widgets render**; the actual submitted values are still validated/handled by Form API normally. The
`ajax_dependency.example.php` file in the project root shows the same pattern inside
`hook_form_BASE_FORM_ID_alter()` on a node form, using `buildEntity()` + field values to compute the condition.

## What the worker does (`AjaxDependencyWorker`, `src/AjaxDependencyWorker.php`)

`setDependency(&$source, &$target, $fs)`:
1. Appends `$target` by reference to `$source['#ajax_dependency_target_refs']` (a source may control many targets).
2. `ComposableAjax::addAjaxResponseProcessor($source, [Worker::class, 'processAjax'])` — hooks the dependency's
   response builder onto the source's `#ajax` callback (composing with any existing callback; see
   `api/composable-ajax.md`).
3. `addNojsSubmitElement()` — injects a hidden submit button (`ajax_dependency_nojs_submit`, class `js-hide`,
   `formnovalidate`, random `#parents` key via `Crypt::randomBytesBase64(8)`) so non-JS clients can trigger a
   rebuild. Its own `#validate` (`nojsValidate` → `clearErrors()`) and `#submit` (`nojsSubmit` → `setRebuild()`)
   make the fallback safe against required-field errors. The `#after_build` `afterBuildForSource` →
   `moveNojsSubmitElement()` relocates the button to sit right after the source in the real form tree.

Target side, `#after_build` `afterBuildForTarget`:
- `addSelector()` — computes a stable selector `uniqueFormId . '-' . implode('-', #array_parents)` and wraps the
  element in `<div data-drupal-ajax-dependency-selector="…">`, storing it in `#ajax_dependency_selector`.
- `replaceWithMockIfNoAccess()` — see access handling below.

On change, `processAjax()` / `updateForm()` walk from the triggering element up to the source that carries
`#ajax_dependency_target_refs`, then for each target add a `ReplaceCommand` targeting that selector div with the
freshly built target element (clearing `#attached` and `#group`). Result: only the dependent element(s) refresh.

## Access handling

`replaceWithMockIfNoAccess()` calls `FormTool::checkAccess()` on the target. If access is **denied**, it sets
`#access = TRUE` (so the element still has a DOM slot to replace) but adds a `#pre_render`
(`replaceTargetElementWithMockInPreRender`) that swaps the element for an **empty** mock div
(`<div data-drupal-ajax-dependency-selector="…">&nbsp;</div>`) — preserving only render-grouping/`#printed`
keys. So a target the user is not permitted to see never renders its real content; the dependency only ever
reveals content the target's own `#access` already allows. Cacheability from `AccessResultInterface` is merged
via `FormTool::addCacheableDependency()`.

## Trusted callbacks

`AjaxDependencyWorker::trustedCallbacks()` whitelists `afterBuildForSource`, `afterBuildForTarget`,
`replaceTargetElementWithMockInPreRender` per core's `TrustedCallbackInterface`, so the render pipeline accepts
these `#after_build`/`#pre_render` callbacks.
