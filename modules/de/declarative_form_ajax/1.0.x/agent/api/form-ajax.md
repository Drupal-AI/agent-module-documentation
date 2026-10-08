<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declarative form AJAX API

Base module `declarative_form_ajax`. No install-time config, permissions, services, routes, or schema —
it is a code-only Form API helper. Enable it (`drush en declarative_form_ajax`) and use the API from your
own form's `buildForm()`.

## Declarative syntax

On a **dependent** element, declare which element(s) control it via `#ajax => ['updated_by' => [...]]`,
where each entry is the `#array_parents` address of a controlling element:

```php
$form['controlling_element'] = ['#type' => 'checkbox', '#title' => 'Click me'];

$form['my_container'] = [
  '#type' => 'container',
  '#ajax' => ['updated_by' => [['controlling_element']]],
];

// Enable everything with one form-level after_build callback.
$form['#after_build'][] = \Drupal\declarative_form_ajax\FormAjax::class . '::ajaxAfterBuild';
```

A dependent element can list several controllers, and several elements can share one controller. The
controlling element needs no `#ajax` of its own — the after-build promotes it.

## `FormAjax::ajaxAfterBuild($form, $form_state)`

File `src/FormAjax.php`. Runs as `#after_build`. Uses `Element::walkChildrenRecursive()` to find every
element with `#ajax['updated_by']`, collects the referenced controller addresses, then for each controller
element (looked up with `NestedArray::getValue`):

- If the element was processed for AJAX but had no settings (`#ajax_processed === FALSE`), it sets
  `#ajax['callback'] = FormAjax::ajaxCallback`, unsets `#ajax_processed`, and re-runs
  `RenderElement::processAjaxForm()` so it becomes a real trigger.
- If the element already had its own AJAX callback (`#ajax_processed === TRUE`), it preserves the original
  under `#ajax['prior_callback']` and installs `FormAjax::ajaxCallback` as the callback.
- During an actual AJAX request it re-applies the callback to `$form_state->getTriggeringElement()` too,
  because the triggering element is captured before `#after_build` runs.
- For an element that only declares itself as a dependency (has exactly `#ajax` = `updated_by` + `event`),
  it strips the injected `event`/`drupalSettings.ajax` so a click on it does not fire a pointless request.

## `FormAjax::ajaxCallback(&$form, $form_state, $request)`

The wired callback, returns an `AjaxResponse`. Steps:

1. If the triggering element had a `prior_callback`, it prepares and calls it on a copy of `$form`; if that
   returned an `AjaxResponse` it is used, otherwise the render array is turned into a response via the
   `main_content_renderer.ajax` service. The declarative updates are then appended to that response.
2. It walks the whole form and collects every element whose `#ajax['updated_by']` matches the triggering
   element's `#array_parents`.
3. Each collected element is rendered with `renderer::renderRoot()` (stripping `#group` first so grouped
   members render), its `#attached` re-added, and an `InsertCommand` targets it by `data-drupal-selector`:
   `details`/`container` match the wrapper directly; other elements use
   `div.form-item:has(*[data-drupal-selector="…"])` (note: the `:has()` selector may not work on all themes).
4. A `status_messages` render is prepended next to the triggering element with `PrependCommand`.

All addresses and elements come from the server-built form; the callback re-renders only what the form
defined and runs within the normal authenticated form-rebuild flow.

## `Element::walkChildrenRecursive(&$element, callable $callback)`

File `src/Element.php`. Applies `$callback` to `$element` then recurses over `RenderElement::children()`.
Used internally, and reusable for any "visit a form element and all descendants" task. The class docblock
notes it is intended to be merged into core's `Element`.
