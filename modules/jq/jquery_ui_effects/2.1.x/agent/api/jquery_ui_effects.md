# jquery_ui_effects — attaching the effects library

This module is a pure asset provider. It has no config, no permissions, no services and no
`*.module` file. It only depends on the base `jquery_ui` module (`jquery_ui:jquery_ui >=8.x-1.7`,
composer `drupal/jquery_ui:^1.7`) and ships the jQuery UI 1.13.x effects scripts.

## Why it exists

Drupal core once bundled jQuery UI effects. jQuery UI is End-of-Life upstream and core removed it,
so this contrib module re-provides the same effects assets to keep legacy themes/modules working.
Prefer migrating off jQuery UI for new code.

## How the libraries are declared

There is **no** `jquery_ui_effects.libraries.yml`. The base `jquery_ui` module registers these
libraries on this module's behalf: its `jquery_ui_library_info_alter()` reads
`jquery_ui.libraries.data.json` and merges any entry keyed by `jquery_ui_effects` into the library
registry. So you must have **both** modules enabled, but you reference the library ids under the
`jquery_ui_effects/*` namespace.

## Library ids

- `jquery_ui_effects/core` — the effects engine. Adds jQuery UI's `.effect()`, and the effect-aware
  `.show()` / `.hide()` / `.toggle()`, plus color animation and easings. Depends on `core/jquery`.
  Every individual effect depends on this.

Individual effect sub-libraries (each depends on `jquery_ui_effects/core`):

- `jquery_ui_effects/blind`
- `jquery_ui_effects/bounce`
- `jquery_ui_effects/clip`
- `jquery_ui_effects/drop`
- `jquery_ui_effects/explode`
- `jquery_ui_effects/fade`
- `jquery_ui_effects/fold`
- `jquery_ui_effects/highlight`
- `jquery_ui_effects/puff` (also pulls in `jquery_ui_effects/scale`)
- `jquery_ui_effects/pulsate`
- `jquery_ui_effects/scale` (also pulls in `jquery_ui_effects/size`)
- `jquery_ui_effects/shake`
- `jquery_ui_effects/size`
- `jquery_ui_effects/slide`
- `jquery_ui_effects/transfer`

Attaching a specific effect automatically loads `jquery_ui_effects/core`, so you rarely attach
`core` directly unless you only need the raw easings / color animation.

## Attach in a render array (PHP)

```php
// A single effect (pulls in jquery_ui_effects/core automatically):
$build['#attached']['library'][] = 'jquery_ui_effects/fade';

// The engine only (easings, color animation, generic .effect()):
$build['#attached']['library'][] = 'jquery_ui_effects/core';
```

## Depend on it from your own *.libraries.yml

```yaml
my_module/my_animation:
  js:
    js/my-animation.js: {}
  dependencies:
    - jquery_ui_effects/slide
    - jquery_ui_effects/bounce
```

## Use in JS once attached

```js
// core/jquery is a dependency, so jQuery is available.
$('#box').effect('bounce', { times: 3 }, 500);
$('#panel').hide('fold', {}, 400);
```
