# Configure contact storage, per-form extras & the message list

Contact Storage adds no big settings form of its own — most configuration lives on each
**core contact form** as third-party settings, plus one global flag. Everything hangs off
**Admin → Structure → Contact** (`/admin/structure/contact`).

## The stored messages (why the module exists)

`hook_entity_type_alter()` turns core's throwaway `contact_message` into a stored,
fieldable content entity: SQL storage, `base_table: contact_message`, integer `id` key,
label = `subject`, and extra base fields `created`, `uid`, `ip_address`
(`hook_entity_base_field_info`). Contact forms are the bundles, so you can add ordinary
Drupal fields to a form and they persist on each message.

## Message list & routes

| Route | Path | Purpose |
|---|---|---|
| `entity.contact_message.collection` | `/admin/structure/contact/messages` | List all stored messages (the `configure` route; a Views page `contact_messages`) |
| `entity.contact_message.canonical` | `/admin/structure/contact/messages/{id}` | View one message |
| `entity.contact_message.edit_form` | `/admin/structure/contact/messages/{id}/edit` | Edit a message (`MessageEditForm`) |
| `entity.contact_message.delete_form` | `.../{id}/delete` | Delete one |
| `entity.contact.multiple_delete_confirm` | `/admin/structure/contact/messages/delete` | Bulk delete |
| `entity.contact_form.clone_form` | `/admin/structure/contact/manage/{form}/clone` | Clone a whole contact form |
| `entity.contact_form.disable` / `.enable` | `.../manage/{form}/disable` \| `/enable` | Disable/enable one form |
| `contact_storage.settings` | `/admin/structure/contact/settings` | Global setting (below) |

The list is filterable per form: an "View messages" operation on each contact form links to
the view with `?form={contact_form_id}`.

## Per-form third-party settings (`contact.form.*` → `third_party.contact_storage`)

Added to the core contact-form add/edit form. Stored via `setThirdPartySetting('contact_storage', …)`:

| Setting key | Form field | Default | Meaning |
|---|---|---|---|
| `submit_text` | Submit button text | `Send message` | Overrides the submit label |
| (URL alias) | Add URL alias | — | Creates a `path_alias` for the form (must start with `/`); deleted when the form is deleted |
| `disabled_form_message` | Default disabled contact form message | `This contact form has been disabled.` | Shown when the form is disabled |
| `show_preview` | Allow preview | `TRUE` | Show/hide the preview button |
| `maximum_submissions_user` | Maximum submissions | `0` | Per-user (per-IP for anon) submit cap; `0` = unlimited. Enforced by the `ConstactStorageMaximumSubmissions` constraint on the `message` field |
| `page_autoreply_format` | (reply field format) | `plain_text` | Text format applied to the autoreply |
| `redirect_uri` | (legacy) | — | Old post-submit redirect; migrated to core's own contact-form `redirect` property by an update hook, still read for disabled-form redirect |

Set in code, e.g.:

```php
$form = \Drupal\contact\Entity\ContactForm::load('feedback');
$form->setThirdPartySetting('contact_storage', 'submit_text', 'Send enquiry');
$form->setThirdPartySetting('contact_storage', 'maximum_submissions_user', 3);
$form->save();
```

## Global setting — `contact_storage.settings`

One key only. Edit at `/admin/structure/contact/settings` or `drush cset`:

| Key | Default | Meaning |
|---|---|---|
| `send_html` | `false` | Send contact mail as HTML (needs the Swiftmailer module + the bundled `swiftmailer--contact.html.twig` template). When on, a dedicated `ContactMessageViewBuilder` is used. |

```
drush cset contact_storage.settings send_html true
```

Saving this config clears cached entity-type definitions (`ContactStorageSettingsFormSave`
subscriber) because it swaps the message view builder. Schema:
`config/schema/contact_storage.schema.yml`. The module also ships a
`contact_storage_options_email` field type (widget `options_select`, formatter
`list_default`) for mapping selectable options to extra email recipients via `hook_mail_alter`.
