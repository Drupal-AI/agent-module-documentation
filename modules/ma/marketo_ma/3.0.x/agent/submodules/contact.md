<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# marketo_ma_contact & marketo_ma_contact_block

## marketo_ma_contact
Integrates core Contact forms with Marketo. Deps: `marketo_ma`, `drupal:contact`,
`contact_storage:contact_storage`.

- `hook_entity_operation` adds a **Marketo configuration** operation to each contact form, route
  `marketo_ma_contact.contact.configuration` at `/admin/structure/contact/manage/{contact_form}/marketo`
  (permission `administer marketo`, form `Form\MarketoMaContactConfiguration`). It stores, as the contact
  form's third-party settings under `marketo_ma_contact`: `enabled` (0/1) and `mapping`
  (contact field → Marketo field id).
- `hook_contact_message_insert` → `Hooks\ContactMessageInsert::contactMessageInsert()`. When the form's
  `enabled` third-party setting is `1` and a mapping exists, it builds a `Lead` from the mapped message
  fields (intersected with the site's enabled Marketo fields) and calls `marketo_ma` `updateLead()`.
  Reaching Marketo requires the REST tracking method / a form id. `contact_storage` is required so
  submitted messages carry loadable field values.

## marketo_ma_contact_block
Deps: `marketo_ma:marketo_ma_contact`, `contact_block:contact_block`. Provides block plugin
`marketo_ma_contact_block` extending `contact_block`'s `ContactBlock`. Its config form adds a text value
per non-base field of the selected contact form; `createContactMessage()` injects those fixed values into
the created contact message before it is saved — i.e. hidden/preset Marketo-mapped values (e.g. a campaign
or lead-source tag) that then flow through `marketo_ma_contact`'s message-insert capture.
