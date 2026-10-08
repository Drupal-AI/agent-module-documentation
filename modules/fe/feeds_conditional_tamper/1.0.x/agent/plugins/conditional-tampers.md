<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditional skip Tamper plugins

Two Tamper plugins for the Feeds Tamper pipeline, both driven by one shared condition form.

## Install / enable

```bash
composer require drupal/feeds_conditional_tamper -W   # pulls tamper + feeds_tamper
drush en feeds_conditional_tamper -y
drush cr
```

Dependencies (`feeds_conditional_tamper.info.yml`): `tamper:tamper`, `feeds_tamper:feeds_tamper`
(README: feeds_tamper `^2.0`). Core `^10.2 || ^11`. No composer.json ships; the module is pure
plugin code.

## The two plugins

Both live in `src/Plugin/Tamper/`, extend `ConditionalTamperBase`, and only implement `tamper()`.
Annotation: `category = "Filter"`, `handle_multiples = TRUE`, `itemUsage = "optional"`.

- **`SkipItemOnCondition`** (id `skip_item_on_condition`, label *"Skip item on condition"*). If
  `evaluateCondition()` is TRUE it `throw new SkipTamperItemException(...)`, which Feeds Tamper
  catches to **drop the entire feed row** (no entity created/updated for it) — like the built-in
  *Required* plugin but with a configurable comparison. Otherwise returns `$data` unchanged.
- **`SkipValueOnCondition`** (id `skip_value_on_condition`, label *"Skip value on condition"*). If
  the condition is TRUE it `throw new SkipTamperDataException(...)`, which clears **only the current
  field value** (set to NULL); the row still imports. Otherwise returns `$data`.

The difference is purely which exception is thrown: item-skip vs. value-skip.

## Condition form (`ConditionalTamperBase::buildConfigurationForm`)

Four settings (constants on the base class), with defaults from `defaultConfiguration()`:

- **`condition_source`** (`condition_source`, default `''`) — a `select`. The empty option
  *"— Current field value —"* means test the value being tampered; any other option is a feed
  source key from `$this->sourceDefinition->getList()`, letting you cross-reference a different
  column in the same row.
- **`operator`** (`operator`, default `equals`) — a `select` of the 8 operators below.
- **`condition_value`** (`condition_value`, default `''`) — a `textfield` for the comparison
  string (or a full PHP regex with delimiters for regex operators). Hidden via `#states` for the
  empty / not-empty operators.
- **`case_sensitive`** (`case_sensitive`, default `FALSE`) — a `checkbox`. Hidden via `#states`
  for empty/not-empty and both regex operators (put the `i` flag in the pattern instead).

`submitConfigurationForm()` stores the four values (casting `case_sensitive` to bool).
`getUsedSourceProperties()` returns `[$condition_source]` when a non-empty source is chosen, so
feeds_tamper lazy-loads that source before execution.

## Operators (`operatorOptions()` / `evaluateCondition()`)

| Operator const | Value | Behaviour in `evaluateCondition()` |
|---|---|---|
| `OP_EQUALS` | `equals` | `$valueStr === $compareStr` |
| `OP_NOT_EQUALS` | `not_equals` | `$valueStr !== $compareStr` |
| `OP_CONTAINS` | `contains` | `str_contains($valueStr, $compareStr)` |
| `OP_NOT_CONTAINS` | `not_contains` | `!str_contains(...)` |
| `OP_REGEX` | `matches_regex` | `(bool) @preg_match($pattern, (string) value)` |
| `OP_NOT_REGEX` | `not_matches_regex` | negation of the above |
| `OP_EMPTY` | `is_empty` | value is `NULL`, `''`, or `[]` |
| `OP_NOT_EMPTY` | `is_not_empty` | not empty |

## How the value is resolved and compared (`evaluateCondition($data, $item)`)

1. If `condition_source` is non-empty and an `$item` is present, the compared value is
   `$item->getSourceProperty($source)`; otherwise it is `$data` (the current field value).
2. Empty / not-empty operators short-circuit with no string conversion.
3. Regex operators run `@preg_match()` with the admin-entered pattern **as-is** (delimiters and
   flags included by the admin) against `(string) ($value ?? '')`.
4. String operators cast both sides to string; unless *Case sensitive* is set, both are lowercased
   with `mb_strtolower()`. Comparison then uses `match($operator)` over `===`/`!==`/`str_contains`.

`validateConfigurationForm()` rejects an invalid regex on save: for the two regex operators it runs
`@preg_match($pattern, '')` and sets a form error if it returns `FALSE`.

## Using it in the UI

Structure → Feed types → *(feed type)* → **Tamper** tab. Click **+ Add tamper** on the source you
want to gate, pick *Skip item on condition* or *Skip value on condition*, set condition source /
operator / value / case-sensitivity, Save. Tampers on a source run top-to-bottom (drag to reorder);
place a conditional skip before transformation tampers to avoid processing values that will be
dropped. Skipped items are removed silently (Feeds core behaviour for filter tampers — no per-row
log). Run/verify: `drush feeds:import {feed_id} -y`.
