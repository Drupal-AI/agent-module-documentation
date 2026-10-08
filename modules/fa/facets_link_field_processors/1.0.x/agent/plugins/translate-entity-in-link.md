<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TranslateEntityInLinkProcessor — "Transform entity link to label"

Class `Drupal\facets_link_field_processors\Plugin\facets\processor\TranslateEntityInLinkProcessor`
(`src/Plugin/facets/processor/TranslateEntityInLinkProcessor.php`). A Facets **build-stage** processor that
turns internal-entity link values into the referenced entity's label.

## Annotation / registration

```php
@FacetsProcessor(
  id = "facets_link_field_processors",
  label = @Translation("Transform entity link to label"),
  description = @Translation("Display the entity label instead of its URI from link field."),
  stages = { "build" = 5 }
)
```

Extends `ProcessorPluginBase`, implements `BuildProcessorInterface` and `ContainerFactoryPluginInterface`.
`create()` injects `language_manager` and `entity_type.manager` (stored as `$languageManager`,
`$entityTypeManager`).

## When it is offered (`supportsFacet()`)

The processor only appears for a facet when both hold on `$facet->getDataDefinition()`:

- `getDataType() === 'field_item:link'` (the facet source is a **core Link field**), and
- the field's `link_type` setting is `LinkItemInterface::LINK_GENERIC` or `LINK_INTERNAL` (the link field must
  allow **internal** URLs). Fields restricted to `LINK_EXTERNAL` are **not** supported.

## Configuration

`defaultConfiguration()` adds one key on top of the base processor config:

| Key | Default | Meaning |
|---|---|---|
| `remove_non_entities` | `FALSE` | When `TRUE`, `build()` drops any result whose link value does not resolve to a content entity (e.g. external URLs). When `FALSE`, such results are left untouched (raw URI still shown). |

`buildConfigurationForm()` renders it as a single checkbox **"Remove non entities"**. The value is persisted by
Facets in the facet entity's processor configuration — this module ships **no `config/schema`** of its own.

## What `build(FacetInterface $facet, array $results)` does

For each result:

1. `$value = $result->getRawValue();` — the stored link URI (e.g. `entity:node/1`).
2. `$entity = $this->getEntityFromLinkValue($value);`
3. If it is not a `ContentEntityInterface`: `unset()` the result when `remove_non_entities` is on, otherwise
   `continue` (leave the raw value).
4. If the entity `hasTranslation()` for the current language (`languageManager->getCurrentLanguage()`), switch to
   that translation.
5. `$result->setDisplayValue($entity->label());` — the (translated) label becomes the display value. The value is
   a plain string; Facets escapes it in its render pipeline.

Returns the (possibly reduced) `$results` array.

### `getEntityFromLinkValue(string $value): ?EntityInterface`

Resolves a link URI to an entity:

- `Url::fromUri($value)`; return `NULL` if not `isRouted()`.
- Split the route name on `.`; require exactly `entity.<type>.canonical` (`$parts[0] === 'entity'`,
  `$parts[2] === 'canonical'`).
- `entity_type.manager->getStorage($type)->load($url->getRouteParameters()[$type])`.
- Any `PluginNotFoundException` (unknown entity type) or other `\Exception` (e.g. malformed URI) → `NULL`.

So only routed internal entity-canonical links resolve; external URLs and non-canonical routes return `NULL`.

## Enable it (config equivalent)

Add the processor to a facet's `processor_configs` (facet config entity
`facets.facet.<id>`), e.g.:

```yaml
processor_configs:
  facets_link_field_processors:
    processor_id: facets_link_field_processors
    weights:
      build: 5
    settings:
      remove_non_entities: false
```

Then `drush cr`. Or via the Facets UI: edit the facet → **Processors** → enable *Transform entity link to label*.

## Notes

- Runs at build stage weight 5, so it operates on results already produced by earlier stages; combine freely with
  sort/count processors.
- Multilingual: the label follows the current interface language when the referenced entity has that translation;
  otherwise the entity's default label is used.
- Unit coverage: `tests/src/Unit/TranslateEntityInLinkProcessorTest.php` asserts `supportsFacet()` accepts
  generic/internal and rejects external link fields, that `entity:node/1` / `entity:taxonomy_term/2` are relabelled
  to their entity labels, and that `remove_non_entities` drops the plain-URL result.
