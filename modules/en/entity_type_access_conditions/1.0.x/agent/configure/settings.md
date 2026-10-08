<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & enforcement model

## Admin settings page
Route `entity_type_access_conditions.settings` → `/admin/config/content/entity-type-access-conditions`
(permission `administer entity type access conditions`). It extends Conditions Helper's
`ConditionSelectorSettingsFormBase` and writes `entity_type_access_conditions.settings`:
- `enabled_conditions` (sequence of condition plugin IDs) — which condition plugins are offered when
  building conditions on bundle forms.

## Adding conditions to a bundle
When you edit a supported bundle (e.g. Structure → Content types → edit a type), the module injects an
**Entity Type Access Conditions** details element (built by Conditions Helper from the enabled
conditions + available contexts). Saved values go into the bundle entity's
`third_party_settings.entity_type_access_conditions` (schema:
`node.type.*.third_party.entity_type_access_conditions`, and the `media.type.*` / `taxonomy.vocabulary.*`
equivalents — a sequence of `condition.plugin.[id]`).

## Which operations are restricted (default plugin map)
Shipped file `entity_type_access_conditions.entity_type_access_conditions.yml`:

| Entity type | altered_forms | restricted_operations |
|---|---|---|
| `node` | — | `create` |
| `node_type` | node_type add/edit forms | `create`, `update`, `delete`, `view` |
| `media` | — | `create` |
| `media_type` | media_type add/edit forms | `create`, `update`, `delete`, `view` |
| `taxonomy_term` | — | `create` |
| `taxonomy_vocabulary` | taxonomy_vocabulary_form | `create`, `update`, `delete`, `access taxonomy overview` |

Note the content entities (`node`/`media`/`taxonomy_term`) only restrict **create** by default; the
richer operations apply to the *bundle config entities* (configuring a `view`/`update` condition on a content type does not restrict viewing the
content items themselves under the default map).

## Runtime evaluation
`hook_entity_access` / `hook_entity_create_access` → `EntityAlters`:
1. `bypass entity type access conditions` permission → `AccessResult::neutral()` (skip).
2. If no plugin for the entity type, operation not in `restricted_operations`, or no stored conditions
   → `neutral()`.
3. Otherwise `ConditionsEvaluator::evaluateConditions()`; result strictly `=== FALSE` →
   `AccessResult::forbidden()` (+ entity cache dependency); anything else → `neutral()`.

So the module only ever *denies*; access is granted by core/other modules.
