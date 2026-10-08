<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ajax_wrapper` render element

`src/Element/AjaxWrapperElement.php` — `@RenderElement("ajax_wrapper")`, extends
`Drupal\Core\Render\Element\RenderElementBase`. This is the only public API of the module.

## Install / enable

`composer require drupal/ajax_wrapper` then `drush en ajax_wrapper`. No config, no permissions to grant.
Any code that builds render arrays can now use `#type => 'ajax_wrapper'`.

## Default properties (`getInfo()`)

| Property | Default | Meaning |
|---|---|---|
| `#type` | `ajax_wrapper` | — |
| `#id` | `ajax-wrapper` | DOM id of the wrapping `<div>`; used as the AJAX target selector. **Override it** if a page has more than one wrapper. |
| `#theme` | `ajax_wrapper` | template `templates/ajax-wrapper.html.twig` (a `<div {{ attributes }}>{{ content }}</div>`). |
| `#pre_render` | `AjaxWrapperElement::preRenderAjaxWrapper` | builds content + attaches settings. |
| `#ajax_wrapper_classes` | `['ajax-wrapper-classes']` | CSS classes; the JS looks *inside* these for `<a>`/`<form>` to bind. |
| `#ajax_wrapper_attributes` | `[]` | extra HTML attributes on the wrapper div. |
| `#ajax_callback` | `[]` | **required** — see below. |
| `#attached[library]` | `ajax_wrapper/ajax_wrapper` | the behaviour JS. |

Optional properties read by `preRenderAjaxWrapper()`: `#ajax_wrapper_content` (skip the callback and
supply pre-built content), `#ajax_url` (defaults to `Url::fromRoute('ajax_wrapper.refresh')`),
`#ajax_method` (DOM update method, default `html`).

## `#ajax_callback` shape

`#ajax_callback` is an array of `[callable, argumentsArray]` pairs; only the **first** is used
(`reset()`), split into `$callbackFunction = $callback[0]` and `$callbackArguments = $callback[1] ?? []`:

```php
$build['list'] = [
  '#type' => 'ajax_wrapper',
  '#id' => 'my-overview',
  '#ajax_wrapper_classes' => ['my-overview-inner'],
  '#ajax_callback' => [
    ['\Drupal\my_module\MyBuilder::buildList', [$some_scalar_arg]],
  ],
];
```

The callback must return a render array. It is invoked through `AjaxWrapperCallbackUtility::doCallback()`,
which runs it via core's `DoTrustedCallbackTrait` — so **the callback method must be a trusted callback**:
either a static method annotated `#[TrustedCallback]` / declared in a `TrustedCallbackInterface::trustedCallbacks()`
list, or a service method reachable via the container. A plain global function name or a non-trusted
method is rejected (`\Error`/`\Exception`). Arguments should be **scalars** (they are serialized into
`drupalSettings` and round-tripped back to the server on refresh — see
[../routes/refresh.md](../routes/refresh.md)).

## What `preRenderAjaxWrapper()` does (source)

1. Throws `\Exception('You must specify an ajax callback')` if `#ajax_callback` is empty.
2. If `#ajax_wrapper_content` is empty, calls `\Drupal::service('ajax_wrapper.utility.callback')->doCallback($callbackFunction, $callbackArguments)` and stores the result in `#ajax_wrapper_content`.
3. Defaults `#ajax_url` to the `ajax_wrapper.refresh` route.
4. Sets `#ajax_wrapper_attributes['id'] = #id`.
5. Appends to `#attached['drupalSettings']['ajax_wrapper_settings'][]` a record with
   `wrapper_id`, `wrapper_classes`, `method`, `ajax_url`, and `callback => {function, arguments}`.

That last `callback` record is what the browser sends back to the refresh route on each interaction.

## Behaviour JS (`js/ajax_wrapper.js`)

`Drupal.behaviors.ajaxWrapper` reads `drupalSettings.ajax_wrapper_settings`. For each wrapper it finds
`<a>` (binds `click` → `refreshWrapperByUrl(href)`) and `<form>` (binds `submit` →
`refreshBlockByFormSubmit`) *inside* the `wrapper_classes`, using `core/once`. Each interaction calls
`Drupal.ajax({url: ajax_url, method: 'POST', submit: data})` where `data` carries `url`, optional
`form_data` (the serialized form), `current_path`, and the full `ajax_wrapper_settings` (incl. the
callback). On completion it re-runs `Drupal.attachBehaviors()`. `history.js` implements the
`storeHistory` AJAX command (pushes state) and a `popstate` handler restores prior wrapper HTML.
