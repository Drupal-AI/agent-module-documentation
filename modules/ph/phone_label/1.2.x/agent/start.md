<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phone Label (phone_label) — agent index

Adds an optional label to a telephone value by providing a **new field type** `phone_label`
("Labelled telephone number") that **extends core's `telephone` field type**, plus a matching
widget and a `tel:` link formatter. Package `Field types`. Depends only on core **`telephone`**.
Core requirement `^10.3 || ^11`, PHP `>=8.1.0`. License GPL-2.0-or-later. Version 1.2.0.

- **The field type, widget, formatter, their settings, and the config schema** →
  [fields/labelled-telephone.md](fields/labelled-telephone.md)

## What it actually is

Three plugins in `src/Plugin/Field/`, no routes, no `.services.yml`, no permissions, no `.module`
file, no hooks, no Drush, no submodules:

- **Field type** `PhoneLabelItem` (id `phone_label`, label *"Labelled telephone number"*),
  `extends TelephoneItem`. Adds a `title` varchar(256) column and a `title` string property beside
  core's `value`. Per-field setting `title` = "Allow label override" (radios: `DRUPAL_DISABLED` /
  `DRUPAL_OPTIONAL` / `DRUPAL_REQUIRED`, default Disabled). `default_widget = phone_label_default`,
  `default_formatter = basic_string` (core string formatter — the module's own formatter is opt-in).
- **Widget** `PhoneLabelDefaultWidget` (id `phone_label_default`), `extends TelephoneDefaultWidget`.
  Adds a `title` Label textfield (`#maxlength 255`, shown/required per the field's `title` setting)
  and a `placeholder_title` setting (placeholder for that Label input).
- **Formatter** `PhoneLabelFormatter` (id `phone_label`, label *"Telephone link with label"*),
  `extends FormatterBase`, `field_types = { phone_label }`. Renders each value as a `#type => 'link'`
  with `#title = title ?: value` and URL `tel:` + `rawurlencode(number)`.

## Mechanism (from source)

- `PhoneLabelItem::schema()` returns `title` (varchar 256) + `value` (varchar 256).
  `propertyDefinitions()` adds a `title` string on top of `TelephoneItem::propertyDefinitions()`.
- `PhoneLabelDefaultWidget::formElement()` builds core's telephone element, then adds the Label
  field with `#access` = (field `title` setting !== Disabled) and `#required` = (setting ===
  Required && the number is required); wraps the element in a `fieldset` when the label shows, and
  labels the number field on multi-value fields.
- `PhoneLabelFormatter::viewElements()` strips whitespace from the number, inserts a `-` after the
  first char when it is ≤ 5 chars long, and emits a link whose text is escaped by core's link
  generator; merges any `$item->_attributes`. No user-supplied URL, no external HTTP, no raw markup.
- Config schema `config/schema/phone_label.schema.yml`: `field.field_settings.phone_label`,
  `field.formatter.settings.phone_label` (empty), `field.widget.settings.phone_label_default`
  (`placeholder`, `placeholder_title`).

## Operate it

1. `drush en phone_label -y` (pulls core `telephone`).
2. Add a field of type **Labelled telephone number** to a bundle (it is a *new field*, not a
   setting on an existing telephone field). Set **Allow label override** = Optional/Required in the
   field settings.
3. On **Manage form display**, the *Labelled phone number* widget shows a Label input; set its
   placeholder if wanted.
4. On **Manage display**, pick **Telephone link with label** to get the `tel:` link using the label.

## Caveats

- It is a **separate field type**, so there is no in-place conversion of an existing core
  `telephone` field — add a new field and migrate values.
- The field type's `default_formatter` is core `basic_string`; you must explicitly choose the
  *Telephone link with label* formatter to render the `tel:` link + label.
