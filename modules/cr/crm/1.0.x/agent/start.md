<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM (crm) — agent index

Native **Contact Relationship Management** for Drupal 11: fieldable, revisionable contact
entities and configurable relationships, built entirely on core entity/config/access APIs.
No external service. Version `1.0.0-beta11`, core `>=11.1`.

**Dependencies (modules):** `address`, `datetime` (core), `image` (core), `telephone` (core),
`inline_entity_form`, `name`, `primary_entity_reference`. Optional integrations: `comment`,
`group`, `search`/Search API, `rest`, `serialization`, `views`, `navigation`, `user`.

## Content entity types
- **`crm_contact`** (bundles `crm_contact_type`: person, household, organization) — base fields
  `name`, `emails`/`telephones`/`addresses` (primary_entity_reference → crm_contact_method),
  `status` (published), `start_date`/`end_date`, computed `age`, computed
  `relationship_statistics`. Revisionable. `src/Entity/Contact.php`.
- **`crm_contact_method`** (bundles `crm_contact_method_type`: email, telephone, address) —
  a fieldable method with a `detail` reference (crm_method_detail) and a `crm_contact`
  back-reference. `src/Entity/ContactMethod.php`.
- **`crm_relationship`** (bundles `crm_relationship_type`) — links two contacts (`contacts`,
  cardinality 2; computed `contact_a`/`contact_b`), validated by the `RelationshipContacts`
  and `RelationshipLimit` constraints. `src/Entity/Relationship.php`.

## Config entity types
- **`crm_contact_type`**, **`crm_contact_method_type`**, **`crm_relationship_type`** (bundle
  config; relationship type carries asymmetric flag, per-side contact-type restrictions,
  cardinality limits, labels), **`crm_method_detail`** (home/work/mobile/billing… labels),
  **`crm_user_contact_mapping`** (content entity linking a user to a person contact).

## Provides
- **Permissions:** static (`crm.permissions.yml`) plus dynamic per-bundle callbacks
  (`ContactTypePermissions`, `RelationshipTypePermissions`, `SearchPermissions`).
- **Per-contact grant API:** `crm_contact_access` table + `hook_crm_contact_access_records()` /
  `hook_crm_contact_grants()` (node_access analog). `src/Service/ContactAccessGrantStorage.php`,
  `crm.api.php`.
- **Plugin type:** `crm_user_field_access` (manager `plugin.manager.crm_user_field_access`,
  attribute `#[UserFieldAccess]`, plugins `user_entity` / `contact_entity`).
- **Field plugins:** field type `crm_relationship_statistics`; formatters `crm_age`,
  `crm_relationship_statistics_default`. Entity-reference selection `valid_contacts`,
  `default:crm_method_detail`. Search plugin `crm_contact_search`. Group relation
  `group_crm_contact`. Validation constraints `RelationshipContacts`, `RelationshipLimit`.
- **Routes:** `/crm` portal, `/crm/contact[...]`, `/crm/relationship[...]`,
  `/crm/contact/{id}/relationship`, `/crm/contact/{id}/comment`, admin under
  `/admin/structure/crm` and `/admin/config/crm`.
- **Drush:** `crm:recalculate-statistics`, `crm:generate-simpsons-recipe`.
- **Recipe:** `recipes/crm_simpsons` demo content.

## Solution docs
- [Entity & relationship model](entities/model.md) — the six entity types, bundles, base
  fields, relationship-type rules and constraints.
- [Permissions & access](access/permissions-and-grants.md) — the permission scheme, the four
  access-control handlers, and the per-contact grant API.
- [Configuration](config/settings.md) — CRM theme setting and the User Contact Mapping
  subsystem (settings, field mapping, field-access plugins).
- [Hooks, services & Drush](api/hooks-and-services.md) — services, event subscribers, hooks and
  Drush commands for extending CRM.
