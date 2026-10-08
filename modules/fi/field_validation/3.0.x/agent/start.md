<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# field_validation — agent index

Attach reusable validation rules to entity fields via config. One config entity —
**`field_validation_rule_set`** (scoped to an entity_type + bundle) — holds an ordered list
of **rules**, each a `FieldValidationRule` plugin instance bound to one field/column with its
own config, error message, roles and optional condition. The installed **3.0.x is a beta**
rewrite where most shipped rules wrap Drupal/Symfony validation **Constraints**
(`*_constraint_rule` plugin ids). Depends on core `field`.

- Set up rule sets & rules (admin UI, config keys, drush) → [configure/field_validation.md](configure/field_validation.md)
- The `FieldValidationRule` plugin type + the full list of shipped rule ids → [plugins/field_validation.md](plugins/field_validation.md)
- Create/read rule sets programmatically & the config entity API → [api/field_validation.md](api/field_validation.md)
- Legacy hand-written rules (pattern, phone, words, plain-text, …) → [../../modules/field_validation_legacy/3.0.x/agent/start.md](../../modules/field_validation_legacy/3.0.x/agent/start.md)

Key facts:
- Config entity id: `field_validation_rule_set`; config prefix `field_validation.rule_set.*`;
  entity key `id` = the `name` property; `configure` route `entity.field_validation_rule_set.collection` at `/admin/structure/field_validation`.
- Plugin type: `@FieldValidationRule` annotation, namespace `Drupal\<module>\Plugin\FieldValidationRule`,
  manager service `plugin.manager.field_validation.field_validation_rule`.
- Permission: `administer field validation rule set`.
