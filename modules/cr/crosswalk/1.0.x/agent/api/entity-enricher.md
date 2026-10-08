<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityEnricher service

`Drupal\crosswalk\EntityEnricher` (`src/EntityEnricher.php`), registered as service
**`crosswalk.entity_enricher`** (`crosswalk.services.yml`) with args `@entity_type.manager`,
`@serializer`, `@logger.channel.crosswalk`. Used by the block convert pipeline to inline referenced-entity
data into a node's serialized JSON before it is piped to the `crosswalk` CLI.

## Purpose

Given the JSON produced by serializing a node, it walks the structure, finds Drupal entity references,
loads and serializes the referenced entities, and nests their data under an `_entity` key on the reference —
so the CLI sees full referenced-entity metadata (subjects, authors-as-terms, media, files) rather than bare
target IDs.

## Public API

- `enrich(string $json): string` — `json_decode` the input; if decode fails returns the input unchanged.
  Otherwise recurses with `enrichValue($data, 0)` and returns `json_encode()` of the result.

## Recursion mechanics

- `enrichValue($value, $depth)`:
  - if `$depth > maxDepth` (default **`maxDepth = 2`**) returns the value untouched;
  - **string** → `strip_tags($value)` (removes HTML tags from every scalar string, incl. `</script>`-style
    breakout attempts);
  - **associative array** (`isAssociative()`: keys are not a `0..n-1` range) → `enrichMap()` recurses into values;
  - **sequential array** → `enrichList()`, which enriches entity-reference items and recurses into the rest.
- `isEntityReference($item)` — true when the array has both `target_id` and `target_type`.
- `enrichReference($ref, $depth)`:
  - bails (returns `$ref` as-is) unless `target_type` is a string and `target_id` is numeric;
  - **explicitly skips `target_type === 'user'`** ("contain sensitive data");
  - only proceeds for the allow-list `static::$supportedTypes = ['taxonomy_term', 'node', 'media', 'file']`;
  - loads the entity via `entityTypeManager->getStorage($type)->load($id)`; if not found, returns `$ref`;
  - serializes it (`serializer->serialize($entity, 'json')`), decodes, recurses `enrichValue(..., $depth + 1)`,
    and stores the result on `$ref['_entity']`;
  - any `\Exception` is caught and logged as a warning via the crosswalk logger channel; the original reference
    is kept (never fatal).

## Behavioural notes

- The user entity type is deliberately excluded, so author accounts are not inlined into public citation/schema
  output. Only node / taxonomy_term / media / file references are expanded.
- Recursion is bounded at depth 2, so deeply nested reference chains are truncated (values beyond the limit are
  returned unmodified rather than expanded).
- `strip_tags` on every string is a normalization/cleanup step (and neutralizes stray markup) — it is applied to
  all scalar strings in the payload, including inside loaded referenced entities.
- Referenced entities are loaded and serialized with the `json` format serializer; the enricher itself performs
  no additional entity-access filtering beyond the type allow-list and the `user` exclusion, so restrict block
  placement to content whose references are intended to be public.
