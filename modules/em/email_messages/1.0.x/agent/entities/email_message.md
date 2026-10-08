<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `email_message` config entity

Reusable email template. Class `Drupal\email_messages\Entity\EmailMessage`
(`@ConfigEntityType`), interface `EmailMessageInterface`.

## Definition (annotation)

- `id = "email_message"`, `config_prefix = "email_message"`, `admin_permission = "administer email messages"`.
- `entity_keys`: id=`id`, label=`subject`, uuid=`uuid`.
- `config_export`: `id`, `subject`, `message`, `log_message`.
- Handlers: `list_builder` = `EmailMessageListBuilder`; forms `add`/`edit` = `EmailMessageForm`,
  `delete` = core `EntityDeleteForm`.
- Properties/getters: `getSubject()`, `getMessage()` (returns `['value'=>..., 'format'=>...]`),
  `logsMessage()` (bool cast of `log_message`), `logMessage($log)` setter.

## Config schema (`config/schema/email_messages.schema.yml`)

`email_messages.email_message.*` (type `config_entity`): `id` (string), `subject` (label),
`message` (`text_format`), `log_message` (boolean).

## Form (`src/Form/EmailMessageForm.php`, extends `EntityForm`)

Fields: `subject` (textfield, required, maxlength 255), `id` (machine_name, exists =
`EmailMessage::load`, disabled once created), `message` (`text_format`, default format
`basic_html`; description tells authors to use `@variable` for custom tokens), `log_message`
(checkbox). `save()` adds a status message and redirects to the collection.

## Routes (`email_messages.routing.yml`) — all require `administer email messages`

| Route | Path | Purpose |
|---|---|---|
| `entity.email_message.collection` | `/admin/structure/email-message` | list (`_entity_list`) |
| `entity.email_message.add_form` | `/admin/structure/email_message/add` | add form |
| `entity.email_message.edit_form` | `/admin/structure/email-message/{email_message}` | edit form |
| `entity.email_message.delete_form` | `/admin/structure/email-message/{email_message}/delete` | delete confirm |

Menu link `entity.email_message.overview` (under `system.admin_structure`) and action link
`entity.email_message.add_form` (on the collection) are declared in the `*.links.*.yml` files.

## List builder (`EmailMessageListBuilder`)

Adds `subject` (entity label) and `id` (machine name) columns to the config-entity listing.

Notes: `message`/`subject` are authored HTML with `@variable` placeholders resolved at send time by
the manager (see ../api/manager.md). Being config, messages are translatable via config translation.
