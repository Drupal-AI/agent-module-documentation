<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# email_message field type, widget & formatter

Source: `src/Plugin/Field/FieldType/EmailMessageItem.php`,
`src/Plugin/Field/FieldWidget/EmailMessageDefaultWidget.php`,
`src/Plugin/Field/FieldFormatter/EmailMessageDefaultFormatter.php`,
`config/schema/email_message.schema.yml`.

## Install / enable

`drush en email_message`. Enable core `field` and `text` (text is required in practice even
though `info.yml` lists only `field`). Then add the field on any fieldable entity via
*Manage fields* → choose **Email message**. No settings form, no permissions, no config
objects of its own to install.

## Field type — `EmailMessageItem` (id `email_message`)

Extends core `text`'s `TextLongItem`, so the body is a standard long, format-filtered text value.
Attribute: `default_widget: "email_message_default"`, `default_formatter:
"email_message_default_formatter"`.

- `schema()` — takes the parent `text_long` columns (`value`, `format`) and adds
  `subject` (`type: text`, `size: normal`).
- `propertyDefinitions()` — adds a `subject` string property, `setRequired(TRUE)`.
- `isEmpty()` — empty unless BOTH the body (parent check) and a non-empty `subject` are present.
  So a subject alone, or a body alone, counts as empty.
- `generateSampleValue()` — parent sample plus a random 100-char `subject`.
- `getEmailSubject(): string` — `$this->get('subject')->getString()`.
- `getEmailBody(): string` — `$this->get('processed')->getString()` (the filtered/rendered body,
  not the raw `value`).

Stored columns per delta: `value` (body), `format` (text format id), `subject`.

## Widget — `EmailMessageDefaultWidget` (id `email_message_default`)

Extends `TextareaWidget`. `formElement()` calls the parent (body textarea), then:

- appends `fieldset` to `#theme_wrappers` and sets `#title_display => 'before'`;
- adds `subject` as `#type => 'textfield'`, title "Email subject", `#weight => -10`
  (renders above the body), default `$items[$delta]->subject`.

The field's configured label stays as the fieldset/group title so multiple email-message fields
on one entity remain distinguishable (covered by the kernel test `testWidgetKeepsEachFieldLabel`).

## Formatter — `EmailMessageDefaultFormatter` (id `email_message_default_formatter`, label "Default")

Extends `FormatterBase`. `viewElements()` builds, per item, a `container` with class
`email-message` holding:

- `subject`: `inline_template` `{{ value|nl2br }}` with `#context.value = $item->subject`
  (Twig autoescapes the value, then converts newlines to `<br>`);
- `body`: `processed_text` with `#text = $item->value`, `#format = $item->format`,
  `#langcode = $item->getLangcode()` (rendered through the text format's filters).

No formatter settings (schema `field.formatter.settings.email_message_default_formatter` is an
empty mapping).

## Config schema

`config/schema/email_message.schema.yml`:

- `field.storage_settings.email_message` and `field.field_settings.email_message` reuse
  `field.*.text_long`.
- `field.value.email_message` — mapping of `value` (text), `format` (string), `subject` (label);
  this is what lets a configured **default value** (subject + body + format) validate.
- `field.widget.settings.email_message_default` reuses `field.widget.settings.text_textarea`.
- `field.formatter.settings.email_message_default_formatter` — empty mapping.

## Using the value in code

```php
$item = $entity->get('field_mail')->first();
$subject = $item->getEmailSubject();   // plain subject string
$body    = $item->getEmailBody();      // processed/rendered body
```

Feed those into your own `hook_mail()` / Symfony Mailer call — the module itself does not send.
