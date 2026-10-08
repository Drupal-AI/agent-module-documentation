<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `toggle_switch` render element

Provided by `src/Element/ToggleSwitch.php` (`@FormElement("toggle_switch")`), extending core
`Drupal\Core\Render\Element\Radios`. A drop-in radios group rendered as a CSS switch. Enable the
module (`drush en css_toggle_switch`); the element is then usable anywhere Form API render arrays
are built.

## Minimal usage

```php
$form['active'] = [
  '#type' => 'toggle_switch',
  '#toggle_type' => 'switch-light',        // 'switch-light' or 'switch-toggle'
  '#title' => $this->t('Poll status'),
  '#default_value' => 1,
  '#options' => [
    0 => $this->t('Closed'),
    1 => $this->t('Active'),
  ],
  '#attributes' => [
    'class' => ['switch-candy switch-candy-blue'], // library skin classes
  ],
  '#toggle_on__attributes' => [
    'class' => 'custom-class',               // class on the "on" indicator <a>
  ],
];
```

Submitted value behaves like `radios` (returns the selected option key).

## Element properties

- `#options` — required; the choices. Each child is retyped to `#type = 'toggle_switch_option'` in
  `processToggleSwitch()` and its per-child `#attributes` are unset (styling comes from the
  wrapper, not individual radios).
- `#toggle_type` — wrapper class controlling the presentation; default `switch-toggle` (applied in
  the preprocess if unset). The library ships `switch-light` and `switch-toggle`.
- `#attributes['class']` — extra classes merged onto the wrapper `<div>` (library skins such as
  `switch-candy`, `switch-ios`, or Bootstrap/Foundation helpers).
- `#wrapper_attributes` — merged (recursively) into the wrapper attributes.
- `#toggle_on__attributes` — array turned into a `Drupal\Core\Template\Attribute` and rendered as
  `<a{{ toggle_on__attributes }}>&nbsp;</a>` inside the wrapper (the moving indicator). Typically
  `['class' => '...']`.
- Inherits all core `Radios` properties (`#title`, `#default_value`, `#required`, `#description`).

`valueCallback()` differs from core Radios in one way: when there is no user input and no
`#default_value`, it defaults to the **first** option key (`reset()`/`key()`), so a switch is never
rendered with nothing selected.

## Theming

- `hook_theme()` (in `css_toggle_switch.module`) registers `toggle_switch` and
  `toggle_switch_option`, both `render element => 'element'`.
- `templates/toggle-switch.html.twig`: `<div{{ attributes }}>{{ children }}<a{{ toggle_on__attributes }}>&nbsp;</a></div>`.
- `templates/toggle-switch-option.html.twig`: `{{ children }}{{ label }}`.
- `css_toggle_switch_preprocess_toggle_switch()` — runs `template_preprocess_radios()`, adds the
  `#toggle_type` class, merges `#wrapper_attributes` and `#attributes['class']`, builds the
  `toggle_on__attributes` object.
- `css_toggle_switch_preprocess_toggle_switch_option()` — runs
  `template_preprocess_form_element()` and sets `label.#attributes.onclick = ''` (iOS/Opera Mini
  tap fix).

Override either template in your theme to change markup; the element API stays the same.

## Assets / libraries

`css_toggle_switch.libraries.yml` defines:

- `element.toggle_switch` — the module's own `css/element.toggle-switch.css` +
  `js/element.toggle-switch.js`; depends on `core/drupal`, `core/once`, and the two library
  wrappers below. Attached automatically by `processToggleSwitch()`.
- `css_toggle_switch` — external CSS `//cdn.jsdelivr.net/npm/css-toggle-switch@4.1.0/dist/toggle-switch.min.css`
  (ghinda/css-toggle-switch 4.1.0, MIT).
- `detect_swipe` — external JS `//cdn.jsdelivr.net/npm/detect_swipe@2.1.4/jquery.detect_swipe.min.js`
  (marcandre/detect_swipe 2.1.4, MIT); depends on `core/jquery`.

`hook_library_info_alter()` (`css_toggle_switch_library_info_alter`) uses
`\Drupal::service('library.libraries_directory_file_finder')` to look for
`css_toggle_switch/toggle-switch.min.css` and `detect_swipe/jquery.detect_swipe.min.js` under the
site `libraries/` dir; if present it rewrites the library defs to serve the **local** files instead
of the CDN (per drupal.org/node/3099614). Use this for offline installs or strict CSP.
