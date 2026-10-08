# openapi_jsonapi — getting the JSON:API spec

This module adds **no new routes or services**; it registers the `jsonapi` generator into the base OpenAPI
module. Everything below is OpenAPI's machinery, applied to the `jsonapi` generator.

## Download route

| Route | Path | Notes |
|---|---|---|
| `openapi.download` | `/openapi/jsonapi` | GET, `_format: json`, permission `access openapi api docs`. Returns the Swagger 2.0 spec as `JsonResponse`. |

- Admin listing (`openapi.downloads`) at `/admin/config/services/openapi` shows a "JSON:API" row with View/Download links.
- With OpenAPI UI installed, browse it at `/admin/config/services/openapi/{openapi_ui}/jsonapi` (route `openapi.documentation`).
- The `{openapi_generator}` slug (`jsonapi`) is upcast to the plugin instance by the `openapi.parm_parser` param converter.

## Download options (query params)

`ApiSpecificationController` merges `?options[...]` into the generator (via `includeEntityTypeBundle()`):

- `options[entity_mode]` = `content_entities` | `config_entities`
- `options[entity_type_id]` = restrict to one entity type (e.g. `node`)
- `options[bundle_name]` = restrict to one bundle
- `options[exclude][]` = `ENTITY_TYPE` or `ENTITY_TYPE--BUNDLE` to omit

Example: `/openapi/jsonapi?_format=json&options[entity_type_id]=node`

## In code

```php
$manager = \Drupal::service('plugin.manager.openapi.generator');
$gen = $manager->createInstance('jsonapi');       // JsonApiGenerator
$gen->setOptions(['entity_type_id' => 'node']);   // optional scoping
$spec = $gen->getSpecification();                 // array: swagger 2.0 doc
// $spec['swagger'] === '2.0'; $spec['basePath'] === '/jsonapi';
// $spec['consumes'] === ['application/vnd.api+json']; $spec['info']['title'] ends with 'JSON API'
```

## Read-only mode affects the spec

`jsonapi.settings.read_only` (default TRUE) controls what is documented:

- **TRUE** → only read endpoints (GET/HEAD/OPTIONS/TRACE); POST/PATCH/DELETE paths are dropped.
- **FALSE** → mutating endpoints (Create/Update/Remove) are included.

Check/toggle: `drush cget jsonapi.settings read_only` / `drush cset jsonapi.settings read_only 0 -y`.

## Gotcha: whole-site spec on complex sites

Building the spec for **every** JSON:API resource walks related/relationship routes. On a site where a
relationship's target resource type cannot be resolved (e.g. its target is internal/disabled), the generator hits an
`assert(is_a($target, ResourceType::class))` and the full build throws (an `AssertionError` when `zend.assertions`
is on, as in dev/DDEV). Reliable workaround: **scope the request** to a concrete type, e.g.
`$gen->setOptions(['entity_type_id' => 'node'])` or `?options[entity_type_id]=node` — scoped routes skip the broken
relationship. This is a data/environment condition, not a config of this module.

## What it does NOT add

No config form (`configure` is null), no config schema, no permissions of its own (reuses `access openapi api
docs`), no Drush commands, no services. Payload schemas come from `schemata` / `schemata_json_schema`.
