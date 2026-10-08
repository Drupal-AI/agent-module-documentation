<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Configure field_validation

## Admin UI

- Collection / config route: `entity.field_validation_rule_set.collection` →
  `/admin/structure/field_validation` (permission `administer field validation rule set`).
- Add a rule set: `/admin/structure/field_validation/add` (pick entity type + bundle + name/label).
- Edit a set: `/admin/structure/field_validation/manage/{rule_set}`.
- Add a rule to a set: `/admin/structure/field_validation/manage/{rule_set}/add/{plugin_id}`;
  edit `/…/rules/{rule_uuid}`; delete `/…/rules/{rule_uuid}/delete`.

## The `field_validation_rule_set` config entity

- Config name: `field_validation.rule_set.<name>`; `config_prefix` = `rule_set`; id key = `name`.
- `config_export` keys: `name`, `label`, `entity_type`, `bundle`, `field_validation_rules`.
- `field_validation_rules` is a mapping keyed by each rule's **uuid**. Per-rule keys:

| Key | Meaning |
|---|---|
| `id` | the `FieldValidationRule` plugin id (e.g. `length_constraint_rule`) |
| `title` | admin label for the rule instance |
| `field_name` | machine name of the field to validate (e.g. `body`, `title`, `field_phone`) |
| `column` | the field property/column to check (e.g. `value`) |
| `data` | plugin-specific config, schema `field_validation.rule.<plugin_id>` (see below) |
| `error_message` | custom message shown on violation (optional) |
| `weight` | order within the set |
| `uuid` | the rule instance uuid (also the map key) |
| `roles` | sequence of role ids the rule applies to (empty = all) |
| `condition` | optional `{field, operator, value}` — only validate when it matches |

`data` shape depends on the plugin's own schema (`config/schema/field_validation.schema.yml`).
All constraint rules share `validate_mode`; a few examples:
- `length_constraint_rule` → `min`, `max`, `maxMessage`, `minMessage`, `exactMessage`
- `regex_constraint_rule` → `pattern`, `message`
- `range_constraint_rule` / `count_constraint_rule` → `min`, `max`, `*Message`
- `email_constraint_rule`, `*_constraint_rule` (most) → `message`
- `expression_constraint_rule` → `expression`, `message`
- comparison rules (`equal_to_…`, `greater_than_…`, `divisible_by_…`) → `value`, `message`

## Drush / config

Rule sets are plain config, so no custom Drush is provided — use core config commands:

```bash
drush config:get field_validation.rule_set.<name>          # read a set
drush config:export / drush config:import                   # deploy sets between envs
drush config:delete field_validation.rule_set.<name>        # remove a set
```

To create one non-interactively, prefer the entity API (see
[../api/field_validation.md](../api/field_validation.md)) rather than hand-writing config,
so uuids and defaults are generated correctly.

## Permissions

Single permission `administer field validation rule set` (marked `restrict access: true`)
gates the whole UI and is the config entity's `admin_permission`.
