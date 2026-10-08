<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — Resource templates

Resource templates expose Drupal data to MCP clients as readable **resources** addressed by a URI
template. They are Drupal plugins registered on the SDK builder by
`McpServerFactory::registerResources()`.

## The plugin type

- Manager `plugin.manager.mcp_server.resource_template` (`ResourceTemplateManager`); discovery dir
  `Plugin/ResourceTemplate`; attribute `Drupal\mcp_server\Attribute\ResourceTemplate` (args `id`,
  `label`, `description`, `module_dependencies = []`); interface `ResourceTemplateInterface`; base
  `ResourceTemplateBase`; alter `mcp_server_resource_template`; cache tag
  `mcp_server:resource_templates`.
- `ResourceTemplateInterface` methods: `getResourceType()`, `getTitle()`, `getDescription()`,
  `getDependencies()`, `getUriTemplate()`, `getResources()`, `getResourceContent(string $uri)`,
  `checkAccess(string $uri, AccountInterface $account): AccessResultInterface`, `getConfiguration()`,
  `setConfiguration()`, `isEnabled()`. `ResourceTemplateBase::checkAccess()` returns
  `AccessResult::forbidden()` by default (subclasses override); `parseUri()` parses the
  `drupal://entity/{entity_type}/{entity_id}` scheme.

## Registration flow

- Only plugins enabled in config object `mcp_server.resource_plugins` (`plugins[]` with
  `enabled: true`) are registered. `McpServerFactory::registerResources()` reads that config,
  instantiates each plugin with its stored `configuration`, and for each entry of `getResources()`
  calls `$builder->addResourceTemplate(handler: fn($uri) => $plugin->getResourceContent($uri),
  uriTemplate: …, name: …, description: …, mimeType: …)`.
- `getResources()` returns arrays with `uri`, `name`, `description?`, `mimeType?`
  (default `application/json`). Configure/enable via the resources page —
  see [../configure/settings.md](../configure/settings.md).

## Bundled example — `content_entity` (mcp_server_examples)

`ContentEntityResourceTemplate` (`#[ResourceTemplate(id: 'content_entity',
module_dependencies: ['jsonapi'])]`) exposes content entities via JSON:API:

- URI template `drupal://entity/{entity_type}/{entity_id}`; resource name
  `content_entity__<entity_type>`; MIME `application/vnd.api+json`.
- `getResources()` enumerates every `ContentEntityInterface` type; config `require_canonical_url`
  (default TRUE → only types with a `canonical` link template) and `denied_entity_types` (deny-list)
  filter the set.
- `getResourceContent($uri)` loads the entity and **returns NULL unless
  `$entity->access('view', $currentUser)`**, then serialises a `ResourceObject` /
  `JsonApiDocumentTopLevel` with the JSON:API serializer. `checkAccess()` delegates to
  `$entity->access('view', $account, TRUE)` with cache metadata. Entity access is enforced before any
  content is returned.

Write your own by placing a `#[ResourceTemplate]` plugin in `Plugin/ResourceTemplate`, implementing
`getUriTemplate()`/`getResources()`/`getResourceContent()`/`checkAccess()`, and enabling it on the
resources settings page.
