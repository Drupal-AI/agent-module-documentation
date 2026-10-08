<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAPI REST — agent index

Contributes one **`@OpenApiGenerator` plugin (id `rest`)** to the `openapi` module that
generates a Swagger/OpenAPI **2.0** spec of Drupal core's **REST** API by reading the site's
`rest_resource_config` entities. No settings form, no configure route, no config/schema of its
own, no permissions of its own (uses openapi's `access openapi api docs`), no Drush, no plugin
types defined here.

- **Fetch the spec, the generator id, options, deps, and how paths/definitions are built** →
  [api/generator.md](api/generator.md)

Key facts:
- Retrieve JSON: `GET /openapi/rest?_format=json` (openapi route `openapi.download`, permission
  `access openapi api docs`). Admin list: `/admin/config/services/openapi`.
- Output changes with the site's REST config: it only documents **enabled**
  `rest_resource_config` entities (core REST / REST UI). Enable a resource → it appears.
- Entity-resource schemas come from `schemata` + `schemata_json_schema` (`SchemaFactory`);
  bundles use OpenAPI `allOf` polymorphism.
- Programmatic: `\Drupal::service('plugin.manager.openapi.generator')->createInstance('rest')->getSpecification()`.
