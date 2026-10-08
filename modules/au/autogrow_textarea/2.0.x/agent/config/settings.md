<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, enable, and operation

## Install / enable
```
composer require drupal/autogrow_textarea
drush en autogrow_textarea -y
```
No dependencies outside core. After enabling, clear caches (`drush cr`) so the altered `textarea` element definition is rebuilt.

## Configuration
There is none. The module has no admin route, no settings form, no `config/install/*`, no config schema, and no permissions (`data.json`: `configure: null`, `provides_permissions: false`, `provides_config_schema: false`). It acts on all textareas automatically. To turn it off, uninstall the module and clear caches.

## How the attach works
1. `autogrow_textarea_element_info_alter(array &$info)` in `autogrow_textarea.module` checks for `$info['textarea']` and appends the library `autogrow_textarea/autogrow_textarea` to `$info['textarea']['#attached']['library']`. Every Form API `textarea` element therefore ships the JS wherever it is rendered.
2. Library `autogrow_textarea` (`autogrow_textarea.libraries.yml`) loads the single, unminified file `js/autogrow_textarea.js`. Declared library license is MIT in `libraries.yml`/`composer.json`, though the shipped `LICENSE.txt` and Drupal.org distribution are GPL-2.0-or-later.

## Behavior (`js/autogrow_textarea.js`)
`Drupal.behaviors.autogrow_textarea.attach(context, settings)`:
- Uses `once('autogrow-textarea', 'textarea', context)` to bind each textarea exactly once, including textareas injected via AJAX (respects `context`).
- `updateTextareaHeight()` clears `textarea.style.height` (forcing a reflow) then sets it to `` `${textarea.scrollHeight + 10}px` `` — 10px of breathing room.
- Runs once on attach and assigns `textarea.oninput = updateTextareaHeight`, so the field resizes on every keystroke/paste and shrinks when text is removed.

Note: `oninput` is assigned directly, so any other `oninput` handler on the same element would be overwritten (last-writer-wins). No `drupalSettings` are read or emitted; no server-side or user data flows through this module.

## Notes for agents
- Nothing to tune. If auto-grow is unwanted on a specific textarea, remove the module or override the behavior in a custom library — there is no per-field opt-out.
- CKEditor editors already auto-size; this targets plain textareas.
