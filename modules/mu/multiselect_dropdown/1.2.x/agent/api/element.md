<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown — render element

`Drupal\multiselect_dropdown\Element\MultiselectDropdown` (`#[FormElement('multiselect_dropdown')]`)
extends core `Checkboxes`. Use it anywhere you'd use `checkboxes`; the submitted value is the
same associative array of selected keys. `processCheckboxes()` calls the parent then adds
`role="option"` to each option. `getInfo()` sets `#input => TRUE`, `#theme =>
['multiselect_dropdown']`, `#theme_wrappers => ['form_element']`.

## Properties (beyond core Checkboxes / RenderElement)
| Property | Type | Default | Meaning |
|---|---|---|---|
| `#options` | array | — | Checkbox items (keyed). Per-option properties as in core Checkboxes. |
| `#label_aria` | string | 'Toggle the list of items' | aria-label on the toggle button. |
| `#label_none` | string | 'No Items Selected' | Toggle label when nothing selected. |
| `#label_single` | string | '%d Item Selected' | Toggle label, one selected (`%d` = count). |
| `#label_plural` | string | '%d Items Selected' | Toggle label, >1 selected (`%d` = count). |
| `#label_all` | string | 'All Items' | Toggle label when all selected. |
| `#label_close` | string | '' | Close button label (button always gets an aria-label). |
| `#label_select_all` | string | '' | Select-all button label; empty = omit button. |
| `#label_select_none` | string | '' | Deselect-all button label; empty = omit button. |
| `#label_submit` | string | '' | In-dialog submit button label; empty = omit. |
| `#label_clear` | string | '' | In-dialog clear button label; empty = omit. |
| `#search_title` | string | '' | Search field label; empty = no search field. |
| `#search_title_display` | string | 'invisible' | Label display (see core `#title_display`). |
| `#search_placeholder` | string | '' | Search input placeholder. |
| `#search_character_threshold` | int | 3 | Min chars typed before search filters. |
| `#modal_breakpoint` | int\|string | 768 | Screen width (px) at/below which the dialog is modal, OR `ModalType::Dialog->value` ('dialog') / `ModalType::Modal->value` ('modal') to force non-modal / always-modal. Invalid value throws `\ValueError`. |
| `#default_open` | bool | FALSE | Open the dialog on page load (non-modal only). |

`Drupal\multiselect_dropdown\ModalType` is a string enum: `Breakpoint` = 'breakpoint',
`Dialog` = 'dialog', `Modal` = 'modal'.

## Nesting / hierarchy
To indent nested options, set on a per-option basis
`'#attributes' => ['data-multiselect-dropdown-depth' => <int>]` (0 = root). If the attribute
is absent, `multiselect_dropdown_nest_children()` derives depth from a leading-`-` prefix on
the option title (the format views uses for hierarchical taxonomy) and strips the dashes.

## Usage example
```php
$form['continents'] = [
  '#type' => 'multiselect_dropdown',
  '#title' => $this->t('Select Countries'),
  '#label_aria' => $this->t('Toggle the list of countries'),
  '#label_none' => $this->t('No Countries Selected'),
  '#label_all' => $this->t('All Countries'),
  '#label_single' => $this->t('%d Country Selected'),
  '#label_plural' => $this->t('%d Countries Selected'),
  '#label_select_all' => $this->t('Select All'),
  '#search_title' => $this->t('Search Countries'),
  '#search_character_threshold' => 3,
  '#modal_breakpoint' => 768,
  '#options' => [
    'europe' => $this->t('Europe'),
    'germany' => $this->t('Germany'),
    'france' => $this->t('France'),
  ],
  // Per-option depth for nesting:
  'germany' => ['#attributes' => ['data-multiselect-dropdown-depth' => 1]],
  'france'  => ['#attributes' => ['data-multiselect-dropdown-depth' => 1]],
];
```
The `multiselect_dropdown/element` library is attached automatically by the template
preprocess. Value handling, `#default_value`, validation, etc. are all inherited from core
`Checkboxes`.
