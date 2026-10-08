<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `CrossSchema` plugin type — writing a driver

Source: `src/CrossSchemaPluginManager.php`, `src/Annotation/CrossSchema.php`,
`src/Plugin/CrossSchemaInterface.php`, `src/Plugin/CrossSchemaBase.php`. Reference implementations:
`modules/dbxschema_pgsql/src/Plugin/CrossSchema/PostgreSql.php` and
`modules/dbxschema_mysql/src/Plugin/CrossSchema/MySql.php`.

## What a driver plugin is

A `CrossSchema` plugin binds a Drupal database **driver name** (e.g. `pgsql`, `mysql`) to three
concrete classes that implement the cross-schema behavior for that RDBMS:

- **`DatabaseTool`** — must extend `Drupal\dbxschema\Database\DatabaseTool`.
- **`Connection`** — must implement `Drupal\dbxschema\Database\CrossSchemaConnectionInterface`.
- **`Schema`** — must implement `Drupal\dbxschema\Database\CrossSchemaSchemaInterface`.

## Discovery

- Manager: `CrossSchemaPluginManager` (service `plugin.manager.dbxschema`), a `DefaultPluginManager`.
- Plugins live in each module's `src/Plugin/CrossSchema/`.
- Annotation: `@CrossSchema` with `id`, `driver` (the DB driver string), and a translatable
  `description`.
- Cache tag/id `dbxschema`; **alter hook `dbxschema_info`** lets other modules modify definitions.
- `getInstance(['driver' => 'pgsql'])` returns the plugin whose annotation `driver` matches, or `FALSE`.

If **no** plugin is registered, `dbxschema_requirements()` reports a runtime error and the API is
unusable — this is why at least one driver submodule must be enabled.

## Minimal driver plugin

```php
namespace Drupal\my_driver\Plugin\CrossSchema;

use Drupal\dbxschema\Plugin\CrossSchemaBase;
use Drupal\my_driver\Database\Connection;
use Drupal\my_driver\Database\DatabaseTool;
use Drupal\my_driver\Database\Schema;

/**
 * @CrossSchema(
 *   id = "mydriver",
 *   description = @Translation("My RDBMS cross-schema implementation."),
 *   driver = "mydriver"
 * )
 */
class MyDriver extends CrossSchemaBase {
  public function getClass(string $class): ?string {
    static $classes = [
      'DatabaseTool' => DatabaseTool::class,
      'Connection'   => Connection::class,
      'Schema'       => Schema::class,
    ];
    return $classes[$class] ?? NULL;
  }
}
```

`CrossSchemaBase` already implements `description()` and `driver()` from the annotation; you only
implement `getClass()`. Your three classes then subclass the core driver's `Connection`/`Schema`
(mixing in `CrossSchemaConnectionTrait` / `CrossSchemaSchemaTrait`) and extend the base `DatabaseTool`,
supplying the driver-specific `SCHEMA_NAME_REGEXP`/`TABLE_NAME_REGEXP` and the DDL for
`createSchema`/`cloneSchema`/`renameSchema`/`dropSchema`/`schemaExists`/size methods.

## Proprietary (file-based) schemas

`Database\ProprietarySchemaInterface` + `ProprietarySchemaTrait` let a driver/consumer load a static
schema definition from a YAML file (`getSchemaDef(['source' => 'file', 'version' => …])`) rather than
introspecting the live database — for documenting or provisioning third-party (non-Drupal) layouts.
