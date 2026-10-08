<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor BiDi Buttons — plugin internals

The module defines **one** CKEditor 5 plugin (a core `ckeditor5` plugin type — it does **not**
define a new plugin type).

## Drupal plugin definition (`ckeditor_bidi.ckeditor5.yml`)

```yaml
ckeditor_bidi_ckeditor5:
  ckeditor5:
    plugins: [ direction.Direction ]        # the JS plugin exported by the build
  drupal:
    label: Bidi Buttons
    library: ckeditor_bidi/direction         # front-end JS/CSS
    admin_library: ckeditor_bidi/admin.direction
    class: Drupal\ckeditor_bidi\Plugin\CKEditor5Plugin\Bidi
    toolbar_items:
      direction: { label: Direction }        # the toolbar button id
    elements:
      - '<$text-container dir="ltr rtl">'     # allowed HTML the plugin can produce
      - '<li dir="ltr rtl">'
```

`elements` tells Drupal's filter/CKEditor integration that this plugin may add `dir="ltr"` or
`dir="rtl"` to any text container (p, h1–h6, td, blockquote, …) and to list items, so those
attributes are not stripped on save.

## PHP plugin class (`src/Plugin/CKEditor5Plugin/Bidi.php`)

`Bidi extends CKEditor5PluginDefault implements CKEditor5PluginConfigurableInterface`
(`@internal`). It provides:

- `DEFAULT_CONFIGURATION = ['switch_only' => FALSE]` / `defaultConfiguration()`.
- `buildConfigurationForm()` — a single "Never remove direction, only switch" checkbox.
- `submitConfigurationForm()` — casts and stores `switch_only`.
- `getDynamicPluginConfig()` — passes the setting to the JS as
  `['direction' => ['switchOnly' => (bool) $this->configuration['switch_only']]]`.

So the PHP `switch_only` setting reaches the CKEditor 5 JS runtime as `direction.switchOnly`.

## JS plugin (`js/ckeditor5_plugins/direction/`, built to `js/build/direction.js`)

Standard CKEditor 5 plugin split into `direction.js` (Plugin), `directionediting.js` (schema +
model↔view converters for the `dir` attribute), `directioncommand.js` (the toggle/switch
command that reads `switchOnly`), and `directionui.js` (registers the toolbar button using the
`icons/ltr.svg` / `icons/rtl.svg` icons). Library `ckeditor_bidi/direction` also pulls in
`bidi_direction.aftermarket` CSS.

There are **no** Drupal services, routes, hooks (beyond `hook_help`), permissions, or Drush
commands — everything is the toolbar plugin plus the one per-editor setting.
