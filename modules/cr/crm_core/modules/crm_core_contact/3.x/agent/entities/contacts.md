<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Individual & Organization contact entities

## `crm_core_individual` (`src/Entity/Individual.php`)

`@ContentEntityType` extending `entity` module's `RevisionableContentEntityBase`; implements
`EntityPublishedInterface`, `IndividualInterface`. Traits: `EntityChangedTrait`,
`EntityOwnerTrait`, `EntityPublishedTrait`.

- Tables: `crm_core_individual` / `crm_core_individual_revision`.
- Keys: id `individual_id`, revision `revision_id`, bundle `type`, owner `uid`, published `status`,
  label `label`, uuid, langcode. `show_revision_ui = TRUE`, `permission_granularity = "bundle"`.
- `admin_permission = "administer crm_core_individual entities"`; access handler
  `IndividualAccessControlHandler`.
- Links under `/crm-core/individual/...` incl. `revision`, `revision-revert-form`,
  `version-history`. Local tasks via `Menu\ContactLocalTaskProvider`.
- Base fields (`baseFieldDefinitions`): `uid` (Owned by, entity_reference_autocomplete),
  `status` (Active, boolean_checkbox), `created`, `changed`, `name` (**Name** field,
  `name_default` widget), `label` (hidden string).
- `preSave()` — sets owner to anonymous (uid 0) when none set; sets revision user to the owner.
- `save()` calls `saveLabel()` — formats `name` via `name.formatter` (`default` layout); if empty,
  builds "Nameless {type} {id-or-random}" using `generateRandomString()`.
- `getPrimaryField($field)` reads the bundle's `primary_fields[$field]` map and returns
  `$this->get($realFieldName)`; convenience wrappers `getPrimaryAddress/Email/Phone()`.

## `crm_core_organization` (`src/Entity/Organization.php`)

Same base structure and traits. Differences:

- `name` is a plain **string** field (not a Name field); it is also the `label` entity key.
- `label()` returns the name, or `Nameless #@id`, then invokes
  `->alter('crm_core_organization_label', $label, $this)`.
- Same `getPrimaryField()` mechanism (via `getPrimaryFields()`), same `preSave()` owner defaulting.

## Bundle types

- **`crm_core_individual_type`** (`src/Entity/IndividualType.php`) — `@ConfigEntityType`,
  `config_prefix = "type"`, `bundle_of = crm_core_individual`,
  `admin_permission = "administer individual types"`. Exported keys: `name`, `type`, `description`,
  `locked`, `primary_fields`. `id()` returns `type`. `getPrimaryFields()/setPrimaryFields()`.
  `new_revision` defaults TRUE. Forms: `IndividualTypeForm` (default), core delete form.
- **`crm_core_organization_type`** (`src/Entity/OrganizationType.php`) — analogous,
  `admin_permission = "administer organization types"`; exported keys use `label`/`id`.

Config schema (`config/schema/crm_core_contact.schema.yml`): `crm_core_contact.type.*` and
`crm_core_contact.organization_type.*`, both with `name/label`, `type/id`, `description`,
`locked` (bool) and `primary_fields` (sequence of field-name strings).

## Primary fields — how they work

The bundle type stores a map like `primary_fields: { email: field_email, phone: field_phone,
address: field_address }`. `getPrimaryEmail()` etc. look up the mapped field name and return that
field item list, giving other submodules (User Sync, Match) a stable way to read a contact's email
without knowing the site's field naming.

## Templates & theming

`crm_core_contact.module` registers themes `crm_core_individual` / `crm_core_organization`
(`templates/crm-core-*.html.twig`) with `template_preprocess_*` adding `content`, `view_mode` and
bundle CSS classes, plus `theme_suggestions` of the form `{entity}__{view_mode}`,
`{entity}__{bundle}`, `{entity}__{id}` and combinations.
