<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enum Field adds two list-field types, `enum_string` (Enum text) and `enum_integer` (Enum integer), whose allowed values are read from a **backed PHP enum** in code instead of an allowed-values list typed into the field settings, so the option set lives with the domain logic and cannot drift from it.

---

Drupal's core `options` module stores allowed values as field configuration: a site builder types `draft|Draft`, `review|In review` into a textarea, and the code that later branches on those values has to hard-code the same strings with nothing enforcing the match. This module replaces the source of truth. A single `enum_class` storage setting points the field at a backed PHP enum (`EnumItemTrait` unsets the usual `allowed_values`/`allowed_values_function`), and `EnumItemTrait::getOptions()` turns each `$enumClass::cases()` into a `value => label` option, using the case's `label()` method when present. Adding a case adds an option; renaming one is an IDE refactor. The real payoff is the computed `enum` property (`src/ComputedEnum.php`): `$entity->get('field')->enum` and `->enums()` return typed enum cases via `tryFrom`, so application code can `match` on them with static analysis behind it. The module ships no widget or formatter of its own — it registers its types against every core list widget/formatter through alter hooks — but does add a `ManyToOne`-based Views filter that offers the enum cases as options, a Drush `field:create --enum-class` integration, and a `Migration` service to convert a field storage between list and enum in place. Requirements are `php: 8.1` (enums do not exist earlier) and core `options`; there are no routes, permissions or config forms of its own. This is a developer's field type: it makes options non-editable through the UI on purpose.

---

- Define a list field's options in code as a PHP enum.
- Stop allowed values drifting from the constants used in code.
- Refactor an option's name safely across a codebase with an IDE.
- Get a typed enum case out of a field instead of a string.
- Use `match` over a field value with static analysis.
- Prevent site builders editing a domain-critical option set.
- Share one enum's option set across several fields.
- Version-control an option list as code.
- Migrate an existing list field onto an enum (and back) in place.
- Keep workflow states in sync with the enum that drives them.
- Give options human-readable, translatable labels via an enum `label()` method.
- Add a new option through code review rather than a config change.
- Validate that the configured class is a real backed enum at field-setup time.
- Give a status field a canonical, single-source definition.
- Reduce magic strings in custom modules.
- Reuse a package's enum as field options.
- Expose enum cases as select options in a Views exposed filter.
- Create an enum field from the CLI with `drush field:create --enum-class`.
- Set a field value by passing an enum case directly (`$item->setValue(Status::Draft)`).
- Read all deltas of a multi-value enum field as an array of cases with `->enums()`.
- Catch removed options at deploy time rather than at runtime.
- Generate sample enum values for a field with devel-generate.
