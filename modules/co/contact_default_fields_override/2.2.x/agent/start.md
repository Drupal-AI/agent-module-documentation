<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Default Field Override — agent index

info.yml name **Contact Default Field Override** (`contact_default_fields_override`), version **2.2.2**,
core `^8 || ^9 || ^10 || ^11`. Depends on core `contact` and `field_ui`.

Lets you override the **label**, **help text (description)** and **required** setting of the four
built-in `contact_message` base fields — `name`, `mail`, `subject`, `message` — **per contact form**.
Core does not expose these defaults for editing; this module surfaces them on each form's **Manage
fields** page and stores the overrides as third-party settings on the `contact.form.<id>` config entity.
No settings page (`configure: null`), no permissions of its own, no services beyond a route subscriber,
no Drush, no config schema.

## How it works

- **`contact_default_fields_override_entity_bundle_field_info()`** (`.module`): for `contact_message`
  bundles, builds a `BaseFieldOverride` from each overridable base field and applies `setLabel()` /
  `setDescription()` / `setRequired()` from the contact form's third-party settings (namespace
  `contact_default_fields_override`, keys `<field>_label`, `<field>_description`, `<field>_required`).
- **`contact_default_fields_override_form_alter()`**: on the `MessageForm`, re-applies `#title`,
  `#description`, `#required` for the fields (needed because `name` and `mail` are not built via the
  `BaseFieldOverride` on the message form).
- **`RouteSubscriber`** (`src/Routing/RouteSubscriber.php`, priority `-1000`): swaps the controller of
  route `entity.contact_message.field_ui_fields` to
  `ContactMessageFieldConfigListController::listing`, which appends the four overridable fields as rows
  with an **Edit** link (access requirements of the field_ui route are unchanged).
- **Override form** — route `contact_default_fields_override.overrideform` at
  `/admin/structure/contact/manage/{contact_form}/override/{field_name}`, permission
  **`administer contact forms`**, form `src/Form/BaseFieldOverrideForm.php`. Fields: `label`
  (textfield, required), `description` (textarea; label mentions token support + allowed HTML tags),
  `required` (checkbox). Submit writes the three third-party settings onto the contact form and saves it.

## Overridable field list

Defaults to `['name', 'mail', 'subject', 'message']` from
`contact_default_fields_override_get_fields_to_override()`. Modules can change the set via
**`hook_contact_default_fields_override_alter(array &$overidable_fields)`** (see
`contact_default_fields_override.api.php`) — the hook **replaces** the array, so re-list every field you
want to keep.

## Storage

Third-party settings on the `contact.form.<id>` config entity, namespace `contact_default_fields_override`:
`name_label`, `name_description`, `name_required`, `mail_label`, … `message_required` (`_required`
stored as `1`/`0`).

## Sibling docs

- Task-oriented usage → [../usage.md](../usage.md)
- Human setup guide → [../human-docs/index.md](../human-docs/index.md)
