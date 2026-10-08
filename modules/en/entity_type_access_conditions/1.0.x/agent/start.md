<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Type Access Conditions — agent index

Condition-based access gating for entity types/bundles. Adds a conditions section to bundle config
forms (Node/Media types, Vocabularies) and enforces them via entity-access hooks. Depends on
`conditions_helper`. Config UI at `/admin/config/content/entity-type-access-conditions`.

- **Admin settings, how conditions are stored/evaluated, which operations are restricted per entity type** → [configure/settings.md](configure/settings.md)
- **Add access conditions to your own entity type (YAML plugin + form-ids hook)** → [extend/add-entity-type.md](extend/add-entity-type.md)

Key facts:
- Enforcement model: returns `AccessResult::forbidden()` when conditions are NOT met, else neutral.
  It is additive — it never returns *allowed*, so it can only deny, and defaults to neutral when no
  plugin/conditions/restriction applies (default operation coverage: see configure/settings.md).
- Permissions (both `restrict access: true`): `administer entity type access conditions`,
  `bypass entity type access conditions` (bypass → neutral, i.e. skips this module's checks).
- Plugin type `entity_type_access_conditions` = YAML discovery of `*.entity_type_access_conditions.yml`
  files; each entry declares `label`, `altered_forms`, `restricted_operations`.
- Conditions stored in bundle `third_party_settings.entity_type_access_conditions`.
- Hook: `hook_entity_type_access_conditions_form_ids_alter(&$form_ids)`.
