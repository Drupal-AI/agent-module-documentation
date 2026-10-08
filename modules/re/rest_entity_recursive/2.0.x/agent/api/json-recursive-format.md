<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `json_recursive` REST format

The module registers one new serialization format, `json_recursive`, that returns a
content entity with **all of its fields and referenced entities inlined** (recursively)
in a single response instead of returning reference targets as bare ids. It works by
tagging core Serialization services; there is no route, config, permission, or UI of its own.

## Requesting it

Append the format to any core REST/entity GET the site already exposes:

```
GET /node/1?_format=json_recursive
GET /node/1?_format=json_recursive&max_depth=3
```

- `RestEntityRecursiveServiceProvider::alter()` registers the format on
  `http_middleware.negotiation` with MIME type `application/json-recursive`, so
  `?_format=json_recursive` (or an `Accept: application/json-recursive` header) selects it.
- The endpoint itself (which entity types/paths respond, and who may call them) is **core
  REST / entity resource config, not this module** — enable the `rest`/`serialization` core
  modules and grant the relevant `restful get …` permission (or use JSON:API/entity routes).
  This module only adds the format; it never widens access.

## Services (all core-tagged, no public API to call)

| Service id | Class | Tag | Notes |
|---|---|---|---|
| `rest_entity_recursive.encoder.json_recursive` | `Encoder\JsonRecursiveEncoder` | `encoder` priority 10, format `json_recursive` | Thin subclass of core `JsonEncoder` — output is plain JSON. |
| `rest_entity_recursive.normalizer.content` | `Normalizer\ContentEntityNormalizer` | `normalizer` priority 9 | Handles any `ContentEntityInterface` for `json_recursive`. |
| `rest_entity_recursive.normalizer.reference` | `Normalizer\ReferenceItemNormalizer` | `normalizer` priority 10 | Extends core `EntityReferenceFieldItemNormalizer`; performs the recursion. Arg: `@entity.repository`. |

## Output shape

`ContentEntityNormalizer::normalize()` returns each entity as:

```json
{
  "entity_type": [{"value": "node"}],
  "entity_bundle": [{"value": "article"}],
  "title": [{"value": "..."}],
  "field_ref": [ { "entity_type": [...], "entity_bundle": [...], "...": [...] } ]
}
```

Two synthetic keys `entity_type` and `entity_bundle` are added to every serialized entity
(root and nested). Non-reference fields serialize as core would; entity-reference fields are
replaced by the fully-normalized target entity (subject to depth and access below).

## Depth control (`max_depth`)

- `ContentEntityNormalizer` seeds the context on the root entity: `current_depth = 0` and
  `max_depth = 10` (`$defaultMaxDepth`) unless overridden.
- The root normalizer reads `?max_depth=` from the request query: `max_depth=0` means "root
  entity only, references left as bare targets"; any positive integer sets the cap. Non-numeric
  or negative values are ignored (default kept).
- `ReferenceItemNormalizer::normalize()` increments `current_depth` by 1 per reference hop and,
  when `current_depth === max_depth`, stops recursing and defers to the parent normalizer
  (emitting the plain reference, e.g. `target_id`/`url`, not the expanded entity).
- Keep `max_depth` to the smallest value your consumer needs; expansion cost grows with both the
  depth and the fan-out of the reference graph.

## Access behavior (partial trees are normal)

Access is re-checked at every level as the tree is walked, so a `json_recursive` response can
legitimately contain some references expanded and others collapsed:

- **Field level** — `ContentEntityNormalizer` skips any field where `$field->access('view')`
  is false (`continue`), and drops fields listed in
  `$context['settings'][$entity_type]['exclude_fields']`.
- **Entity level** — before recursing, `ReferenceItemNormalizer` loads the target, applies
  `getTranslationFromContext()`, adds it as a cacheable dependency, then only inlines it when
  `$entity->access('view')` is true and it is not disabled in settings; otherwise it defers to
  the parent normalizer and the reference stays a bare target.

A consumer must therefore treat the tree as possibly incomplete rather than assuming every
reference is expanded.

## Compatibility caveat (verified on core 11.4.5)

`ReferenceItemNormalizer::normalize()` declares the return type
`array|string|int|float|bool|\ArrayObject|null`, but the core parent
`EntityReferenceFieldItemNormalizer::normalize()` declares `: array`. PHP return types are
covariant (a child may narrow, never widen), so this class **fatals on load** under any core
whose parent uses the narrowed `: array` signature (Drupal 10.2+/11.x):

```
Declaration of Drupal\rest_entity_recursive\Normalizer\ReferenceItemNormalizer::normalize(...)
must be compatible with Drupal\serialization\Normalizer\EntityReferenceFieldItemNormalizer::normalize(...): array
```

Reproduced against this site's core (11.4.5). The recursive expansion is unusable on such
cores until the signature is narrowed; the encoder and `ContentEntityNormalizer` load fine.
