<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Demo forms and custom element

Submodule `declarative_form_ajax_demo`. Enable it plus the base module, then visit the routes. Both routes
use `_access: 'TRUE'` because they are throwaway demo forms with empty validate/submit handlers and no
state change. Reference code — do not enable on production.

## `DeclarativeAjaxDemoForm` — `/demo/declarative-ajax-form`

File `src/Form/DeclarativeAjaxDemoForm.php`. A `clickme` checkbox controls several dependents, each
declaring `#ajax => ['updated_by' => [['clickme']]]`:

- `replace-container` (`container`) with two inner textfields.
- `replace-details` (`details`, `#open`) with two inner textfields.
- `replace-textfield` (standalone `textfield`).
- `replace-checkbox` (standalone `checkbox`).

A `fixed` `#markup` element has no `updated_by` and never changes. The form enables everything with
`$form['#after_build'][] = FormAjax::class . '::ajaxAfterBuild';`. Element titles embed `time()` so a
re-render is visible when the checkbox toggles.

## `DeclarativeAjaxElementDemoForm` — `/demo/declarative-ajax-element-form`

File `src/Form/DeclarativeAjaxElementDemoForm.php`. Same structure, but the controller is
`clickme` of type `declarative_form_ajax_demo_select`, a custom render element that builds a nested
`container.select`. Dependents therefore address the controller deep:
`#ajax => ['updated_by' => [['clickme', 'container', 'select']]]`. This demonstrates the base module wiring
declarative updates on top of an element that already has its own AJAX callback.

## `TestSelect` render element — `declarative_form_ajax_demo_select`

File `src/Element/TestSelect.php`, `@RenderElement("declarative_form_ajax_demo_select")`. Its
`processPlugin()` sets `#tree`, wraps a `details` (`container`) with a `select` (options red/blue/green)
and a textfield (`update`). The select carries its own `#ajax`: `callback` = `TestSelect::pluginDropdownCallback`,
`wrapper` = a unique `Html::getUniqueId('select-ajax')` id, and passes `element_parents` (the element's
`#array_parents`, imploded) as a query parameter so the callback can locate the element.

`pluginDropdownCallback()` reads `element_parents` from the request, filters it with
`array_filter($form_parents, [Element::class, 'child'])` before using it, then returns
`NestedArray::getValue($form, $form_parents)` — i.e. it re-renders a subtree of the server-built form,
selected by validated parent keys. It renders no request-supplied markup or element definitions.
