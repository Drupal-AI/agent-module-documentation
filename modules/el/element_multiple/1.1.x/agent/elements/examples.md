<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `element_multiple` recipes

All examples go in a `buildForm()` / `hook_form_alter()`. Read the submitted value with
`$form_state->getValue('KEY')` in your submit handler. Patterns below are taken from the
module's own test forms (`tests/modules/element_multiple_test/`), which are authoritative.

## Simple list of scalars (default textfield)
```php
$form['tags'] = [
  '#type' => 'element_multiple',
  '#title' => $this->t('Tags'),
  '#default_value' => ['Alpha', 'Beta', 'Gamma'],
];
// submit value: [0 => 'Alpha', 1 => 'Beta', 2 => 'Gamma'] (empties dropped, weight-sorted)
```

## Single non-text element, capped at 5 (email list)
```php
$form['emails'] = [
  '#type' => 'element_multiple',
  '#title' => $this->t('Notification emails'),
  '#cardinality' => 5,
  '#element' => [
    '#type' => 'email',
    '#title' => $this->t('Email address'),
    '#title_display' => 'invisible',
    '#placeholder' => $this->t('Enter email address'),
  ],
  '#default_value' => ['a@example.com', 'b@example.com'],
];
// add controls disappear once 5 rows exist; a crafted "add N" POST is clamped to 5.
```

## Composite row with a header (columns)
```php
$form['contacts'] = [
  '#type' => 'element_multiple',
  '#title' => $this->t('Contacts'),
  '#header' => TRUE, // or an explicit array of column headers
  '#element' => [
    'first_name' => ['#type' => 'textfield', '#title' => $this->t('First name'), '#title_display' => 'invisible'],
    'last_name'  => ['#type' => 'textfield', '#title' => $this->t('Last name'),  '#title_display' => 'invisible'],
  ],
  '#default_value' => [
    ['first_name' => 'John', 'last_name' => 'Smith'],
    ['first_name' => 'Jane', 'last_name' => 'Doe'],
  ],
];
// submit value: [['first_name'=>'John','last_name'=>'Smith'], ...]
```

Explicit column headers instead of `#header => TRUE`:
```php
'#header' => [
  ['data' => $this->t('First name'), 'width' => '50%'],
  ['data' => $this->t('Last name'),  'width' => '50%'],
],
```

## Unique-keyed associative map (`#key`)
```php
$form['options'] = [
  '#type' => 'element_multiple',
  '#key' => 'value',        // 'value' sub-element becomes the array key, validated unique
  '#header' => TRUE,
  '#element' => [
    'value' => ['#type' => 'textfield', '#title' => 'value'],
    'text'  => ['#type' => 'textfield', '#title' => 'text'],
    'score' => ['#type' => 'number',    '#title' => 'score'],
  ],
  '#default_value' => [
    'one' => ['text' => 'One', 'score' => 1],
    'two' => ['text' => 'Two', 'score' => 2],
  ],
];
// submit value: ['one' => ['text'=>'One','score'=>'1'], ...]; duplicate 'value' => validation error.
```

## Hidden per-row id that travels with each item
```php
$form['rows'] = [
  '#type' => 'element_multiple',
  '#header' => TRUE,
  '#element' => [
    'id'         => ['#type' => 'value'], // not shown, but kept in the item
    'first_name' => ['#type' => 'textfield', '#title' => 'first_name'],
    'last_name'  => ['#type' => 'textfield', '#title' => 'last_name'],
  ],
  '#default_value' => [
    ['id' => 'john', 'first_name' => 'John', 'last_name' => 'Smith'],
  ],
];
```

## Required list, at least one entry
```php
$form['aliases'] = [
  '#type' => 'element_multiple',
  '#title' => $this->t('Aliases'),
  '#element' => ['#type' => 'textfield', '#title' => 'alias', '#required' => TRUE],
  // #required on the wrapper forces #min_items => 1; empty submit => required error.
  '#required' => TRUE,
];
```

## Turning controls off / custom labels / no rows
```php
'#sorting' => FALSE,                 // no drag column, no weight sort
'#operations' => FALSE,              // no per-row +/- column
'#add_more' => FALSE,                // no add-more button under the table
'#add_more_input' => FALSE,          // add button but no numeric count input
'#add_more_button_label' => $this->t('Add row'),
'#add_more_input_label'  => $this->t('rows'),
'#min_items' => 0, '#empty_items' => 0, // start with zero rows + a "no items" message
```

## Reading the value in submit
```php
public function submitForm(array &$form, FormStateInterface $form_state) {
  $contacts = $form_state->getValue('contacts'); // already array-of-items, empties removed
  // You own: dedupe, order significance, and where it is stored (config, state, entity…).
}
```
