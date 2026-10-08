<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter field (formatter_field) — agent index

A **field type whose value is a formatter choice** for another field, applied per entity.
Package `Field types`. Version **2.0.0**. Core `^8 || ^9 || ^10 || ^11`. Depends only on core
**`field`**. No Composer package, no routes, no permissions, no services, no Drush, no config
objects, no submodules.

- **The field type, widget, both formatters, settings, config schema, and the render
  mechanism** → [fields/formatter.md](fields/formatter.md)

## What it actually provides (four plugins, all in `src/Plugin/Field/`)

- **Field type** `formatter_field_formatter_type` (`FieldType/FormatterItem.php`, label
  *"Formatter Item"*): stores `type` (varchar 64 = a formatter plugin id) and `settings`
  (serialized formatter settings). One field setting, `field`, names the **target** field on the
  same bundle whose display this value controls.
- **Widget** `formatter_field_formatter_widget` (`FieldWidget/FormatterWidget.php`): an editor
  picks a formatter (only those `::isApplicable()` to the target field type; `formatter_field_from`
  excluded) plus that formatter's own settings, via AJAX.
- **Formatter** `formatter_field_from` (`FieldFormatter/FromFieldFormatter.php`, *"Formatter from
  field"*): set on the **target** field's display. Finds the formatter field pointing at it, reads
  the per-entity `type`/`settings`, builds the real formatter via `FormatterPluginManager` and
  delegates `prepareView()`/`viewElements()`. Attached to all field types by
  `formatter_field_field_formatter_info_alter()` in `formatter_field.module` (annotation declares
  `field_types = {}`).
- **Formatter** `formatter_field_default_formatter` (`FieldFormatter/DefaultFormatter.php`,
  *"Default"*): debug display of the formatter field itself, `type` + `var_export(settings)` via
  `#plain_text`.

## Mechanism in one line

Drupal picks display per bundle/view-mode; this module moves that choice into a per-entity field
value, so an editor selects (e.g.) the image style on the node form. Because it is a field value it
is revisioned and translatable.

## Governance point to raise

This deliberately hands display control to whoever can edit the field on the entity — right for
marketing/landing bundles, wrong for a strictly templated catalogue. Scope the formatter field to
the bundles that need it and use field access to constrain who edits it. The editor can only choose
formatters core already deems applicable to the target field type.
