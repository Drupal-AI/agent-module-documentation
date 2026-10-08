<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# field_validation — programmatic API

## Create a rule set with a rule (drush php:eval / code)

The config entity is `field_validation_rule_set` (class
`Drupal\field_validation\Entity\FieldValidationRuleSet`, implements
`EntityWithPluginCollectionInterface`). Build `field_validation_rules` as a map keyed by a
generated uuid; each entry needs at least `id` (plugin id), `uuid`, `field_name`, `column`,
and `data`. On save the module normalises the entry (re-keys by the rule uuid and fills
`data` defaults from the plugin's `defaultConfiguration()`).

```php
use Drupal\field_validation\Entity\FieldValidationRuleSet;

$uuid = \Drupal::service('uuid')->generate();
FieldValidationRuleSet::create([
  'name' => 'article_body_length',
  'label' => 'Article body length',
  'entity_type' => 'node',
  'bundle' => 'article',
  'field_validation_rules' => [
    $uuid => [
      'id' => 'length_constraint_rule',   // the FieldValidationRule plugin id
      'uuid' => $uuid,
      'title' => 'Body length 5–100',
      'weight' => 0,
      'field_name' => 'body',
      'column' => 'value',
      'error_message' => '',
      'roles' => [],
      'condition' => [],
      'data' => ['validate_mode' => 'default', 'min' => '5', 'max' => '100'],
    ],
  ],
])->save();
```

For a `regex_constraint_rule` swap the `data` to
`['validate_mode' => 'default', 'pattern' => '/^[A-Z]{3}$/', 'message' => 'Bad format']`.

## Read / inspect a rule set

```php
$set = \Drupal\field_validation\Entity\FieldValidationRuleSet::load('article_body_length');
$set->get('entity_type');            // 'node'
$set->get('bundle');                 // 'article'
foreach ($set->get('field_validation_rules') as $rule) {
  // $rule['id'], $rule['field_name'], $rule['column'], $rule['data']
}
```

`load()` / `loadMultiple()` come from the storage
`\Drupal::entityTypeManager()->getStorage('field_validation_rule_set')`. As pure config you
can also read it with `drush config:get field_validation.rule_set.<name>`.

## Plugin manager

Service `plugin.manager.field_validation.field_validation_rule` (`FieldValidationRuleManager`):
`getDefinitions()` lists every rule id/label; `createInstance($id, $config)` builds a rule.
Rule instances expose `getConfiguration()` (returns `id`, `uuid`, `title`, `weight`,
`field_name`, `column`, `error_message`, `roles`, `condition`, `data`) and
`setConfiguration()`.

## When validation runs

Rules are added as extra field constraints, so they fire wherever core validates the entity
— entity forms and `$entity->validate()` / `$entity->save()` via the typed-data validator.
A violated rule produces a constraint violation that blocks the save/form submit and shows
the rule's `error_message` (or the constraint default).
