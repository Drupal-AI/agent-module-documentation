# Services & utilities

Declared in `graphql_compose.services.yml`. Autowiring aliases exist for the classes, so you
can type-hint the class or use the service id.

## Plugin managers

| Service id | Class | Purpose |
|---|---|---|
| `graphql_compose.entity_type_manager` | `GraphQLComposeEntityTypeManager` | Discover/instantiate EntityType plugins. `getDefinitions()`, `getPluginInstance($entity_type_id)`. |
| `graphql_compose.field_type_manager` | `GraphQLComposeFieldTypeManager` | Discover FieldType plugins; map Drupal field types → GraphQL fields. |
| `graphql_compose.schema_type_manager` | `GraphQLComposeSchemaTypeManager` | Collect/`add()`/`extend()`/`get()` GraphQL `Type` objects; prints the schema. |

`graphql_compose.entity_type_manager->getDefinitions()` returns the set of entity types GraphQL
Compose *can* expose (used by the schema form and by `hook_entity_operation` to add "Copy UUID").

## Other services

| Service id | Class | Purpose |
|---|---|---|
| `graphql_compose.entity_type_wrapper` | `EntityTypeWrapper` (non-shared) | Wraps an EntityType plugin + a bundle; computes the SDL type name, description, exposed fields. `setEntityTypePlugin()->setEntity()`. |
| `graphql_compose.language_inflector` | `LanguageInflector` | doctrine/inflector-based singularize/pluralize for query names (honours the inflector settings + alter hooks). |
| `graphql_compose.config_context_service` | `Utility\ComposeConfig` | Static-style access to the active server's settings: `ComposeConfig::name()`, `ComposeConfig::get('settings.exclude_unpublished')`. |
| `access_check.graphql_compose` | `GraphQLComposeAccessCheck` | Implements the `_graphql_compose_access` route requirement. |
| `graphql_compose.alter_subscriber` | `EventSubscriber\AlterSchemaSubscriber` | Invokes the schema-type manager to add types/extensions at schema build. |
| `cache.graphql_compose.definitions` | cache bin | `graphql_compose_definitions` — cleared on config/entity changes. |

## Utilities (`src/Utility/`)

- `ComposeConfig` — read the current server's `graphql_compose.settings.*` config
  (`::get($key, $default)`), and its config name.
- `ComposeContext` — carries the current build context (server/schema) for the plugin managers.
- `ComposeProviders` — `ComposeProviders::invoke($hook, $args)` fans a hook out only across the
  server's enabled provider submodules (used for the form-alter hooks).

## Programmatic example

```php
// Which entity types can GraphQL Compose expose?
$defs = \Drupal::service('graphql_compose.entity_type_manager')->getDefinitions();

// Read a global setting for the active server.
use Drupal\graphql_compose\Utility\ComposeConfig;
$excludeUnpublished = ComposeConfig::get('settings.exclude_unpublished', TRUE);
```

There are **no Drush commands** and **no `permissions.yml`**; enable/disable of schema pieces is
config (see configure/schema.md), and route access uses the `_graphql_compose_access` check.
