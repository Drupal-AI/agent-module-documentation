# jQuery UI Effects — manual setup guide

**jQuery UI Effects** (`jquery_ui_effects`) is a developer module that re‑provides
the jQuery UI **Effects** animation library as an asset library. Drupal core used
to bundle these effects, but jQuery UI reached end of life upstream and core
removed them, so this module ships them separately. That keeps existing themes,
modules and custom JavaScript that use jQuery UI animations — fades, slides,
bounces, shakes, highlights and the rest — working after a core upgrade.

There is nothing to configure and nothing appears in the admin UI. The module has
no settings form, no permissions, and no services — it is purely an asset provider
with no PHP code of its own. You install it, then **attach the library ids** you
need. The libraries are registered on the module's behalf by the base `jquery_ui`
module (which is why this module depends on it), and it bundles the vendored jQuery
UI 1.13.x effects scripts.

The effects come in two layers: a core engine (`jquery_ui_effects/core`) that adds
jQuery UI's `.effect()` method, effect‑aware `.show()` / `.hide()` / `.toggle()`,
color animation and easings; and one sub‑library per individual effect. Attaching a
specific effect automatically loads the core engine, so you rarely attach `core`
directly.

A word of caution: jQuery UI is no longer maintained. This module exists to bridge
legacy code during a migration — for new work, the maintainers recommend a modern
animation approach rather than taking on this dependency.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, no settings and no permissions. It only
makes asset libraries available for developers to use.

## How to use it

Attach the library id for the effect you want. A single effect pulls in the core
engine automatically:

```php
// A single effect (loads jquery_ui_effects/core automatically):
$build['#attached']['library'][] = 'jquery_ui_effects/fade';

// The engine only (easings, color animation, generic .effect()):
$build['#attached']['library'][] = 'jquery_ui_effects/core';
```

Or list it as a dependency in your own `*.libraries.yml`:

```yaml
my_module/my_animation:
  js:
    js/my-animation.js: {}
  dependencies:
    - jquery_ui_effects/slide
    - jquery_ui_effects/bounce
```

Then use it in JavaScript once attached (jQuery is available as a dependency):

```js
$('#box').effect('bounce', { times: 3 }, 500);
$('#panel').hide('fold', {}, 400);
```

The available effect sub‑libraries are: `blind`, `bounce`, `clip`, `drop`,
`explode`, `fade`, `fold`, `highlight`, `puff`, `pulsate`, `scale`, `shake`,
`size`, `slide` and `transfer` (each under the `jquery_ui_effects/` namespace).
Attach only the ones you actually need rather than loading the whole set.
