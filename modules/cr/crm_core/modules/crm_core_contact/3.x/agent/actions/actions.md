<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact action plugins

Three `@Action` plugins with `type = "crm_core_contact"` live in
`src/Plugin/Action/`. They are configurable actions (VBO/bulk-operations style) intended to be run
over a selection of contacts from the contact list. Each entity list is itself gated by an
`administer crm_core_(individual|organization) entities` permission, which is the effective gate
for reaching these actions. All three override `access()` to return `AccessResult::allowed()`.

## `SendEmailAction` (id `send_email_action`)

- Config form: `subject` (textfield) + `message` (textarea).
- `executeMultiple()` runs Drupal **token** replacement (`clear => TRUE`) with
  `['crm_core_contact' => $contact]` data on subject and message, then sends via
  `plugin.manager.mail->mail('crm_core_contact', 'send_email', $contact->getPrimaryEmail()->value,
  $langcode, $params)`. `crm_core_contact_mail()` maps the params to subject/body.
- The recipient address comes from the contact's **primary email** field.

## `MergeContactsAction` (id `merge_contacts_action`)

- Config form builds a table letting the admin pick one primary contact and, per field, which
  contact's value wins; requires all selected contacts to share one type.
- `executeMultiple()` copies chosen field values onto the primary contact, re-points activity
  participants (when `crm_core_activity` is enabled) and rebuilds `relation` entities (when the
  contributed `relation` module is enabled), creates path aliases for the merged ids, then deletes
  the merged contacts and shows a summary message.
- Note: this action references legacy/optional symbols — `Drupal\crm_core_contact\Entity\Contact`
  (no such entity class ships; the real entities are Individual/Organization),
  `Drupal\relation\Entity\Relation` and the removed `path.alias_storage` service — so it is
  effectively usable only on sites that provide those, and is largely vestigial on a stock install.

## `JoinIntoHouseholdAction` (id `join_into_household_action`)

- Creates a `household`-type contact and relates each selected contact to it using the contributed
  **relation** module (`relation_type = crm_member`). Also references the legacy `Contact` class.
  Requires the `relation` module and a `household` contact type to function.

## Practical note

`SendEmailAction` works on a stock install; the merge and household actions assume the contributed
`relation` module (and, for merge, activities/path-alias support). Treat the latter two as
integration hooks rather than out-of-the-box features.
