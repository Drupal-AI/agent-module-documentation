<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Value generation mechanism

The whole runtime is one hook plus one service. There is no cron, queue, or manual trigger —
values are (re)generated whenever an entity is saved.

## Flow

1. `field_token_value_entity_presave($entity)` (in `.module`) fires on **every** entity save and
   calls `field_token_value.field_value_generator`.
2. `FieldValueGenerator::generateFieldValueForEntity($entity)`:
   - skips non-fieldable entities;
   - iterates all field definitions on the entity's bundle;
   - keeps only fields whose field-type **provider is `field_token_value`**;
   - for each, calls `generateFieldValue()` and `$entity->set($field, $newValue)`.
   - on error it logs to the `field_token_value` channel and shows a warning message; it does not
     abort the save.
3. `FieldValueGenerator::generateFieldValue($entity, $settings)`:
   - maps the entity type to a token type via `token.entity_mapper`
     (`getTokenTypeForEntityType()`);
   - `$this->token->replace($settings['field_value'], [$token_type => $entity], ['clear' => $settings['remove_empty']])`.

So the token context is always the **entity being saved**, and `remove_empty` maps directly to
Token's `clear` option.

## Calling it yourself

```php
$gen = \Drupal::service('field_token_value.field_value_generator');
$gen->generateFieldValueForEntity($node);   // populates all field_token_value fields on $node
// or resolve a single string against an entity:
$value = $gen->generateFieldValue($node, ['field_value' => '[node:title]', 'remove_empty' => TRUE]);
```

## Consequences an agent should know

- The value is **derived on save**, not live — editing a source field only updates the token
  field when the entity is next saved.
- Only fields whose type is provided by `field_token_value` are touched; other fields are ignored.
- The widget stores nothing meaningful itself (hidden element); the presave is the source of truth.
- Because it runs on presave for every entity type, a token that isn't valid for the entity's
  token type simply resolves empty (and is cleared if `remove_empty` is on).
