<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Message field (email_message) — agent index

A field-type module: one field type storing an **email subject + formatted body** as a single
field, with a matching widget and formatter. Package `Field types`. Core `^10.2 || ^11 || ^12`.
License GPL-2.0-or-later. Version-dir 1.0.x (installed release 1.0.0-alpha3).

Despite the name it **stores/displays only — it sends no mail**. No routes, permissions,
services, hooks, `.module`, `.install`, config form, submodules or Drush. Config schema only.

## Dependencies

- `info.yml` declares `drupal:field`.
- Also requires core **`text`**: the field type/widget extend `text` module classes
  (`TextLongItem`, `TextareaWidget`). `text` is a real runtime dependency though info.yml omits
  it (the test enables `text` + `filter` explicitly).

## What it provides

- **Field type** `email_message` (`src/Plugin/Field/FieldType/EmailMessageItem.php`, extends
  `TextLongItem`) — the `text_long` body plus a required `subject` text column. Default widget
  `email_message_default`, default formatter `email_message_default_formatter`.
- **Widget** `email_message_default` (`.../FieldWidget/EmailMessageDefaultWidget.php`, extends
  `TextareaWidget`) — body textarea wrapped in a fieldset with an "Email subject" textfield above.
- **Formatter** `email_message_default_formatter` (`.../FieldFormatter/EmailMessageDefaultFormatter.php`,
  extends `FormatterBase`) — subject via `nl2br` then body via `processed_text`, in an
  `email-message` container.
- **Config schema** `config/schema/email_message.schema.yml` (storage/field settings reuse
  `text_long`; `field.value.email_message` adds `subject`; widget reuses `text_textarea`).

## Solution docs

- **Field type, widget, formatter, schema, install, and code access to the value** →
  [fields/field.md](fields/field.md)
