<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Conditional Tamper (feeds_conditional_tamper) — agent index

Two **Feeds Tamper plugins** that conditionally drop data during a Feeds import based on a
configurable source-field comparison. Package `Custom`. Core `^10.2 || ^11`. License
GPL-2.0-or-later. Version 1.0.0-beta1 (version dir 1.0.x).

- **The two plugins, the shared condition form, the operators, evaluation logic, and how to
  attach them in the Feeds Tamper UI** → [plugins/conditional-tampers.md](plugins/conditional-tampers.md)

## What it actually is

- Depends on `tamper` and `feeds_tamper` (^2.0). It ships **only** three PHP classes under
  `src/Plugin/Tamper/` — no `.module`, no `.install`, no routes, no permissions, no services, no
  config entities, no config schema, no config/install, no Drush, no composer.json.
- **No configuration page and no admin route of its own.** Both plugins are configured on a feed
  type's Tamper/mapping UI provided by `feeds_tamper`.

## Plugins provided (`@Tamper` annotations)

- `skip_item_on_condition` — *"Skip item on condition"*, category *Filter*. When the condition is
  TRUE, throws `SkipTamperItemException` → the whole feed row is removed from the batch
  (`SkipItemOnCondition::tamper()`).
- `skip_value_on_condition` — *"Skip value on condition"*, category *Filter*. When the condition is
  TRUE, throws `SkipTamperDataException` → the current field value is cleared to NULL, the row still
  imports (`SkipValueOnCondition::tamper()`).
- Both extend `ConditionalTamperBase` (abstract), which supplies the condition form, validation, and
  `evaluateCondition()`. Both declare `handle_multiples = TRUE`, `itemUsage = "optional"`.

## Condition model (from `ConditionalTamperBase`)

- Settings: `condition_source` (source field key, or `''` = current tampered value), `operator`,
  `condition_value`, `case_sensitive`.
- Operators: `equals`, `not_equals`, `contains`, `not_contains`, `matches_regex`,
  `not_matches_regex`, `is_empty`, `is_not_empty`.
- Regex operators pass the pattern to `preg_match()` as-is (delimiters + flags supplied by the
  admin); validated on save via `@preg_match($pattern, '')`. String operators lowercase both sides
  with `mb_strtolower()` unless *Case sensitive* is checked.
