# Plugin types — JsonLdSource & JsonLdEntity

Two plugin managers, both extend `DefaultPluginManager` (`json_ld_schema.services.yml`):
- `plugin.manager.json_ld_schema.source` — dir `Plugin/JsonLdSource`, interface `JsonLdSourceInterface`,
  annotation `@JsonLdSource` (id, label). Alter hook: `json_ld_source_info`.
- `plugin.manager.json_ld_schema.entity` — dir `Plugin/JsonLdEntity`, interface `JsonLdEntityInterface`,
  annotation `@JsonLdEntity` (id, label). Alter hook: `json_ld_entity_info`.

Both `getData()` methods return a `\Spatie\SchemaOrg\Type` (fluent Schema.org builder from the
`spatie/schema-org` library). `JsonLdSchemaUtil::encodeJsonLdData($type->toArray())` serializes to a
`<script>`-safe JSON string (flags: `JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS |
JSON_HEX_AMP | JSON_HEX_QUOT | JSON_PRETTY_PRINT`).

## JsonLdSource — site-wide JSON-LD

Emitted by `json_ld_schema_page_bottom()`: for every source definition it `createInstance()`, checks
`isApplicable()`, and builds a `#type => 'json_ld_source'` render element (`src/Element/JsonLdSource.php`)
whose `#pre_render` (`preRenderGetData`) calls the plugin's `getData()` — so the expensive call is
deferred and stored in render cache under keys `['json_ld_source', <id>]`. Apply cache metadata via
`getCacheableMetadata()`.

Interface (`JsonLdSourceInterface`):
- `getData(): \Spatie\SchemaOrg\Type`
- `isApplicable(): bool` — base class returns `TRUE` (appears on every page). Override to scope.
- `getCacheableMetadata(): CacheableMetadata` — base returns empty.

Base class `JsonLdSourceBase` helpers: `absoluteUriString($uri)` (→ absolute URL string),
`formatTimestamp($timestamp)` (→ ISO-8601 `date('c', …)`).

```php
namespace Drupal\my_module\Plugin\JsonLdSource;

use Drupal\json_ld_schema\Source\JsonLdSourceBase;
use Spatie\SchemaOrg\Schema;
use Spatie\SchemaOrg\Type;

/**
 * @JsonLdSource(id = "my_org", label = @Translation("Organization"))
 */
class MyOrg extends JsonLdSourceBase {
  public function getData(): Type {
    return Schema::organization()->name('Acme')->url($this->absoluteUriString('internal:/'));
  }
}
```

## JsonLdEntity — per-entity JSON-LD

Emitted by `json_ld_schema_entity_view()`: for every entity-plugin definition it checks
`isApplicable($entity, $view_mode)`, merges `getCacheableMetadata($entity, $view_mode)` into the entity
`$build` (so the attachment is cached alongside entity render cache), then attaches a `<script
type="application/ld+json">` to `$build['#attached']['html_head']` keyed
`json_ld_<entityType>_<id>_<viewMode>_<pluginId>`.

Interface (`JsonLdEntityInterface`):
- `isApplicable(EntityInterface $entity, $view_mode): bool` — scope by entity type / bundle / view mode.
- `getData(EntityInterface $entity, $view_mode): \Spatie\SchemaOrg\Type`
- `getCacheableMetadata(EntityInterface $entity, $view_mode): CacheableMetadata` — base returns empty.

Base class `JsonLdEntityBase` provides the empty cacheable-metadata default; you implement
`isApplicable()` + `getData()`.

```php
namespace Drupal\my_module\Plugin\JsonLdEntity;

use Drupal\Core\Entity\EntityInterface;
use Drupal\json_ld_schema\Entity\JsonLdEntityBase;
use Spatie\SchemaOrg\Schema;
use Spatie\SchemaOrg\Type;

/**
 * @JsonLdEntity(id = "article", label = @Translation("Article"))
 */
class Article extends JsonLdEntityBase {
  public function isApplicable(EntityInterface $entity, $view_mode): bool {
    return $entity->getEntityTypeId() === 'node' && $entity->bundle() === 'article' && $view_mode === 'full';
  }
  public function getData(EntityInterface $entity, $view_mode): Type {
    return Schema::article()->headline($entity->label());
  }
}
```

Working example plugins to copy live in `tests/module/json_ld_schema_test_sources/src/Plugin/` (Node,
Organization, Breadcrumb, FAQ sources/entities).
