<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM entity & relationship model

CRM defines three content entity types, three bundle-config types, plus a method-detail
config type and a user-mapping content entity. All content types are revisionable
(`show_revision_ui: TRUE`), non-translatable, and implement `EntityPublishedInterface`
(`status` key). Admin permission for every type is `administer crm`.

## crm_contact (`src/Entity/Contact.php`)
Content entity, `base_table: crm_contact`. Bundle entity type `crm_contact_type`. Default
bundles: **person, household, organization**. Base fields:
- `name` (string, required, label key) — auto-filled with `"<type> <uuid>"` in `preSave()` if empty.
- `emails`, `telephones`, `addresses` — `primary_entity_reference` fields (cardinality -1)
  targeting `crm_contact_method` bundles email/telephone/address, edited with the
  `primary_entity_reference_inline_form` (IEF) widget; one item can be flagged primary.
  `postSave()` back-fills each referenced method's `crm_contact` field with the contact id.
- `status` (boolean, published key), `start_date` / `end_date` (datetime, date-only).
- `age` (computed integer, `Field/AgeFieldItemList.php`) — derived from a date; formatter `crm_age`.
- `relationship_statistics` (computed `crm_relationship_statistics`, cardinality unlimited) —
  per-type relationship counts; formatter `crm_relationship_statistics_default`.
- `created`, `changed`.

Handlers: `ContactListBuilder` (filterable list at `/crm/contact`, query uses `accessCheck(TRUE)`),
`ContactViewsData`, `ContactAccessControlHandler`, `ContactForm`. Canonical route
`/crm/contact/{crm_contact}`; also `/relationship` and `/comment` tabs and full revision routes.
`collection_permission: access crm`.

## crm_contact_method (`src/Entity/ContactMethod.php`)
Content entity, `base_table: crm_contact_method`. Bundle type `crm_contact_method_type`
(email, telephone, address). Base fields: `detail` (entity_reference → `crm_method_detail`),
`status`, `crm_contact` (entity_reference → `crm_contact`, the parent), `created`, `changed`.
The bundle-specific value field (email / telephone / address) is a configured field on each
bundle (see `config/install/field.field.crm_contact_method.*`). Label key is the id.
Access is delegated to the parent contact (see access doc).

## crm_relationship (`src/Entity/Relationship.php`)
Content entity, `base_table: crm_relationship`. Bundle type `crm_relationship_type`. Base fields:
- `contacts` (entity_reference → crm_contact, **cardinality 2, required**) — the two endpoints.
- `contact_a` / `contact_b` (computed, `Field/RelationshipContactsItemList.php`) — positional views.
- `status`, `start_date`/`end_date`, `created`, `changed`.

Entity constraints: `RelationshipContacts` (rejects a relationship whose two contacts are the
same, and enforces per-side valid-contact / contact-type rules) and `RelationshipLimit`
(`RelationshipLimitConstraintValidator`: rejects a new relationship when the contact already
holds `limit_a`/`limit_b` relationships of that type in that position; `limit_active_only`
counts only active ones).

## Bundle-config entity types
- **crm_contact_type** (`ContactType`, config prefix `crm.crm_contact_type`) — label,
  description, help, `new_revision`, optional `date` labels. `isLocked()` reads state
  `crm.contact_type.locked` (install locks `person`). Field-UI base route
  `entity.crm_contact_type.edit_form`. Collection `/admin/structure/crm/contact-types`.
- **crm_contact_method_type** (`ContactMethodType`) — label, description.
- **crm_relationship_type** (`RelationshipType`, config prefix `crm.crm_relationship_type`) —
  the rich rule config. Exported keys: `asymmetric`, `label_a`/`label_b` (+ plural),
  `contact_type_a`/`contact_type_b` (allowed contact bundles per side), `limit_a`/`limit_b`,
  `limit_active_only`, `valid_contacts_a`/`valid_contacts_b` (explicit contact-id allow-lists),
  `readonly_contact_a`/`readonly_contact_b`. When `asymmetric` is FALSE, `save()` mirrors the
  A-side values onto the B-side. `calculateDependencies()` adds config deps on referenced
  contact types.

## crm_method_detail (`src/Entity/MethodDetail.php`, config)
Config entity for method-detail labels (home, work, mobile, main, billing, fax, other). Keys:
`label`, `description`, `bundles` (which method bundles it applies to), `negate`. Used by the
`default:crm_method_detail` entity-reference selection to populate the method `detail` field.
Its access handler allows **view for everyone** (labels are non-sensitive and shown in
reference formatters); update/delete require `administer crm`.

## crm_user_contact_mapping (`src/Entity/UserContactMapping.php`)
Content entity linking a Drupal `user` to a person `crm_contact`, plus per-field grant fields
(`UserContactMapping::buildGrantFieldDefinitions()`, installed by `crm_update_10003`). Drives
the "mapped contact" access path and field mirroring — see the configuration doc.
