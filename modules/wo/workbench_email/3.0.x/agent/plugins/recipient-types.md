<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: Recipient types

Plugin type `recipient_type`. Manager service `plugin.manager.recipient_type`
(`RecipientTypePluginManager`), alter hook `hook_recipient_type_info_alter`. Plugins live in
`src/Plugin/RecipientType/`, use the attribute `Drupal\workbench_email\Attribute\RecipientType`
(legacy annotation `Annotation/RecipientType` still supported), extend `RecipientTypeBase`, and
implement `RecipientTypeInterface`. A template's enabled recipient types are held in a
`RecipientTypePluginCollection`; each resolves to a list of email addresses via
`prepareRecipients(ContentEntityInterface $entity, TemplateInterface $template)`.

## Built-in recipient types (7)

| id | class | sends to | settings |
|---|---|---|---|
| `author` | Author | entity author/owner email | — |
| `last_revision_author` | LastRevisionAuthor | author of the previous revision | — |
| `role` | Role | all active users with a selected role | `roles: []` |
| `roles_with_access` | RolesWithAccess (extends Role) | active role-holders who also pass `$entity->access('update', $account)` | `roles: []` |
| `email` | EmailField | value(s) of selected email field(s) on the entity | `fields: []` (`{entity_type}:{field_name}`) |
| `entity_reference_user` | EntityReferenceUser | emails of users referenced in selected entity-reference fields | `fields: []` |
| `fixed_email` | FixedEmail | a fixed comma-separated address string | `recipients: ''` |

`Role` excludes the Anonymous and Authenticated roles from its options and only loads
`status = 1` (active) users. All resolved addresses across enabled types are merged,
de-duplicated and empty-filtered (`Template::getRecipients()`).

## Attribute parameters

`#[RecipientType(id, title, description, deriver = null, settings = [], status = false)]`.
`settings` is the default settings array; `status` is the default enabled flag.

## Writing a custom recipient type

1. Create `src/Plugin/RecipientType/MyType.php` extending `RecipientTypeBase`.
2. Add `#[RecipientType(id: 'my_type', title: new TranslatableMarkup('My type'),
   description: new TranslatableMarkup('...'), settings: ['foo' => ''])]`.
3. Implement `prepareRecipients()` to return an array of email strings.
4. Optional: override `buildConfigurationForm()` / `submitConfigurationForm()` for settings
   (implement the `configure` plugin form; the template form renders it in a vertical tab),
   and `calculateDependencies()` / `onDependencyRemoval()` for config it references.
5. Add a `workbench_email_recipient_type_settings.my_type` schema mapping if it has settings.

`RecipientTypeBase` supplies no-op defaults for the form, dependencies and an empty
`prepareRecipients()`.
