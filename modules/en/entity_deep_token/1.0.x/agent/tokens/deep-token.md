<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The entity-deep-token token type and traversal

All logic is in `entity_deep_token.module` (two hooks). No classes involved in resolution.

## Registration — `entity_deep_token_token_info()`

Declares one token **type** keyed `entity_deep_token` (name "Entidad profunda") and, under it, one
sample token `entity` (label "Entidad origen"). This registration is what the Token UI browser lists.

Caveat (grounded in source): the type key registered here is `entity_deep_token` (underscore), but the
replacement callback below only fires for the type string `entity-deep-token` (hyphen). Token
replacement does not require a registered type, so the working token to place in content is
`[entity-deep-token:...]` (hyphenated, as in README/human-docs); the underscore form shown in the token
browser has no matching handler.

## Resolution — `entity_deep_token_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`

1. Returns early unless `$type === 'entity-deep-token'`.
2. Loads config `entity_deep_token.settings`, reads `content_list`, and computes
   `$enabled = array_keys(array_filter($content_list))` — the entity-type ids checked on the settings
   form (see [../config/settings.md](../config/settings.md)).
3. Picks the **source entity**: the first `$enabled` id that exists as a key in `$data`. As a special
   case, if `taxonomy_term` is enabled and `$data['term']` is set, it uses the `term` key. If the
   resolved value is not an `EntityInterface`, nothing is replaced.
4. For each requested token, it splits the token string on `:` into `$parts` and walks them left to
   right with a cursor `$current` starting at the source entity:
   - `entity` step → skipped (it is a separator marking a hop that the field lookup performs).
   - When `$current` is an entity and the part is `id`, `label`, or `bundle`: returns that value and
     stops (`break 2`). For `id` it returns a **path string** `/{entity_type}/{id}` (or
     `/taxonomy/term/{id}` for terms), not the bare id.
   - When `$current` is an entity that `hasField($part)`: reads `$field = $current->get($part)`, then
     looks at the **next** part to decide how to descend:
     - numeric → `$field->get((int) $next)` (a specific delta) and advances the index;
     - `entity` → `$field->entity` (follow the reference to the referenced entity);
     - `value` / `target_id` / `date` → `$field->{$next}` (a typed property);
     - anything else, or no next part → `$field->value`.
   - Otherwise it falls back to generic access on `$current`: object property, array key, or method
     call named `$part`; if none match, resolution fails (`$current = NULL; break`).
5. If `$current` is non-empty, the replacement is `$current` when scalar, else `$current->label()`
   when the object exposes `label()`, else empty string. Replacements are returned to core, which
   sanitizes token output by default.

## Syntax and examples (from README)

- `[entity-deep-token:field_department:entity:field_school:entity:id]` → `/node/{id}` of the school.
- `[entity-deep-token:field_department:entity:field_school:entity:label]` → school node title.
- `[entity-deep-token:field_department:entity:field_school:entity:bundle]` → school bundle.
- `[entity-deep-token:field_related_node:entity:created:value]` → related node raw created timestamp.

## Limits (source-confirmed)

- Multi-value reference fields: only the **first** item is followed unless a numeric delta is given.
- Raw values are returned **unformatted** (e.g. a `created` timestamp is a Unix integer).
- Requires an entity present in the token `$data` (node/user/term/etc. context); no entity ⇒ no output.
