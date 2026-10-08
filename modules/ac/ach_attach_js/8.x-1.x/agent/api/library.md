<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ach_attach_js/ach-attach-js` library

## Install & enable

```bash
composer require drupal/ach_attach_js
drush en ach_attach_js -y
```

Core-only, no configuration. Enabling the module makes the library **available** but does not
attach it anywhere — you (or the Attacher sub-module) must attach it to a page for it to do
anything.

## Library definition

`ach_attach_js.libraries.yml`:

```yaml
ach-attach-js:
  js:
    js/ach-attach-js.js: {}
  dependencies:
    - core/drupal
    - core/drupalSettings
    - core/jquery
    - core/once
```

Full library id (for attaching): **`ach_attach_js/ach-attach-js`**.

## What the JS does

`js/ach-attach-js.js` defines `Drupal.behaviors.achAttachJs`:

- `attach(context, settings)` — using `once('ach-attach-js', 'body')` so it runs a single time,
  calls `addLiftEventListeners()`.
- `addLiftEventListeners()` — registers a `window` event listener for Acquia Lift's
  **`acquiaLiftContentAvailable`** event (see
  `https://docs.acquia.com/personalization/api/javascript/events/`). On the event it does:

  ```js
  var $slot = $('[data-lift-slot="' + e.detail.decision_slot_id + '"]');
  Drupal.attachBehaviors($slot[0], drupalSettings);
  ```

So when Lift finishes injecting personalized content into a decision slot, Drupal re-attaches all
registered behaviors to that specific slot element, initializing any JS-driven UI inside it. If no
element matches the selector, `$slot[0]` is `undefined` and `Drupal.attachBehaviors` is a no-op.

## Three ways to attach it

1. **Attacher sub-module (path config):** enable `ach_attach_js_attacher` and set paths at
   `/admin/config/ach_attach_js`. See that module's doc tree.

2. **Theme `.info.yml`:**

   ```yaml
   libraries:
     - ach_attach_js/ach-attach-js
   ```

3. **Render array / preprocess (PHP):**

   ```php
   $variables['#attached']['library'][] = 'ach_attach_js/ach-attach-js';
   ```

4. **Twig template:**

   ```twig
   {{ attach_library('ach_attach_js/ach-attach-js') }}
   ```

## Notes

- Requires Acquia Lift/Personalization to be present on the page and firing
  `acquiaLiftContentAvailable`; without it the library adds a harmless idle listener.
- Upstream is marked Unsupported/Obsolete; the maintainer notes no Lift experience since 2019. The
  code is trivial and still valid against Drupal 9.2–11 behaviors/once APIs.
