# openapi — API, routes & spec

## Routes (verified against `openapi.routing.yml`)

| Route name | Path | Notes |
|---|---|---|
| `openapi.download` | `/openapi/{openapi_generator}` | Returns the spec as `JsonResponse`. GET, `_format: json`, permission `access openapi api docs`. |
| `openapi.downloads` | `/admin/config/services/openapi` | Admin "OpenAPI Resources" list of generators (View/Download links). Permission `access openapi api docs`. Also a menu link under `system.admin_config_services`. |
| `openapi.documentation` | `/admin/config/services/openapi/{openapi_ui}/{openapi_generator}` | Renders spec in a UI. **Only registered when the `openapi_ui` module is installed** (`_module_dependencies: 'openapi_ui'`) — absent otherwise. |

The `{openapi_generator}` slug is resolved to a plugin instance by the `openapi.parm_parser`
param converter (`type: openapi_generator`); an unknown id converts to `NULL`.

Convenience download URLs provided by the integration modules: `/openapi/rest`, `/openapi/jsonapi`.

## Spec download options

`ApiSpecificationController::getSpecification()` reads `$request->get('options', [])` and merges it
into the generator before building. Options honoured by `OpenApiGeneratorBase::includeEntityTypeBundle()`:

- `exclude` — array of `ENTITY_TYPE` or `ENTITY_TYPE:BUNDLE` strings to omit.
- `entity_mode` — `content_entities` or `config_entities` (restrict to one kind).
- `entity_type_id` — restrict to a single entity type.
- `bundle_name` — restrict to a single bundle.

Pass as query params, e.g. `/openapi/jsonapi?_format=json&options[entity_mode]=content_entities`.

## Getting a spec in code

```php
$manager = \Drupal::service('plugin.manager.openapi.generator'); // OpenApiGeneratorManager
$ids = array_keys($manager->getDefinitions());                   // available generators
$generator = $manager->createInstance('jsonapi');                // OpenApiGeneratorInterface
$generator->setOptions(['entity_mode' => 'content_entities']);
$spec = $generator->getSpecification();                          // array (Swagger 2.0)
```

With no generator plugin installed, `getDefinitions()` is empty and the downloads page shows a
warning to install OpenAPI REST or OpenAPI JSON:API.

## Spec structure (`OpenApiGeneratorBase::getSpecification()`)

Produces a **Swagger 2.0** document (`'swagger' => "2.0"`). Keys assembled: `swagger`, `schemes`,
`info` (title = site name + API name, `version: "Versioning not supported"`), `host`, `basePath`,
`securityDefinitions`, `security`, `tags`, `definitions`, `consumes`, `produces`, `paths`. Empty
optional arrays are stripped; `swagger`, `info`, `paths` are always kept.

`getSecurityDefinitions()` is derived automatically from the site's authentication providers
(`authentication_collector`): `basic_auth` → `{type: basic}`, `oauth2` → oauth2 flows (password /
authorizationCode / implicit / clientCredentials with `oauth/token` & `oauth/authorize` URLs), plus
an always-present `csrf_token` apiKey (`X-CSRF-Token` header, token URL `session/token`).

## Services

- `plugin.manager.openapi.generator` — `OpenApiGeneratorManager` (DefaultPluginManager; discovers
  `Plugin/openapi/OpenApiGenerator`, alter hook `openapi_generator`). See [plugins/openapi.md](../plugins/openapi.md).
- `openapi.parm_parser` — `OpenApiParamConverter` (tagged `paramconverter`); converts `openapi_generator` route params.

No config, no config schema, no Drush commands are provided by this module.
