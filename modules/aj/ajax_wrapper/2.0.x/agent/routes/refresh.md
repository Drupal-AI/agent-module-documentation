<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Refresh route, controller & callback utility

## Route (`ajax_wrapper.routing.yml`)

```
ajax_wrapper.refresh:
  path: '/ajax-wrapper/refresh'
  defaults:
    _controller: '\Drupal\ajax_wrapper\Controller\AjaxWrapperController::refresh'
  methods: [GET, POST]
  requirements:
    _permission: 'access content'
    _format: 'html'
```

The only route. The JS always calls it with `method: 'POST'`. `_permission: 'access content'` is the
gate (that permission is granted to anonymous by default on a standard site).

## Controller (`src/Controller/AjaxWrapperController.php`)

Constructed with `ajax_wrapper.utility.callback`, `request_stack`, and `router.no_access_checks`
(see `create()`). `refresh()`:

1. `$this->data = $request->request->all()` — reads the entire POST body.
2. If `form_data` is present, `parse_str()`s it into a new `FormState` (`setValues()`), stored as
   `$this->formState`.
3. `buildAndPushRequest()` — takes `data['url']`, `parse_url()`s it, optionally appends the form
   state's cleaned values as the query string, builds a synthetic `Request::create($path, 'GET')`,
   matches it with `router.no_access_checks->matchRequest()` (route matching only, to recover
   `_route`/`_raw_variables`), copies the current session onto it, `push()`es it onto the request
   stack, and returns a generated URL string. This makes the re-run callback see the *target* page's
   route/query (so pagers/filters work).
4. Emits a `SettingsCommand` updating `drupalSettings.path.currentPath`.
5. `doCallback()` — reads `data['ajax_wrapper_settings']['callback']` and calls
   `AjaxWrapperCallbackUtility::doCallback($callback['function'], $callback['arguments'] ?? [])`.
   Throws `\Exception('No callback was specified...')` if absent.
6. Adds every returned `CommandInterface` to the `AjaxResponse`, then a `StoreHistoryCommand('body', $url)`.

## Callback utility (`src/Utility/AjaxWrapperCallbackUtility.php`)

Service `ajax_wrapper.utility.callback`, `use DoTrustedCallbackTrait`. `doCallback($callback, $arguments, $message)`:

- If `is_callable($callback)` → straight to `doTrustedCallback()` (handles closures and callable
  `Class::staticMethod` strings; core validates trust).
- Else if `$callback` is a string: no `::` → resolve via `controllerResolver->getControllerFromDefinition()`;
  has `::` → `explode('::', …, 2)`.
- If `$callback[0]` is `['_serviceId' => …]` → resolve that service via
  `classResolver->getInstanceFromDefinition()` and use the instance as `$callback[0]`.
- If still not callable → `throw new \Error(...)`.
- Finally `doTrustedCallback($callback, $arguments, $message)`.

`doTrustedCallback` (core `DoTrustedCallbackTrait`) enforces that the resolved method is a **trusted
callback** — a static method with `#[TrustedCallback]` or listed in a class's
`TrustedCallbackInterface::trustedCallbacks()` — otherwise it throws. Plain function-name strings and
non-static/instance callbacks that aren't reachable are rejected. This is the module's trust boundary:
it restricts *which* callbacks may run, but the callback's `function` and `arguments` themselves come
from the POST body (the values originally emitted into `drupalSettings` by the render element).

## Operating notes

- To use a second wrapper on the same page, give each element a distinct `#id` (the DOM id and AJAX
  target selector).
- The callback should be idempotent and re-derivable from scalar arguments + the request's query
  (pager `page`, exposed filters), because on refresh it runs against the reconstructed target request.
- The client submits the refresh via `Drupal.ajax` POST. A callback should produce a render array
  (its return is placed into the wrapper), and should not depend on side effects.
- `AjaxBlockResponse` exists (`src/Response/AjaxBlockResponse.php`) but is unused by `refresh()`,
  which builds a plain `AjaxResponse`.
