# Attach the jQuery UI Tooltip library

`jquery_ui_tooltip` is a pure asset/library provider. It carries no render elements, theme hooks
or templates of its own — its whole job is to make one attachable library available:

```
jquery_ui_tooltip/tooltip
```

That library bundles jQuery UI 1.13.2's `tooltip-min.js` and the base-theme `tooltip.css`. After
attaching it you can call `.tooltip()` in your JavaScript.

## Why this module exists

Drupal core once bundled jQuery UI (as `core/jquery.ui.*`). jQuery UI is End-of-Life upstream, so
core deprecated and removed it. This project is a split-out companion of the `jquery_ui` base
module that restores just the **Tooltip** widget outside core, so legacy code that relies on it
keeps working. For new code, prefer a maintained tooltip solution.

## The jquery_ui dependency

The module's `.info.yml` declares `dependencies: [jquery_ui:jquery_ui (>=8.x-1.7)]` and its
`composer.json` requires `drupal/jquery_ui: ^1.7`. This module ships **only** an `.info.yml` — the
`tooltip` library definition is not in a `*.libraries.yml` here. Instead the `jquery_ui` module's
`hook_library_info_alter()` reads `jquery_ui.libraries.data.json` and registers the definition
under this module's `jquery_ui_tooltip` namespace. Its declared dependencies are `core/jquery`,
`jquery_ui/widget`, `jquery_ui/position` and internal `jquery_ui/internal.*` helpers, all of which
come from the `jquery_ui` module — so `jquery_ui` must be enabled for the library to resolve.

## Attach from a render array (PHP)

```php
$build['#attached']['library'][] = 'jquery_ui_tooltip/tooltip';
```

## Attach from your own *.libraries.yml

Make your library depend on it; Drupal loads the widget, its CSS and the whole `jquery_ui/*`
dependency chain in the right order:

```yaml
# my_module.libraries.yml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_tooltip/tooltip
```

Then attach `my_module/my_widget` (via `#attached` or a theme `libraries:` entry) and initialise
the widget in a behavior:

```js
// js/my-widget.js
(function ($, Drupal, once) {
  Drupal.behaviors.myTooltip = {
    attach(context) {
      $(once('my-tooltip', '[title]', context)).tooltip();
    }
  };
})(jQuery, Drupal, once);
```

## Migration note

Replace any old `core/jquery.ui.tooltip` reference in custom code with `jquery_ui_tooltip/tooltip`.
No configuration, permissions or services are involved — enabling the module and attaching the
library is the entire surface.
