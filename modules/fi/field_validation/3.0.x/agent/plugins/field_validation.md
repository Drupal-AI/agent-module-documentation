<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# field_validation — the FieldValidationRule plugin type

## Defining a rule

- Plugin type: **`FieldValidationRule`**.
- Annotation: `@FieldValidationRule` (`Drupal\field_validation\Annotation\FieldValidationRule`) with `id`, `label`, `description`.
- Namespace / directory: `Drupal\<module>\Plugin\FieldValidationRule` (`src/Plugin/FieldValidationRule/`).
- Manager service: `plugin.manager.field_validation.field_validation_rule` (class `FieldValidationRuleManager`).
- Base classes / interfaces:
  - `FieldValidationRuleBase` (`FieldValidationRuleInterface`) — the root; holds `uuid`, `title`, `weight`, `field_name`, `column`, `error_message`, `roles`, `condition`; `getConfiguration()` returns those plus `id` and `data`.
  - `ConfigurableFieldValidationRuleBase` (`ConfigurableFieldValidationRuleInterface`) — adds `defaultConfiguration()`/`buildConfigurationForm()`/`submitConfigurationForm()`.
  - `ConstraintFieldValidationRuleBase` — the 3.0.x pattern: implement `getConstraintName(): string` (a core/Symfony Constraint plugin id, e.g. `Length`, `Regex`, `Range`) and `isPropertyConstraint(): bool`; the base builds the constraint from `data`.
- Rule config validates against schema `field_validation.rule.<plugin_id>` in `config/schema/field_validation.schema.yml`; add a matching schema entry for a new rule.
- Also implement `hook_field_validation_rule_info_alter()` to alter discovered rules.

## Shipped rule ids (this module, `src/Plugin/FieldValidationRule/`)

All are constraint-backed. Config lives under the rule's `data` key.

Text/format: `length_constraint_rule`, `regex_constraint_rule`, `email_constraint_rule`,
`hostname_constraint_rule`, `json_constraint_rule`, `css_color_constraint_rule`,
`ip_constraint_rule`, `cidr_constraint_rule`.

Presence/emptiness/boolean: `blank_constraint_rule`, `not_blank_constraint_rule`,
`null_constraint_rule`, `not_null_constraint_rule`, `true_constraint_rule`,
`false_constraint_rule`, `unique_field_constraint_rule`.

Numeric & comparison: `range_constraint_rule`, `count_constraint_rule`,
`equal_to_constraint_rule`, `not_equal_to_constraint_rule`, `identical_to_constraint_rule`,
`not_identical_to_constraint_rule`, `less_than_constraint_rule`,
`less_than_or_equal_constraint_rule`, `greater_than_constraint_rule`,
`greater_than_or_equal_constraint_rule`, `divisible_by_constraint_rule`,
`positive_constraint_rule`, `positive_or_zero_constraint_rule`,
`negative_constraint_rule`, `negative_or_zero_constraint_rule`.

Date/time: `date_constraint_rule`, `date_time_constraint_rule`, `time_constraint_rule`.

Locale/i18n: `language_constraint_rule`, `country_constraint_rule`, `locale_constraint_rule`.

Financial/identifier codes: `bic_constraint_rule`, `card_scheme_constraint_rule`,
`currency_constraint_rule`, `luhn_constraint_rule`, `iban_constraint_rule`,
`isbn_constraint_rule`, `issn_constraint_rule`, `isin_constraint_rule`,
`ulid_constraint_rule`, `uuid_constraint_rule`.

Advanced: `expression_constraint_rule` (Symfony ExpressionLanguage), `callback_constraint_rule`.

(48 plugins total in this module.) The **field_validation_legacy** submodule adds ~20 more,
hand-written rules with distinct ids — see
[../../../modules/field_validation_legacy/3.0.x/agent/start.md](../../../modules/field_validation_legacy/3.0.x/agent/start.md).

## Config-schema examples (the `data` mapping)

- `length_constraint_rule`: `validate_mode`, `min`, `max`, `maxMessage`, `minMessage`, `exactMessage`.
- `regex_constraint_rule`: `validate_mode`, `pattern`, `message`.
- `range_constraint_rule` / `count_constraint_rule`: `validate_mode`, `min`, `max`, `*Message`.
- comparison (`greater_than_…`, `equal_to_…`, `divisible_by_…`): `validate_mode`, `value`, `message`.
- `expression_constraint_rule`: `validate_mode`, `expression`, `message`.
- most others: `validate_mode`, `message`.
