<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity ID" entity-reference widget

## Install & enable

```bash
composer require drupal/entity_reference_number_widget
drush en entity_reference_number_widget -y
```

No composer requirements beyond Drupal itself (there is **no** `composer.json` in the project),
no sub-modules, no permissions, no Drush commands, no libraries.

## What it applies to

The single plugin `EntityReferenceNumberWidget`
(`src/Plugin/Field/FieldWidget/EntityReferenceNumberWidget.php`) is annotated:

- id **`entity_reference_number`**
- label *"Entity ID"*
- description *"A number field to enter the entity ID directly."*
- `field_types = { "entity_reference" }`

So it is selectable on **any core entity-reference field** (node, taxonomy term, user, media,
paragraphs, custom entities — anything using the `entity_reference` field type). It has **no**
formatter counterpart and **no** widget settings form (it does not override `settingsForm()` /
`settingsSummary()` / `defaultSettings()`).

## Enable it on a field

UI path: *Structure → (entity type) → (bundle) → Manage form display* → for the entity-reference
field, set the widget to **Entity ID** → Save. There are no gear/settings to configure.

Config equivalent (form display):

```bash
drush cset core.entity_form_display.node.article.default \
  content.field_ref.type entity_reference_number -y
drush cr
```

## Form element (`formElement()`)

```php
$referenced_entities = $items->referencedEntities();
$element += [
  '#type' => 'number',
  '#min' => 0,
  '#default_value' => isset($referenced_entities[$delta]) ? $referenced_entities[$delta]->id() : NULL,
];
return ['target_id' => $element];
```

- Renders a single HTML **`number`** input (browser-native numeric field), minimum **0**, no
  maximum (`// @todo set #max?` in source).
- `#default_value` is the **ID of the entity already referenced** at this delta, obtained via
  `$items->referencedEntities()` (core loads the targets). New/empty rows default to `NULL`.
- The element is returned under the **`target_id`** key, which is the main property of an
  entity-reference field item — so the entered number is stored as the reference's target ID.
- Multi-value fields work through core's normal per-delta widget handling (one number input per
  delta); this class does nothing multi-value-specific.

## Value handling (`massageFormValues()`)

```php
foreach ($values as $key => $value) {
  if (empty($value['target_id'])) {
    unset($values[$key]);
  }
}
return $values;
```

Any submitted delta whose `target_id` is empty (blank input, or `0` — `empty()` treats `0` as
empty) is **removed** before the values are written to the field item list, so empty rows do not
create stray references and clearing the input clears the reference.

## Validation & access (delegated to core)

- The widget adds **no** custom `#element_validate` and no `validateReferenceableEntities()` call.
  Whether the typed ID points to an **existing, referenceable** entity is enforced by core's
  entity-reference field validation (the `ValidReference` constraint on the field item, which uses
  the field's selection handler), not by this module.
- On display, references render through core's standard entity-reference formatting, which honors
  entity view access.

## Notes / caveats

- Because entry is by raw ID, there is no label lookup or autocomplete feedback — the editor sees
  only the number, and a typo yields a different (or invalid) reference caught at save-time
  validation. Best for workflows where IDs are already known.
- `#min => 0` and the `number` element restrict input to non-negative numbers on the client, but
  server-side validity still comes from core's field constraint.
