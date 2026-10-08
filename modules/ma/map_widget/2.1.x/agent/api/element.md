# Render element: `map_associative`

A reusable Form API element for entering a set of key/value pairs, returned as an associative
array. Class `Drupal\map_widget\Element\AssociativeArray` (extends `FormElementBase`), declared
`#[FormElement('map_associative')]`. The `map_assoc_widget` field widget wraps this element, but
you can drop it into any custom form.

```php
$form['params'] = [
  '#type' => 'map_associative',
  '#title' => $this->t('Parameters'),
  '#default_value' => ['color' => 'red', 'size' => 'large'], // key => value
  '#count' => 3,             // how many pair-rows to render (min); optional, default 1
  '#size' => 40,             // char width of each textfield; optional, default 60
  '#key_placeholder' => 'Key',
  '#value_placeholder' => 'Value',
  '#required' => FALSE,
];
```

On submit, `$form_state->getValue('params')` is a flat associative array `['color' => 'red', ...]`.

## Element properties (`getInfo()`)

| Property | Default | Meaning |
|---|---|---|
| `#count` | 1 | Number of pair rows to render (empty extras are padded up to this count) |
| `#size` | 60 | `#size` on each key/value textfield |
| `#key_placeholder` | NULL | Placeholder on key inputs |
| `#value_placeholder` | NULL | Placeholder on value inputs |
| `#input` | TRUE | It is an input element |
| `#theme_wrappers` | `['fieldset']` | Wrapped in a fieldset |

`#process` → `processAssociativeArray()`, `#element_validate` → `validateAssociativeArray()`.

## How it processes

- `processAssociativeArray()` builds one mini-form per pair (`arrayElementForm()`): a `container`
  (class `map-associative-element`) holding a `key` textfield and a `value` textfield. If
  `#default_value` is empty it renders a single empty pair, then pads extra empty pairs up to
  `#count`. Each container attaches library `map_widget/associative_element`.
- `valueCallback()` collapses submitted input `[['key'=>k,'value'=>v], ...]` into `[k => v]`,
  keeping only pairs where `hasValue()` is true (value is not `NULL` and not `''`). Duplicate
  keys: the last one wins.
- `validateAssociativeArray()` copies the assembled `#value` array to the element's form value.

Note: this element itself does not render an "add row" control — that button lives in the field
widget. In a standalone form, set `#count` high enough, or add your own AJAX add-more.
