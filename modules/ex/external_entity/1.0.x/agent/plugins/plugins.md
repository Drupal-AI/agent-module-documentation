<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: connection, authentication, render

Three annotation-based plugin types are discovered from `src/Plugin/ExternalEntity/<Kind>/` with
managers declared in `external_entity.services.yml` (each `parent: default_plugin_manager`).

## 1. Connection Type — `@ExternalEntityConnectionType`
- Annotation: `src/Annotation/ExternalEntityConnectionType.php`; manager
  `ConnectionTypeManager` (`plugin.manager.external_entity.connection_type`); base
  `Plugin/ExternalEntity/ExternalEntityConnectionTypeBase.php`; contract
  `Contracts/ExternalEntityConnectionTypeInterface.php`. Responsibilities: `fetchResourceDefinitions()`,
  `lookupDefinitions()`, `searchDefinitions()`, plus a settings form.
- **Shipped: `external_entity_server`** (`Plugin/ExternalEntity/ConnectionType/ExternalEntityServer.php`).
  Talks HTTP to a remote **External Entity Server** site. Settings: `server_domain` (URL, required) and
  `resources` (multi-select of exposed resource names). Uses `ClientFactory` (`http_client_factory`);
  `makeHttpRequest()` builds a Guzzle client with `base_uri = "{server_domain}/external-entity/"` and
  calls endpoints `status`, `resource`, `definition/{resource}/lookup`, `definition/{resource}/search`.
  JSON responses are decoded (`JSON_THROW_ON_ERROR`); exceptions are logged via `Error::logException`.
  The connection form validates connectivity by requesting `status` and checking for
  `status === 'connected'` before listing selectable resources.

## 2. Authentication Type — `@ExternalEntityAuthenticationType`
- Annotation: `src/Annotation/ExternalEntityAuthenticationType.php`; manager
  `AuthenticationTypeManager` (`plugin.manager.external_entity.authentication_type`); base
  `Plugin/ExternalEntity/ExternalEntityAuthenticationTypeBase.php`; contract
  `Contracts/ExternalEntityAuthenticationTypeInterface.php`. A connection's chosen auth plugin is asked
  to mutate the outbound HTTP options via `alterRequestOptions(array &$options)`, which
  `ExternalEntityServer::httpRequestOptions()` calls before every request.
- **Shipped: `basic_authentication`** (`Plugin/ExternalEntity/AuthenticationType/BasicAuthenticationType.php`).
  Stores `username` + `password`; `alterRequestOptions()` sets Guzzle `auth => [username, password]`
  (HTTP basic). The form leaves the password blank on edit and reuses the stored value if left empty
  (`validateConfigurationForm()` / `getOriginalPassword()` read it back from the saved connection).

## 3. Render Type — `@ExternalEntityRenderType`
- Annotation: `src/Annotation/ExternalEntityRenderType.php`; manager `RenderTypeManager`
  (`plugin.manager.external_entity.render_type`); base
  `Plugin/ExternalEntity/ExternalEntityRenderTypeBase.php`; contract
  `Contracts/ExternalEntityRenderTypeInterface.php`. A Resource Display picks a render type and stores
  its settings; `render(ExternalEntityInterface $entity, string $mode)` returns a render array.
- **Shipped: `internal_entity`** (`Plugin/ExternalEntity/RenderType/InternalEntityRenderType.php`).
  Settings: `entity_type`, `bundle`, `display`, `property_mapping`. `createEntity()` instantiates a
  **transient** local content entity of the configured type/bundle (never saved), attaches default
  `id`/`uuid` and maps remote properties onto local fields per `property_mapping`, caches the built
  entity in the `external_entity` bin keyed `external_entity:render_entity:{id}` with merged cache tags,
  then `renderEntityView()` runs the normal view builder for the chosen view `$mode`. Field/entity
  options for the form come from `Service\EntityTypeInfo`.

## Adding a custom plugin
Place a class in your module under `src/Plugin/ExternalEntity/<ConnectionType|AuthenticationType|RenderType>/`,
extend the matching base, add the annotation with a unique `id` + `label`, and (for connection/auth
plugins that need the connection) implement `ExternalEntityConnectionAwareInterface`
(use `ExternalEntityConnectionAwareTrait`). Provide a config schema entry
`external_entity.<your_id>.<connection_type|authentication_type|render_type>` mirroring the shipped
examples so settings persist. Configurable plugins use `PluginConfigurableTrait` / `PluginFormTrait`.
