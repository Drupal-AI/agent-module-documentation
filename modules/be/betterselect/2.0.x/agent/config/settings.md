<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Select — behavior, settings, and integration

Source: `betterselect.module`, `src/Form/BetterSelectSettingsForm.php`,
`config/{install,schema}/betterselect.settings.yml`, `betterselect.routing.yml`,
`betterselect.links.menu.yml`, `betterselect.libraries.yml`, `betterselect.install`.

## Install / enable

`drush en betterselect`. No dependencies (`betterselect.info.yml` declares only
`core_version_requirement: ^10 || ^11`, package `Form`). On uninstall,
`betterselect_uninstall()` deletes the `betterselect.settings` config object.

## What it does (the conversion)

`betterselect_element_info_alter(&$types)` appends `betterselect_process_element` to
`$types['select']['#process']`, so **every** `select` render element is inspected during form
processing.

`betterselect_should_format_element($element)`:
- returns FALSE if `#multiple` is empty (single-value selects are never touched);
- returns TRUE if `#betterselect` is truthy on the element;
- otherwise returns the negation of config `explicit_only` — i.e. with `explicit_only` FALSE
  (default) **all** multi-selects convert; with it TRUE, only elements carrying
  `#betterselect = TRUE` convert.

`betterselect_process_element($element, $form_state, &$complete_form)` when conversion applies:
1. Normalizes `#value`: an indexed value array from the select is filtered (`array_filter(…, 'strlen')`)
   and turned into the associative `value => value` map `Checkboxes::processCheckboxes()` expects.
2. Sets `#type = 'checkboxes'`, `#checkall = TRUE`, `#theme_wrappers = ['checkboxes']`; unsets the
   select's `#theme`, `#pre_render`, and the `multiple`/`name`/`size` `#attributes` before children
   inherit them; then calls `Checkboxes::processCheckboxes()` to build the child checkbox elements.
3. On non-required elements, hides the empty option (`_none` or `''`) via `#access = FALSE`.
4. Attaches library `betterselect/betterselect`.
5. If config `add_depth_classes` is on, walks `Element::children()` and, from the number of leading
   `-` characters in each `#title`, adds a `checkbox-depth-N` `#wrapper_attributes` class; the
   previous option gets `has-children` when the current one is deeper (hierarchical taxonomy lists).
6. Wraps the element in `<div id="…" class="better-select …">` via `#prefix`/`#suffix`, preserving
   any existing prefix/suffix. The id (`Html::getUniqueId('better-select-' . #id)`) and the class
   string are passed through `Html::escape()`. Container classes: always `better-select` plus
   `form-checkboxes-scroll` or `form-checkboxes-noscroll` (from `scroll`); `better-select-scroll-to-first`
   when `scroll` and `scroll_to_first_checked` are both on; `betterfixed` when the option count
   exceeds the element `#size` (default 10).

## Settings

Config object **`betterselect.settings`** (schema type `config_object`, all `boolean`, all default
FALSE in `config/install/betterselect.settings.yml`):

| Key | Label | Effect |
| --- | --- | --- |
| `scroll` | Scrollable div | Wrap options in a fixed-height scrollable box (`form-checkboxes-scroll`). |
| `scroll_to_first_checked` | Scroll to the first selected item | On load, scroll the box to the first checked option. Requires `scroll`. |
| `explicit_only` | Explicit opt-in only | Convert only elements with `#betterselect = TRUE`; otherwise convert all multi-selects. |
| `add_depth_classes` | Add depth classes | Emit `checkbox-depth-N` / `has-children` wrapper classes from `-`-indented option titles. |

Form `BetterSelectSettingsForm` (`getFormId()` = `betterselect_admin_settings`, extends
`ConfigFormBase`, editable config `betterselect.settings`) casts each value to `(bool)` on submit.

### Config export example

```yaml
# betterselect.settings.yml
scroll: true
scroll_to_first_checked: true
add_depth_classes: false
explicit_only: false
```

## Route, menu, permission

- Route **`betterselect.settings`** (`betterselect.routing.yml`): path
  `/admin/config/content/betterselect`, `_form` = the settings form, requirement
  `_permission: 'administer site configuration'` (core permission — the module defines **no**
  `*.permissions.yml`).
- Menu link `betterselect.settings` (`betterselect.links.menu.yml`) under `system.admin_config_content`.
- `info.yml` `configure: betterselect.settings` surfaces the config link on the Extend page.

## Library / front-end

`betterselect.libraries.yml` → library `betterselect`: `css/betterselect.css` (theme) +
`js/betterselect.js`, deps `core/drupal`, `core/once`. `js/betterselect.js` defines
`Drupal.behaviors.initBetterSelect`: for each `.better-select input[type="checkbox"]` it adds/removes
a `hilight` class on the closest `.form-item` to reflect the checked state, and for a
`.better-select.form-checkboxes-scroll.better-select-scroll-to-first` container it sets `scrollTop`
to center the first checked input. Pure DOM/`classList` work — no markup injection.

## Opt-in from code

To convert a single element only, enable **Explicit opt-in only** and set the flag in a form
builder or `hook_form_alter()`:

```php
$form['my_field']['#betterselect'] = TRUE;
```
