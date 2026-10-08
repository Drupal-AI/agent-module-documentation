# Embed IEF in code

## The `inline_entity_form` render element

`Drupal\inline_entity_form\Element\InlineEntityForm` (`#type => 'inline_entity_form'`).
Drop it into any form to edit/create one entity inline:

```php
$form['article'] = [
  '#type' => 'inline_entity_form',
  '#entity_type' => 'node',
  '#bundle' => 'article',
  // NULL #default_value => a new entity is created.
  '#default_value' => $loaded_article,
  '#form_mode' => 'default',   // form mode to render
  '#revision' => FALSE,        // create new revision on save
  '#save_entity' => TRUE,      // save the entity on submit
  '#op' => NULL,               // 'add', 'edit' or 'duplicate'
];
```

- Access the built entity in validate/submit via `$form['article']['#entity']`.
  It is **not** available through `$form_state->getValue('article')` (core limitation).
- The element runs its own `#element_validate` (`validateEntityForm`) and a custom
  `#ief_element_submit` phase (`submitEntityForm`); IEF wires these up in
  `inline_entity_form_form_alter()` via `ElementSubmit`/`WidgetSubmit` whenever a form
  contains an IEF widget (it looks for `$form_state->get('inline_entity_form')`).

## The `inline_form` entity handler

`hook_entity_type_build()` registers an `inline_form` handler on every entity type:
`EntityInlineForm` by default, `NodeInlineForm` for nodes. Get it and its table columns:

```php
$handler = \Drupal::entityTypeManager()->getHandler('node', 'inline_form');
$fields  = $handler->getTableFields($bundles); // columns shown in the IEF table
```

Provide a custom handler by declaring a `handlers: { inline_form: '\\...' }` class on your
entity type; IEF only sets the default if none exists. Interface:
`Drupal\inline_entity_form\InlineFormInterface`.
