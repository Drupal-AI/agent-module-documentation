<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM configuration

## Install / enable
`composer require drupal/crm` then `drush en crm`. Pulls in address, inline_entity_form, name,
primary_entity_reference and core datetime/image/telephone. `crm_install()` locks the `person`
contact type (state `crm.contact_type.locked`) and creates an initial **organization** contact
from the site name/mail with a primary email method. Optional demo: `drush recipe
modules/contrib/crm/recipes/crm_simpsons`. Config UI lives under `/admin/config/crm` and
`/admin/structure/crm`; the `configure` link is `entity.crm_contact_type.collection`.

## `crm.settings` (config object, `config/schema/crm.schema.yml`)
One key: `theme` (string, default `admin`). Consumed by
`Theme/ThemeNegotiator.php` (service `theme.negotiator.admin_theme.crm`, priority -20) which
forces the configured admin theme on CRM routes. `FullyValidatable`.

## User Contact Mapping subsystem
Links Drupal user accounts to person contacts and, optionally, mirrors CRM fields onto the user
entity. Config object `crm.user_contact_mapping.settings`
(`config/install/crm.user_contact_mapping.settings.yml`):
- `display_name` (bool) — override the user's display name with the mapped contact's name
  (gated by `alter crm user display name`; see `NameHooks`, `UserContactDisplaySyncService`).
- `fire_event_user_insert` (bool) — dispatch `UserContactMappingEvent` on user insert.
- `lookup_contact` (bool) — find an existing contact by the user's email.
- `auto_create_user_contact_mapping` (bool) — create a contact when none is found.
- `enable_mapped_fields_on_form` (bool, default TRUE) — show mapped CRM fields on user forms.
- `field_mappings` (sequence of `crm.user_field_mapping`): each has `enabled`,
  `contact_field_name`, `user_field_label`, `user_field_machine_name`, `form_display`,
  `view_display`, `access_control_plugin` (a `crm_user_field_access` plugin id).

Forms & routes:
- `crm.user_contact_mapping.settings` (`/admin/config/crm/user/settings`,
  `UserContactMappingSettingsForm`, requires `administer crm`). Its `validateForm()` refuses to
  disable both `lookup_contact` and `auto_create_user_contact_mapping` while any mapped field is
  shown on a user form.
- `crm.user_contact_mapping.field` (`/admin/config/crm/user/field`, `UserContactFieldForm`) —
  edit the field mappings.
- `entity.crm_user_contact_mapping.collection` — list of user↔contact mappings.

Event flow: `UserContactMappingSubscriber` (event_subscriber `crm.user_create`) reacts to user
creation using the settings above; `UserContactMappingSettingsConfigSubscriber` reacts to
settings config changes. Services: `crm.user_contact_mapping`
(`UserContactMappingService`, `UserContactMappingInterface`), `crm.user_field_mapping`
(`UserFieldMappingService`), `crm.user_mapped_field` (`UserMappedFieldService`),
`crm.user_contact_display_sync` (`UserContactDisplaySyncService`),
`crm.user_contact_field_values_storage` (`UserContactFieldValuesStorage`).

## `crm_user_field_access` plugin type
Controls access to mapped CRM fields exposed on user entities. Manager
`plugin.manager.crm_user_field_access` (`UserFieldAccessManager`, dir
`Plugin/crm/UserFieldAccess`, attribute `#[UserFieldAccess(id, label, description?, deriver?)]`,
interface `UserFieldAccessInterface`, base `UserFieldAccessBase`). Alter hook
`hook_crm_user_field_access_info_alter()`. Built-in plugins: `user_entity`
(`UserEntityFieldAccess`) and `contact_entity` (`ContactEntityFieldAccess`). Select one per
mapping via `access_control_plugin`.

## Other config
- `crm_relationship_type` config carries the per-relationship rules (asymmetric, per-side
  contact-type restrictions, cardinality limits, valid-contact allow-lists) — see the model doc.
- `crm.crm_contact_type.*.third_party.crm:name_format` — person name format.
- Optional config (`config/optional/`) wires Comment (`comment.type.crm_contact`), a Views
  listing (`views.view.crm_contact`), a Search page (`search.page.crm_search`, plugin
  `crm_contact_search`) and a REST resource (`rest.resource.entity.crm_contact`) when the
  matching modules are present.
