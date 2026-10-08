<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preprocess hook & pre-render callback

## `hook_preprocess_menu__bulma_navbar()`

In `drulma_menu_item_fields.module`. Runs when a menu is themed via the `menu__bulma_navbar`
suggestion (added by Drulma Companion's `BulmaNavbarWithBrandingBlock`). Steps:

1. Delegates to `menu_item_fields_preprocess_menu__field_content($variables)` — the Menu Item
   Fields module's own preprocessor that builds field `content` on each menu item.
2. For each `$variables['items']` that has a `content` element, it:
   - appends `[\Drupal\drulma_menu_item_fields\Render\Callback::class, 'preRenderMenuLinkContent']`
     to `content['#pre_render']`, and
   - attaches library `drulma_menu_item_fields/navbar-adjust` to `content['#attached']['library']`.

## `Callback::preRenderMenuLinkContent()`

`src/Render/Callback.php`. `Callback` implements `Drupal\Core\Security\TrustedCallbackInterface`;
`trustedCallbacks()` whitelists `preRenderMenuLinkContent`, so Drupal's render pipeline accepts it
as a `#pre_render` callback.

The static method receives the menu-item `content` render element. It reads
`$element['link'][0]['#url']` (a `Url` object), fetches its `attributes` option, appends the CSS
classes `navbar-item` and `navbar-drulma-adjust`, and writes the option back with
`$contentUrl->setOption('attributes', …)`. It also appends `navbar-drulma-adjust` to
`$element['link']['#attributes']['class']`. It only manipulates attribute/class arrays with fixed
class strings and returns the element. No user-supplied values are rendered by the callback itself.

## Library `navbar-adjust`

`drulma_menu_item_fields.libraries.yml`: `navbar-adjust` → `css/navbar-adjust.css` (theme layer),
the CSS that aligns field-based menu links inside the Bulma navbar.
