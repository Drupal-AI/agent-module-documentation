<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_body_class` base field and `<body>` output

All logic lives in `entity_body_class.module` (no service, no plugin).

## The base field — `hook_entity_base_field_info()`

`entity_body_class_entity_base_field_info(EntityTypeInterface $entity_type)` adds field
`entity_body_class` when both conditions hold:

- `$entity_type->getOriginalClass()` implements `ContentEntityInterface`, and
- `$entity_type->getLinkTemplate('canonical')` is truthy (the entity has a viewable page).

The field is `BaseFieldDefinition::create('string')`, label *"Body CSS class(es)"*, description noting
it accepts multiple space-separated classes and tokens (e.g. `my-body-class-1 [language:langcode]`),
`setTranslatable(TRUE)`, form display `string_textfield`, `setDisplayConfigurable('form', TRUE)`. Being
a base field, it appears on every supported bundle automatically; hide it per bundle by moving it to the
*Disabled* region on **Manage form display**. `hook_uninstall()` (`entity_body_class.install`) calls
`field_purge_batch(10)` to clean up field data on uninstall.

## Form integration — `hook_form_alter()`

`entity_body_class_form_alter()` acts only when the form object is a `ContentEntityFormInterface` **and**
`$form['entity_body_class']` exists. It then:

1. If config `entity_body_class.settings` key `types[<entity_type_id>]` is set **and the entity is new**
   (`$entity->isNew()`), sets that string as the widget `#default_value`.
2. If the `token` module is enabled, adds a `#theme => 'token_tree_link'` element (token types =
   the entity's type id) as `$form['entity_body_class']['suffix']`.
3. Sets `$form['entity_body_class']['#access']` to
   `hasPermission('access entity body class fields') || hasPermission("access {$type} body class field")`.
4. Appends `entity_body_class_entity_form_validate` to `$form['#validate']`.

## Input filtering — `entity_body_class_entity_form_validate()`

Reads `$form_state->getValue('entity_body_class')`; if `[0]['value']` is non-empty it replaces it with
`Xss::filter($value)` and writes it back to form state, so the value is XSS-filtered before it is saved.

## Output — `hook_preprocess_html()`

`entity_body_class_preprocess_html(&$variables)` iterates `\Drupal::routeMatch()->getParameters()`. For
each parameter that is a `ContentEntityInterface`, `hasField('entity_body_class')`, and whose field is not
empty, it takes `$entity->get('entity_body_class')->getString()`, runs it through
`\Drupal::token()->replace($class, [$entity->getEntityTypeId() => $entity])`, and appends the result to
`$variables['attributes']['class'][]`. The class therefore renders on `<body>` for any routed content
entity carrying a value — most commonly the canonical entity page, but any route whose upcasted
parameters include such an entity. Drupal's attribute rendering escapes the class value on output.

## Notes

- Multiple classes: the whole string (spaces included) is added as one class-array element; the theme
  layer normalizes it.
- Tokens are resolved with the entity keyed by its own type id, so `[node:...]`, `[term:...]`, etc. work
  on the matching entity type; `[language:langcode]` and other global tokens work anywhere.
