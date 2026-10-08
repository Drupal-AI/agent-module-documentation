# Machine Name — agent index

A `machine_name` field type (+ widget + formatter + uniqueness constraint) for storing a short
machine-readable identifier on any fieldable entity. Core-only, no permissions, no config UI, no Drush.

- **Adding & configuring the field, widget settings (Editable / Unique), the formatter, and how uniqueness is validated** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type id `machine_name` → `varchar(64)`, NOT NULL, default `''`, indexed. Default widget/formatter
  both `machine_name`.
- Widget renders core `#type = 'machine_name'`; settings `editable` (default FALSE) and `unique`
  (default TRUE), schema `field.widget.settings.machine_name`.
- Uniqueness is a field-item constraint `MachineNameUnique` (validator queries other entities with
  `accessCheck(FALSE)`); it only fires when the **default** form display's widget has `unique` on.
- Formatter output is `nl2br(Html::escape($value))`.
