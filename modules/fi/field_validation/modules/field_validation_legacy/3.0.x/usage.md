<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Field Validation legacy is a submodule of Field Validation that ships the original, hand-written validation rule plugins from the 8.x/1.x line, for sites that used them before the 3.0.x constraint-based rewrite.

---

This submodule (machine name `field_validation_legacy`, package Fields, depends on its parent `field_validation`) adds ~20 extra `FieldValidationRule` plugins to the parent's plugin type — it defines no new plugin type, config entity, route or permission of its own. The rules are the classic ones: `pattern`, `regex`, `length`, `numeric`/`integer`, `phone`, `email`, `url`, `ip`, `words` (word count), `plain_text` (disallow tags), `blocklist` (banned words), `unique`, `specific_value`, `match_field`, `equal_values`, `one_of_several`, `item_count`, `must_be_empty` and `date_range`. Each is used exactly like a core rule: you add it to a parent `field_validation_rule_set` against a field name and column, with its own `data` config (schema `field_validation.rule.<legacy_id>`). It exists for backward compatibility — new sites should prefer the parent's `*_constraint_rule` plugins, but this submodule remains the way to keep pattern/phone/words-style rules working after upgrading. Enable with `drush en field_validation_legacy` and the extra rules appear in the same "Add rule" list at `/admin/structure/field_validation`.

---

- Keep pre-3.0 field validation setups working after upgrading the parent module.
- Validate a field against a PCRE regular expression with `regex_field_validation_rule`.
- Validate a field against a `pattern_field_validation_rule` (pattern with placeholders).
- Enforce min/max character length (with optional strip-tags/trim) via `length_field_validation_rule`.
- Require a field to be numeric or an integer within a range (`numeric_…`, `integer_field_validation_rule`).
- Validate a phone number format with `phone_field_validation_rule`.
- Validate an email address with `email_field_validation_rule`.
- Validate a URL with `url_field_validation_rule`.
- Validate an IP address (v4/v6) with `ip_field_validation_rule`.
- Limit or require a number of words with `words_field_validation_rule`.
- Strip/disallow HTML tags in a field using `plain_text_field_validation_rule`.
- Block a list of banned words with `blocklist_field_validation_rule`.
- Enforce a value is unique across entities with `unique_field_validation_rule`.
- Require a field to equal one of several specific values (`specific_value_field_validation_rule`).
- Require a field to match another field's value (`match_field_field_validation_rule`).
- Require several fields to hold equal values (`equal_values_field_validation_rule`).
- Require at least one of several fields to be filled (`one_of_several_validation_rule`).
- Enforce a min/max item count on a multi-value field (`item_count_field_validation_rule`).
- Force a field to be empty under conditions with `must_be_empty_field_validation_rule`.
- Validate a date falls within a range/cycle using `date_range_field_validation_rule`.
- Provide a migration path so legacy rule-set config imported from an older site still validates.
