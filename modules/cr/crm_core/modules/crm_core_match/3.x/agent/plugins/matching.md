<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Matcher config, engines & field handlers

## Matcher config entity (`crm_core_match.matcher.*`)

Schema `config/schema/crm_core_match.schema.yml`: `id`, `label`, `description`, `plugin_id`,
`configuration`. The `configuration` shape depends on `plugin_id`; for the default engine
(`crm_core_match.configuration.default`):

- `threshold` (int) — score at/above which a candidate is a match.
- `return_order` (string) — tie-break: `created` | `updated` | `associated`.
- `strict` (bool) — return the first qualifying match and stop.
- `rules` — sequence keyed by field name → property name → `{weight, status, operator, options,
  score}`.

Shipped installs: `crm_core_match.matcher.individual`, `.organization`, `.household`.

## Default Matching Engine (`Plugin/crm_core_match/engine/DefaultMatchingEngine.php`)

- Annotation `@CrmCoreMatchEngine(id = "default", …)`; extends `MatchEngineBase`. DI:
  `plugin.manager.crm_core_match.match_field`, `entity_type.manager`, `entity_field.manager`.
- `match(ContactInterface $contact)`:
  1. For each configured rule whose field exists and has a registered field handler, instantiate
     the handler (`createInstance($field->getType(), $rules)`).
  2. For each property name, call `$handler->match($contact, $name)` and accumulate per-candidate
     scores into `$results[$id]`.
  3. Sum each candidate's scores; keep ids whose total `>= threshold`. Returns candidate ids.
- `buildConfigurationForm()` renders the threshold/return-order/strict controls plus a draggable
  **rules** table (one row per supported field property) built from all `crm_core_individual_type`
  field definitions; unsupported field types (no handler) are listed in a separate table.
- `validateConfigurationForm()` requires numeric `threshold` and `score`, and an operator on any
  enabled field. `submitConfigurationForm()` normalises `field:property` keys back into nested
  `rules`.

## Field handlers (`Plugin/crm_core_match/field/`)

`FieldHandlerBase` implements the common getters (`getStatus/getOperator/getOptions/getScore/
getWeight`, default property `value`) and `match()`:

- Builds an entity query on `crm_core_individual` filtered to the contact's bundle, excluding the
  contact's own id, with `condition(field, needle, operator)`.
- Runs with `accessCheck(FALSE)` (this is an internal dedup query over contact storage, not a
  user-facing listing) and returns `array_fill_keys($ids, [field.property => score])`.

Handlers ship for field types: name, email, telephone, phone_number, address, datetime, integer,
string, text, list/select. The plugin `id`/`field` is the field **type** it handles, so the engine
resolves a handler by `$field->getType()`.

## Writing a custom engine or handler

- Engine: implement `MatchEngineInterface` (extends `PluginFormInterface`, `ConfigurableInterface`,
  `DependentPluginInterface`) with an `@CrmCoreMatchEngine` annotation; implement `match()`,
  `getConfigurationItem()`, `getRules()`. Place in `Plugin/crm_core_match/engine`.
- Field handler: extend `FieldHandlerBase` with a `@CrmCoreMatchFieldHandler(field = "<type>")`
  annotation in `Plugin/crm_core_match/field`.
