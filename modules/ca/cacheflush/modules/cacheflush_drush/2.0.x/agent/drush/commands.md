# The `cacheflush` (`cf`) Drush command

## Usage

```bash
drush cacheflush <id>   # clear the published preset with entity id <id>
drush cf <id>           # same (alias)
drush cf                # list published presets as "[id] : title"
drush cf 5              # example: clear preset 5
```

Behaviour (both implementations):
- With a **numeric id**: `cacheflush_load($id)`; if it exists and `status == 1`, run
  `CacheflushApi::create(\Drupal::getContainer())->clearPresetCache($preset)` (clears the preset's
  configured caches). If missing/unpublished → "No entity with this id …, or entity not published".
  Non-numeric arg → asks for a numeric id.
- With **no argument**: iterates `cacheflush_load_multiple_by_properties(['status' => 1])` and prints
  `[id]   :   title` for each published preset.

## Two implementations in the codebase

- **Modern** (`src/Commands/CacheflushDrushCommands.php`, registered by `drush.services.yml` as a
  `drush.command` service): `#[command] cacheflush`, `#[aliases] cf`.
- **Legacy Drush 8** (`cacheflush_drush.drush.inc`: `hook_drush_command()` +
  `drush_cacheflush_drush_cacheflush()`), aliases `['cf']`. Modern Drush ignores this file.

## Compatibility caveat (must read)

`CacheflushDrushCommands` declares `protected $logger;` (untyped), overriding the installed Drush
base class property `DrushCommands::$logger` which is typed `?\Psr\Log\LoggerInterface`. PHP rejects
this at class load:

```
Type of Drupal\cacheflush_drush\Commands\CacheflushDrushCommands::$logger must be
?Psr\Log\LoggerInterface (as in class Drush\Commands\DrushCommands)
```

Drush loads command classes during its bootstrap/command-discovery, so **with this submodule enabled
every `drush` command fatals** — including `drush pmu cacheflush_drush`. On this documentation site it
is therefore kept **uninstalled**. (Also note the constructor does
`$logger_factory->get('qa_accounts')` — a copy-paste channel name unrelated to cacheflush.)

To use the command you would first update the class to the current base signature (type the property
`protected ?LoggerInterface $logger;` or drop the redeclaration). Until then, clear presets via the
UI / routes (`/admin/cacheflush/clear/{id}`) or `\Drupal::service('cacheflush.api')->clearById()`
instead.
