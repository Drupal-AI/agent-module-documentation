<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lazy-loading a View with `data-lv-*` attributes

Source: `js/ajax.js`. Put an element carrying these attributes anywhere in your markup (Twig template,
block, field, custom HTML). On `Drupal.attachBehaviors`, each element with a `data-lv-id` is processed
once (`core/once`) and an AJAX call to `views/ajax` is wired up.

## Attributes

| Attribute | Required | Default | Meaning |
|---|---|---|---|
| `data-lv-id` | yes | — | The View **machine name** (e.g. `frontpage`). |
| `data-lv-display` | yes | — | The View **display id** (e.g. `page_1`, `block_1`). Nothing happens without it. |
| `data-lv-target` | no | `lazy-view` | Class/id of the placeholder that receives the rendered View. |
| `data-lv-args` | no | `{}` | Contextual arguments passed as the View's `view_args`. |
| `data-lv-execute` | no | `false` | If truthy, run the AJAX **immediately on attach** (lazy-load on page load). Also used as the event name fallback. |
| `data-lv-type` | no | `POST` | HTTP method for the AJAX request. |
| `data-lv-progress-type` | no | `fullscreen` | Drupal AJAX progress indicator (`fullscreen`, `throbber`, `bar`, `none`). |

The trigger event is `data-lv-execute` when set, otherwise `click`.

## The placeholder / target

The JS looks for an element with class `js-view-dom-id-<target>`. If it does not find one, it looks for
an element matching `.<target>` **or** `#<target>` and adds the `js-view-dom-id-<target>` class to it.
If no target element exists, nothing loads. So you need **two** things on the page: the trigger element
(with the `data-lv-*` attributes) and a placeholder matching the target.

## Examples

Load a View on click into a placeholder:

```html
<button data-lv-id="my_related" data-lv-display="block_1" data-lv-target="related-wrapper">
  Show related
</button>
<div class="related-wrapper"></div>
```

Lazy-load on page load (fires during behavior attach), passing an argument:

```html
<div class="promo-wrapper"></div>
<span data-lv-id="promos" data-lv-display="block_1"
      data-lv-target="promo-wrapper" data-lv-args="42" data-lv-execute="1"
      style="display:none"></span>
```

## Notes

- `view_path` is sent as `window.location.pathname`, so contextual filters that default from the URL
  behave as if the View were on the current page.
- The request hits core's `views/ajax` route; the View's access plugin and cache metadata still apply.
  Lazy Views changes *when* the request is made, not *whether* the user may see the results.
- Multiple triggers can coexist; each needs a distinct `data-lv-target` and matching placeholder.
