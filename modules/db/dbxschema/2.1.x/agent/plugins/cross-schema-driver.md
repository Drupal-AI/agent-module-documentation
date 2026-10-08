<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `CrossSchema` plugin type — writing a driver

Source: `src/CrossSchemaPluginManager.php`, `src/Attribute/CrossSchema.php`,
`src/Annotation/CrossSchema.php`, `src/Plugin/CrossSchemaInterface.php`,
`src/Plugin/CrossSchemaBase.php`. Reference implementations:
`modules/dbxschema_pgsql/src/Plugin/CrossSchema/PostgreSql.php` and
`modules/dbxschema_mysql/src/Plugin/CrossSchema/MySql.php`.

## What a driver plugin is

A `CrossSchema` plugin binds a Drupal database **driver name** (e.g. `pgsql`, `mysql`) to three
concrete classes that implement the cross-schema behavior for that RDBMS:

- **`DatabaseTool`** — must extend `Drupal\dbxschema\Database\DatabaseTool`.
- **`Connection`** — must implement `Drupal\dbxschema\Database\CrossSchemaConnectionInterface`.
- **`Schema`** — must implement `Drupal\dbxschema\Database\CrossSchemaSchemaInterface`.

## Discovery

- Manager: `CrossSchemaPluginManager` (service `plugin.manager.dbxschema`), a `DefaultPluginManager`
  constructed with **both** the attribute class (`Attribute\CrossSchema`) and the legacy annotation
  class (`Annotation\CrossSchema`) — either declaration style is discovered.
- Plugins live in each module's `src/Plugin/CrossSchema/`.
- Attribute: `#[CrossSchema(id: …, driver: …, description: new TranslatableMarkup(…))]`
  (optional `deriver`). The equivalent legacy annotation `@CrossSchema(id, driver, description)` still
  works; the bundled drivers currently carry both for back-compat.
- Cache tag/id `dbxschema`; **alter hook `dbxschema_info`** lets other modules modify definitions.
- `getInstance(['driver' => 'pgsql'])` returns the plugin whose definition `driver` matches, or `FALSE`.

If **no** plugin is registered, the `runtime_requirements` hook
(`Hook\DbxschemaRequirementsHooks::runtime()`) reports a runtime error and the API is unusable — this
is why at least one driver submodule must be enabled.

## Minimal driver plugin

```php
namespace Drupal\my_driver\Plugin\CrossSchema;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\dbxschema\Attribute\CrossSchema;
use Drupal\dbxschema\Plugin\CrossSchemaBase;
use Drupal\my_driver\Database\Connection;
use Drupal\my_driver\Database\DatabaseTool;
use Drupal\my_driver\Database\Schema;

#[CrossSchema(
  id: 'mydriver',
  driver: 'mydriver',
  description: new TranslatableMarkup('My RDBMS cross-schema implementation.'),
)]
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

`CrossSchemaBase` already implements `description()` and `driver()` from the definition; you only
implement `getClass()`. Your three classes then subclass the core driver's `Connection`/`Schema`
(mixing in `CrossSchemaConnectionTrait` / `CrossSchemaSchemaTrait`) and extend the base `DatabaseTool`,
supplying the driver-specific `SCHEMA_NAME_REGEXP`/`TABLE_NAME_REGEXP` and the DDL for
`createSchema`/`cloneSchema`/`renameSchema`/`dropSchema`/`schemaExists`/size methods.

## Proprietary (file-based) schemas

`Database\ProprietarySchemaInterface` + `ProprietarySchemaTrait` let a driver/consumer load a static
schema definition from a YAML file (`getSchemaDef(['source' => 'file', 'version' => …])`) rather than
introspecting the live database — for documenting or provisioning third-party (non-Drupal) layouts
(`findVersion()`, `getAvailableInstances()`, `getVersion()`).
