<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Field Validation lets site builders attach reusable validation rules to any entity field through the UI, without writing code — enforcing formats, ranges, lengths, uniqueness and more at form-submit and entity-save time.

---

The module defines one config entity, the **field validation rule set** (`field_validation_rule_set`), scoped to a single entity type + bundle (e.g. `node` / `article`). Each rule set holds an ordered list of **rules**, and each rule is an instance of a `FieldValidationRule` plugin (annotation `@FieldValidationRule`, namespace `Plugin/FieldValidationRule`) bound to one field name and column with its own configuration, error message, applicable roles and an optional conditional. The installed 3.0.x branch is a **beta rewrite**: most shipped rules are thin wrappers around Drupal/Symfony validation **Constraints** (Length, Regex, Range, Email, NotNull, Unique, Count, Expression, IBAN, ISBN, country/locale, card scheme, and many more), added on top of the field's existing constraints. Rule sets are pure configuration — they export with `drush config:export` and carry no content — so they can be created, read and deployed entirely via `drush`, config YAML, or the admin UI at `/admin/structure/field_validation`. The older, hand-written rule plugins (pattern, phone, words blocklist, plain-text, item-count, etc.) live in the separate **field_validation_legacy** submodule for sites upgrading from the 8.x/1.x line. Validation runs wherever core validates the entity, so a violated rule blocks the node/user/term form and the entity API save.

---

- Require a text field to match a regular expression (e.g. a SKU or postcode format) via a `regex_constraint_rule`.
- Enforce a minimum and/or maximum character length on a field with the `length_constraint_rule`.
- Constrain a numeric field to a range (min/max) using the `range_constraint_rule`.
- Validate that a field contains a well-formed email address with `email_constraint_rule`.
- Make a field's value unique across all entities of a bundle using `unique_field_constraint_rule`.
- Require a field to be non-empty (or, conversely, forced empty) with `not_blank_constraint_rule` / `blank_constraint_rule`.
- Require a field to be null or not-null with `null_constraint_rule` / `not_null_constraint_rule`.
- Limit the number of values on a multi-value field with `count_constraint_rule`.
- Force a checkbox/boolean field to be checked or unchecked with `true_constraint_rule` / `false_constraint_rule`.
- Compare a field against a fixed value with `equal_to`, `not_equal_to`, `identical_to`, `greater_than`, `less_than`, `greater_than_or_equal`, `less_than_or_equal` constraint rules.
- Require a number to be positive, negative, or divisible by N (`positive_constraint_rule`, `negative_constraint_rule`, `divisible_by_constraint_rule`).
- Validate financial identifiers: IBAN, BIC, credit-card scheme, currency, Luhn checksum.
- Validate standard codes: ISBN, ISSN, ISIN, ULID, UUID, hostname, IP, CIDR, CSS color, JSON.
- Validate country, language and locale codes with the ICU-backed constraint rules.
- Run a Symfony ExpressionLanguage expression against a field value for complex custom logic (`expression_constraint_rule`).
- Validate date, datetime and time string formats with the date/time constraint rules.
- Apply a rule only for users in specific roles (per-rule `roles` setting).
- Apply a rule only when another field meets a condition (per-rule `condition`: field / operator / value).
- Group several rules for one bundle into a single reusable rule set that exports as config.
- Bulk-apply validation across a content type without touching each field's storage settings.
- Migrate legacy field validation setups by enabling field_validation_legacy for pattern/phone/words/plain-text style rules.
- Add site-wide business rules (e.g. "phone must be 10 digits", "title must not contain profanity") in configuration you can deploy across environments.
- Give editors a clear, custom error message per rule instead of a generic core validation message.
- Enforce validation consistently whether an entity is created through a form, the entity API, or a migration.
