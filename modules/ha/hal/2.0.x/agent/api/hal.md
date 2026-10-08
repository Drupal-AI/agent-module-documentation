# API — the `hal_json` format, serializer & link manager

HAL registers services against core `serialization`; you rarely call normalizers directly —
you request the `hal_json` **format** from the core `serializer` service, and the tagged
normalizers/encoder do the rest.

## Serialize / deserialize with the `hal_json` format

```php
/** @var \Symfony\Component\Serializer\SerializerInterface $serializer */
$serializer = \Drupal::service('serializer');

// Entity -> HAL document.
$hal = $serializer->serialize($node, 'hal_json', ['account' => $account]);

// HAL document -> entity (denormalize). Context must name the target entity type.
$node = $serializer->deserialize($hal, \Drupal\node\Entity\Node::class, 'hal_json', [
  'account' => $account,
]);
```

The output shape: every entity gets a `_links` object with a `self` href, a `type` href (the
bundle URI), and one member per field (the relation URI); referenced entities are nested under
`_embedded` keyed by their relation URI. The `serializer.encoder.hal` (`JsonEncoder`) handles the
`hal_json` format; normalizers extend `Drupal\hal\Normalizer\NormalizerBase` whose `$format` is
`['hal_json']`.

## Normalizer services (tagged `normalizer`, format `hal_json`)

| Service | Class | Handles |
|---|---|---|
| `serializer.normalizer.entity.hal` | `ContentEntityNormalizer` | content entities (builds `_links`/`_embedded`) |
| `serializer.normalizer.field.hal` | `FieldNormalizer` | field lists |
| `serializer.normalizer.field_item.hal` | `FieldItemNormalizer` | generic field items |
| `serializer.normalizer.entity_reference_item.hal` | `EntityReferenceItemNormalizer` | entity_reference items |
| `serializer.normalizer.entity_reference_revisions_item.hal` | `EntityReferenceRevisionItemNormalizer` | entity_reference_revisions items |
| `serializer.normalizer.timestamp_item.hal` | `TimestampItemNormalizer` | timestamp items (ISO output) |
| `serializer.normalizer.file_entity.hal` | `FileEntityNormalizer` | file entities (adds file URL) |

Priorities matter: more specific normalizers (timestamp, entity_reference_revisions, file) use a
higher `priority` than the generic ones so they win.

## Link manager — building & resolving link URIs

`hal.link_manager` (`Drupal\hal\LinkManager\LinkManager`) implements `LinkManagerInterface`,
which combines `TypeLinkManagerInterface` + `RelationLinkManagerInterface`. It delegates to
`hal.link_manager.type` and `hal.link_manager.relation`.

```php
/** @var \Drupal\hal\LinkManager\LinkManagerInterface $lm */
$lm = \Drupal::service('hal.link_manager');

// Build URIs used in _links:
$type_uri     = $lm->getTypeUri('node', 'article', $context);          // bundle/type link
$relation_uri = $lm->getRelationUri('node', 'article', 'field_tags', $context); // field link

// Resolve URIs back to internal IDs (used when denormalizing inbound HAL):
$ids = $lm->getTypeInternalIds($type_uri);        // ['entity_type_id' => 'node', 'bundle' => 'article'] | FALSE
$rel = $lm->getRelationInternalIds($relation_uri); // ['entity_type_id','bundle','field_name']

// Override the domain used in generated URIs at runtime:
$lm->setLinkDomain('https://api.example.com');    // ConfigurableLinkManagerInterface
```

`setLinkDomain()` is the programmatic equivalent of the `hal.settings:link_domain` config value
(blank config = the site's own domain).

## Config

Single key, no admin form:

```
hal.settings:
  link_domain: ~      # domain for type/relation link URIs; ~/blank = current site domain
```

```bash
drush cset hal.settings link_domain 'https://api.example.com'
```
