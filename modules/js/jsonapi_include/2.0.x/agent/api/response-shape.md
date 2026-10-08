<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response shape: before vs after flattening

Request: `GET /jsonapi/node/article/{uuid}?include=field_tags`

## Standard JSON:API (module disabled)

The related term is linkage only under `relationships`, and the full resource lives in the
top-level `included` array — the client must cross-reference by `type` + `id`:

```json
{
  "jsonapi": { "version": "1.0" },
  "data": {
    "type": "node--article",
    "id": "…",
    "attributes": { "title": "Hello" },
    "relationships": {
      "field_tags": { "data": [ { "type": "taxonomy_term--tags", "id": "abc" } ] }
    }
  },
  "included": [
    { "type": "taxonomy_term--tags", "id": "abc", "attributes": { "name": "News" } }
  ]
}
```

## With JSON:API Include

Each relationship is resolved and the referenced resource's attributes/relationships are inlined
directly onto the field; there is no separate `included` stitching step for the client:

```json
{
  "jsonapi": { "version": "1.0" },
  "data": {
    "type": "node--article",
    "id": "…",
    "attributes": { "title": "Hello" },
    "field_tags": [
      { "type": "taxonomy_term--tags", "id": "abc", "name": "News" }
    ]
  }
}
```

Notes:
- Flattening is **recursive** and follows the request's `?include=` paths (e.g.
  `?include=uid.user_picture` inlines the author and, inside it, the author's picture).
- Single-value references become an object; multi-value references become an array of objects.
- The transformation is applied by `Drupal\jsonapi_include\JsonapiParse::parse()` on the response
  body; the module never changes what core JSON:API loads or its access checks — it only reshapes
  the already-authorized payload.
