<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render element `ajax_placeholder` + AJAX callback API

Install/enable: `drush en ajax_placeholder`. No configuration, no permissions, no schema. Purely a developer API.

## Placing a placeholder

In any render array:

```php
$build['widget'] = [
  '#type' => 'ajax_placeholder',
  '#callback' => ['mymodule.service:buildWidget', [$arg1, $arg2]],
  '#markup' => t('Loading…'), // optional; shown until the AJAX swap
];
```

`#callback` is `[target, args]` where `target` is one of:
- `service_id:method` (e.g. `mymodule.service:buildWidget`) — resolved by `ControllerResolverInterface::getControllerFromDefinition()`.
- `Class::method` (a `::`-containing string) — split into `[class, method]`.

`args` is an array passed positionally to the callback. The callback must return a render array / markup (used verbatim in a `ReplaceCommand`).

## Lifecycle (source: `src/Element/AjaxPlaceholder.php`, `src/AjaxPlaceholderBuilder.php`, `js/ajax-placeholder.js`)

1. `AjaxPlaceholder::getInfo()` registers a single `#pre_render` → `AjaxPlaceholder::preRender()`.
2. `preRender($element)`:
   - `$hash = md5(Json::encode($element['#callback']))`.
   - Writes to shared tempstore collection `ajax_placeholder` (owner = current uid): `set($hash, ['url' => \Drupal::request()->getRequestUri(), 'callback' => $element['#callback']])`.
   - Returns a `container` render element with `#attributes` `class => js-ajax-placeholder`, `data-hash => $hash`, a `content` child of `#markup` (`$element['#markup'] ?? t('Loading...')`), and `#attached` library `ajax_placeholder/ajax`.
3. Behaviour `Drupal.behaviors.ajaxPlaceholder` (once `ajax-placeholder`) reads `data-hash` and calls `Drupal.ajax({url: Drupal.url('ajax/placeholder/' + hash)}).execute()`.
4. Route `ajax_placeholder.ajax` (`/ajax/placeholder/{hash}`, `_permission: access content`) dispatches to `AjaxPlaceholderBuilder::ajaxCallback($hash)`:
   - `$data = tempstore('ajax_placeholder', currentUser id)->get($hash)`. Empty → empty `AjaxResponse`.
   - Access gate: `if (Url::fromUserInput($data['url'])->access() === FALSE) return new AjaxResponse();` — re-checks route access to the page the placeholder was rendered on.
   - Resolves `$callback` from `$data['callback']` (string with `::` → `explode('::', …, 2)`; string without `::` → `controllerResolver->getControllerFromDefinition()`).
   - Runs `doTrustedCallback($callback, $args, '')` (from `DoTrustedCallbackTrait`) and, if a callback resolved, adds `new ReplaceCommand('[data-hash="' . $hash . '"]', <result>)`.

## Callback trust requirement

The callback is invoked through `DoTrustedCallbackTrait::doTrustedCallback()`. Core's default error mode throws `UntrustedCallbackException` for callbacks that are not trusted, so the callback's class must implement `TrustedCallbackInterface` (and list the method in `trustedCallbacks()`), or otherwise be a callback core treats as trusted. Design your callback target accordingly.

## Notes & gotchas

- The tempstore entry is keyed only by `md5(#callback)`; identical `#callback` arrays (same target + args) map to the same hash. Vary the args to get distinct fragments.
- The AJAX response is intentionally uncacheable (see the in-code `@todo` referencing drupal.org issue 2701085).
- The placeholder container carries no cache metadata of its own; put cacheable metadata on the callback's returned render array.
- No-JS clients see only the `#markup` fallback — provide meaningful placeholder markup where that matters.
- Access is evaluated against the *page URL* recorded at render time (`getRequestUri()`), not against the callback itself; ensure the callback only builds content the page's audience is entitled to.
