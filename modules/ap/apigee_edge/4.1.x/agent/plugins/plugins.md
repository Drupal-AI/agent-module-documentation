# Plugin types defined

## `ApigeeFieldStorageFormat` (public plugin type)

- Manager: `plugin.manager.apigee_field_storage_format` (`FieldStorageFormatManager`).
- Annotation: `\Drupal\apigee_edge\Annotation\ApigeeFieldStorageFormat` (`id`, `label`, `fields`,
  `weight`).
- Plugins live in `Plugin/ApigeeFieldStorageFormat/`. Each declares how a Drupal field value is
  (de)serialized into an Apigee **developer attribute** string, so custom user/app fields can be
  stored on Apigee. `FieldAttributeConverter` uses the manager to convert both directions.

Add one:
```php
namespace Drupal\my_module\Plugin\ApigeeFieldStorageFormat;

use Drupal\apigee_edge\Plugin\ApigeeFieldStorageFormatBase;

/**
 * @ApigeeFieldStorageFormat(
 *   id = "my_format",
 *   label = @Translation("My format"),
 *   fields = { "my_field_type" },
 * )
 */
class MyFormat extends ApigeeFieldStorageFormatBase { /* encode()/decode() */ }
```

## `EdgeEntityType` annotation (internal entity plugin type)

`\Drupal\apigee_edge\Annotation\EdgeEntityType` is a custom **entity type** annotation used to declare
the Apigee-backed entities (`developer`, `developer_app`, `api_product`, and `team`/`team_app` etc. in
submodules). It carries the usual handlers/links/labels but marks the entity as SDK-backed
(non-SQL). New Apigee entities generally extend `EdgeEntityBase` / `FieldableEdgeEntityBase` and use
this annotation — this is the extension point submodules use.

## Key plugins (for the `key` module)

The module also supplies Key-module plugins (not a new plugin *type*, but new plugins):

| Kind | Plugin id | Class |
|---|---|---|
| KeyType | `apigee_auth` | `ApigeeAuthKeyType` |
| KeyInput | `apigee_auth_input` | `ApigeeAuthKeyInput` |
| KeyProvider | `apigee_edge_environment_variables` | `EnvironmentVariablesKeyProvider` |
| KeyProvider | `apigee_edge_private_file` | `PrivateFileKeyProvider` |

See [../configure/connection.md](../configure/connection.md) for how these hold the Apigee
credentials.

## Field plugins
`Plugin/Field/FieldType|FieldWidget|FieldFormatter/` provide the app callback-url field
(`app_callback_url` widget) and status/credential formatters (e.g. `status_property`), plus a menu
link plugin `AppsListMenuLink` and validation constraints.
