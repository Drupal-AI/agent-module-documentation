<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Subclassing the date_recur field type

The whole submodule is three small parts — a subclassed field-type plugin, two info-alter
hooks, and a schema that re-uses the parent's.

## 1. The field-type plugin

`Drupal\date_recur_subfield\Plugin\Field\FieldType\DateRecurSubItem` extends `DateRecurItem`
(id `date_recur_sub`, label "Date Recur Sub"). It keeps the parent's default widget
`date_recur_basic_widget` and formatter `date_recur_basic_formatter`, and only adds a `color`
value on top of everything it inherits:

```php
public static function propertyDefinitions(FieldStorageDefinitionInterface $fd): array {
  $properties = parent::propertyDefinitions($fd);
  $properties['color'] = DataDefinition::create('string')
    ->setLabel(new TranslatableMarkup('Color'))->setRequired(FALSE);
  return $properties;
}
public static function schema(FieldStorageDefinitionInterface $fd): array {
  $schema = parent::schema($fd);
  $schema['columns']['color'] = ['description' => 'Color', 'type' => 'varchar', 'not null' => FALSE, 'length' => '16'];
  return $schema;
}
```

Always call `parent::` first, then add — this preserves the RRULE/timezone/infinite columns,
the occurrence handling, and the `DateRecurRrule` / `DateRecurRuleParts` validation.

## 2. Re-register widgets & formatters (`date_recur_subfield.module`)

New field types are not automatically offered the parent's widgets/formatters, so two alter
hooks append `date_recur_sub` to every widget/formatter that lists `date_recur`:

```php
function date_recur_subfield_field_field_widget_info_alter(array &$info): void {
  foreach ($info as $id => $w) {
    if (in_array('date_recur', $w['field_types'], TRUE)) { $info[$id]['field_types'][] = 'date_recur_sub'; }
  }
}
// …and the identical date_recur_subfield_field_field_formatter_info_alter().
```

## 3. Config schema reuse (`config/schema/date_recur_subfield.schema.yml`)

Each schema key just points at the parent's type:

```yaml
field.value.date_recur_sub:            { type: field.value.date_recur }
field.storage_settings.date_recur_sub: { type: field.storage_settings.date_recur }
field.field_settings.date_recur_sub:   { type: field.field_settings.date_recur }
```

That is the entire recipe for a production module that needs its own recurring-date field with
extra stored data.
