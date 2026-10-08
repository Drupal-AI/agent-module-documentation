<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# field_validation_legacy — agent index

Submodule of **field_validation** (`part_of: field_validation`). Adds ~20 original
hand-written `FieldValidationRule` plugins to the parent's plugin type — no new plugin type,
config entity, route or permission. Use the rules exactly like the parent's: add one to a
`field_validation_rule_set` bound to a field/column with its own `data`.
See the parent for the plugin type, config entity and API →
[../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md).

Legacy rule ids (`data` schema `field_validation.rule.<id>`):
`regex_field_validation_rule`, `pattern_field_validation_rule`,
`length_field_validation_rule`, `numeric_field_validation_rule`,
`integer_field_validation_rule`, `phone_field_validation_rule`,
`email_field_validation_rule`, `url_field_validation_rule`, `ip_field_validation_rule`,
`words_field_validation_rule`, `plain_text_field_validation_rule`,
`blocklist_field_validation_rule`, `unique_field_validation_rule`,
`specific_value_field_validation_rule`, `match_field_field_validation_rule`,
`equal_values_field_validation_rule`, `one_of_several_validation_rule`,
`item_count_field_validation_rule`, `must_be_empty_field_validation_rule`,
`date_range_field_validation_rule`.

- Enable: `drush en field_validation_legacy -y`. New sites should prefer the parent's
  `*_constraint_rule` plugins; this submodule is for backward compatibility.
