# openapi — the `openapi_generator` plugin type

OpenAPI's only extension point. Each generator plugin describes one API (e.g. core REST, JSON:API)
and produces a spec. The core module ships **no** generators — they come from OpenAPI REST /
OpenAPI JSON:API, or you write your own.

## Discovery

- Manager service: `plugin.manager.openapi.generator` (`OpenApiGeneratorManager`, a `DefaultPluginManager`).
- Namespace scanned: `Plugin/openapi/OpenApiGenerator` in every module.
- Annotation: `@OpenApiGenerator` (`Drupal\openapi\Annotation\OpenApiGenerator`) with `id` and `label`.
- Interface: `Drupal\openapi\Plugin\openapi\OpenApiGeneratorInterface`.
- Alter hook: `hook_openapi_generator_alter($definitions)` (cache id `openapi_generator_plugins`).

> This 2.x release uses **annotation** discovery (`@OpenApiGenerator`), not PHP attributes.

## Implementing a generator

Extend `OpenApiGeneratorBase` (implements the interface + `ContainerFactoryPluginInterface`). The
base assembles the Swagger 2.0 skeleton and gives you security definitions, entity filtering, and
JSON-schema helpers; you supply the API-specific parts.

```php
namespace Drupal\my_module\Plugin\openapi\OpenApiGenerator;

use Drupal\openapi\Plugin\openapi\OpenApiGeneratorBase;

/**
 * @OpenApiGenerator(
 *   id = "my_api",
 *   label = @Translation("My API"),
 * )
 */
class MyApiGenerator extends OpenApiGeneratorBase {

  public function getApiName() { return 'My API'; }

  protected function getApiDescription() { return 'Docs for My API.'; }

  public function getPaths() { /* return OpenAPI paths array */ return []; }

  public function getDefinitions() { /* return entity/bundle schemas */ return []; }

  protected function getJsonSchema($described_format, $entity_type_id, $bundle_name = NULL) {
    return []; // per-entity JSON schema
  }
}
```

### Abstract methods you must implement
- `getApiName()` — API name (used in `info.title`).
- `getApiDescription()` — API description.
- `getJsonSchema($described_format, $entity_type_id, $bundle_name = NULL)` — JSON schema for an entity type/bundle.

### Commonly overridden (default to empty in the base)
`getPaths()`, `getDefinitions()`, `getTags()`, `getConsumes()`, `getProduces()`, `getBasePath()`.

### Provided by the base — reuse, don't reimplement
- `getSpecification()` — builds and prunes the full Swagger 2.0 doc.
- `getSecurityDefinitions()` / `getSecurity()` — auto-derived from auth providers (basic, oauth2, csrf_token).
- `setOptions()` / `getOptions()` and `includeEntityTypeBundle()` — honour `exclude`, `entity_mode`, `entity_type_id`, `bundle_name`.
- `getEntityResponses()`, `getDefinitionReference()`, `getEntityDefinitionKey()`, `definitionExists()`, `cleanSchema()`.

### Constructor services injected into every generator
`entity_type.manager`, `router.route_provider`, `entity_field.manager`, `serializer`,
`request_stack`, `config.factory`, `authentication_collector`. Add your own via a `create()` override.

Once discovered, a generator automatically gets a download URL (`/openapi/{id}`), appears on the
`/admin/config/services/openapi` list, and is resolvable by the `openapi_generator` param converter.

Reference implementation in this repo's test fixtures: `tests/modules/openapi_test/src/Plugin/openapi/OpenApiGenerator/NullGenerator.php`.
