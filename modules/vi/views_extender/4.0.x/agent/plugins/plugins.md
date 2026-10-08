<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_extender — plugin reference

## Filter: `entity_field_compare` (`EntityFieldCompare`)
- Config value is run through `token->replace()` against contextual data (`getTokenData()`).
- `opEqual`: `query->addWhereExpression($group, "$expression $operator :placeholder", [':placeholder' => $value])` — bound.
- `opContains` / `opNotLike`: `escapeLike($value)` then `addWhere($group, $field, '%'.$value.'%', LIKE|NOT LIKE)`.
- `$expression`/`$field` derive from a selected Views field handler's `tableAlias.realField` (requires a fields-based display; enforced in `validate()`).

## Argument default: `CurrentDateTime`
Supplies the current date/time as a contextual argument value.

## Argument validators
- `TermFieldAsId` — resolve/validate a taxonomy term argument from a term field value.
- `TermAlias` (id `taxonomy_term_alias`) — load `path_alias` for `/`.$argument, extract `/taxonomy/term/{id}`, load and validate the term. `multipleCapable = FALSE`.

## ECA submodule (`views_extender_eca`)
- Event: `ViewsExtenderEvent` (`views_extender_entity_field_compare`), deriver-based ECA event plugin.
- Actions: `SetDataAction`, `MemoryStateRead`, `MemoryStateWrite` (via `MemoryState` service).
- Views plugins: `ArgumentDefaultEca`, `ArgumentValidatorEca`, `EntityFieldCompareEca`.
