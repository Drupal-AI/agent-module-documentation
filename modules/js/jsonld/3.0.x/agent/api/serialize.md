<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Producing JSON-LD for an entity

Grounded in `jsonld.services.yml`, `src/Normalizer/ContentEntityNormalizer.php`,
`src/Controller/JsonldContextController.php`, and `src/Utils/JsonldNormalizerUtils.php`.

## The `jsonld` format is driven by core RDF mappings

The normalizer only emits fields that have an **RDF mapping** on their bundle
(`rdf_get_mapping($entity_type, $bundle)->getPreparedFieldMapping($field)`). A field with no
mapping is silently skipped, and the bundle's `rdf:type` becomes the document `@type`. So the
shape of the output is configured in the **RDF module**, not here. Fields the current user
cannot `view` are also skipped (`$field->access('view', $context['account'])`).

## Serialize in code

```php
$json = \Drupal::service('serializer')->serialize($node, 'jsonld');
// Or get the array without encoding:
$array = \Drupal::service('serializer')->normalize($node, 'jsonld');
```

Verified against the live site (a `page` node with the default schema.org mapping):

```json
{"@graph":[{"@id":"","@type":["http://schema.org/WebPage"],
  "http://schema.org/name":[{"@value":"JSONLD test","@language":"en"}],
  "http://schema.org/dateCreated":[{"@value":"2026-08-03T10:08:23+00:00",
    "@type":"http://www.w3.org/2001/XMLSchema#dateTime"}]}]}
```

(`@id` is empty for an unsaved entity; a saved entity gets its URL, e.g.
`https://site/node/1?_format=jsonld`.)

## Normalization context keys (ContentEntityNormalizer::normalize)

| Key | Effect |
|---|---|
| `needs_jsonldcontext` | `TRUE` → include an inline `@context` (RDF namespaces) and use short prefixed types; default `FALSE` emits fully-qualified predicate/type IRIs. |
| `included_fields` | Array of field names → output ONLY those fields (e.g. an LDP/fcrepo-compatible subset). |
| `account` | `AccountInterface` used for the per-field `view` access check; `NULL` (default) = current user. |
| `embedded` | Internal — set when normalizing a referenced entity so `@graph` stays associative. |

```php
$json = \Drupal::service('serializer')->serialize($node, 'jsonld', [
  'needs_jsonldcontext' => TRUE,
  'included_fields' => ['title', 'field_subject'],
]);
```

## Over HTTP

There is **no route in this module that returns entity JSON-LD**. Enable a serialization-aware
route (core REST `rest`, or an Islandora route) and request the entity with the format:

```
GET /node/1?_format=jsonld
Accept: application/ld+json
```

The `jsonld` encoder sets the response body; the requesting route is responsible for entity
access. By default each `@id` carries a `?_format=jsonld` suffix — disable it in
`jsonld.settings` (`remove_jsonld_format`, see [../configure/settings.md](../configure/settings.md)).

## The @context endpoint

`GET /jsonld/context/{entity_type}/{bundle}` (permission `access content`) returns the JSON-LD
`@context` for a bundle as `application/ld+json`, built by the `jsonld.contextgenerator` service
and cached (tags from the bundle's `rdf_mapping`). Example: `/jsonld/context/node/article`.

```php
$context = \Drupal::service('jsonld.contextgenerator')->getContext('node.article');
```

## Entity URIs

`\Drupal::service('jsonld.normalizer_utils')->getEntityUri($entity)` returns the canonical
`@id` and honors the `remove_jsonld_format` setting (with/without the `?_format=jsonld` suffix).

## Deserialize (JSON-LD/HAL → entity)

`ContentEntityNormalizer::denormalize()` builds an entity from an incoming document. It requires
a HAL-style `_links['type']` (resolved via the `hal` link manager) to pick the entity type +
bundle, then maps remaining keys to fields. Use it for write endpoints that accept Linked Data.
