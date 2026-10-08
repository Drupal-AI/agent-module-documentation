<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crema class-replacement API

How to make Crema swap a PHP class, and how the swap works internally. Everything is
driven by `info.yml`; there is no config, service, route, or Drush command.

## Install / enable
- `drush en crema` (or install as any contrib module). No dependencies, no config to set.
- A module that wants to replace classes should declare `crema` in its own
  `dependencies:` so the loader is active before its classes are needed.

## The `class_replacements` info.yml contract
Add to the *consuming* module's `.info.yml` a map of **original FQCN → replacement file**
(path relative to that module's root):

```yaml
name: Migration Manager Replacement
type: module
dependencies:
  - crema:crema
class_replacements:
  'Drupal\migrate\Plugin\MigrationPluginManager': 'src/migrate/MigrationPluginManager.php'
  'Drupal\migrate_drupal\MigrationPluginManager': 'src/migrate_drupal/MigrationPluginManager.php'
```

Authoring rules for the replacement file (from `README.md` / project page and enforced by
`ClassCamouflage`):
- Its namespace must be the original namespace with the leading `Drupal` replaced by
  `Crema` (e.g. `Drupal\migrate\Plugin` → `Crema\migrate\Plugin`). A namespace starting
  `CremaDropThis\…` is also recognised and simply stripped back to the bare original.
- The class/trait/interface name must equal the replaced one.
- To extend the original, add an aliased `use` of the original FQCN, e.g.
  `use Drupal\migrate\Plugin\MigrationPluginManager as Original;` then
  `class MigrationPluginManager extends Original`. Crema makes the original reachable so
  this resolves.
- File must begin with `<?php`, declare a namespace, and contain exactly one
  class/trait/interface (`ClassCamouflageTokenParser::getSimplifiedTokens()` throws
  `\LogicException` otherwise).

## How it is wired (`CremaServiceProvider::register()`)
Runs during container build (service provider auto-discovered by the module-root
`<Module>ServiceProvider` naming convention — there is no `crema.services.yml`).
1. Gets `container.modules`, the `kernel`, and the `info_parser` service.
2. `array_reduce` over every module: `info_parser->parse($module_info['pathname'])`,
   pull `class_replacements`, and rewrite each relative replacement path to
   `<module dir>/<relative path>`. Merges all into `$all_replacements`
   (keyed by original FQCN).
3. **Returns early if `$all_replacements` is empty** — zero overhead on sites that use no
   replacements.
4. For each replaced FQCN matching `Drupal\<module>\…`, if `<module>` is an installed
   module it builds `$originals['Drupal\_original_\<module>'] = <appRoot>/<module>/src`.
5. `createCremaClassLoader()` uses **reflection** on the kernel's Composer `ClassLoader`
   (`classLoader` property) to copy its `vendorDir`, `prefixLengthsPsr4`, `prefixDirsPsr4`,
   class map, and `classMapAuthoritative` flag into a new `CremaClassLoader`, and stores
   the original loader via `setOriginalLoader()`.
6. `$replacement_loader->register(TRUE)` — `spl_autoload_register(..., prepend: TRUE)` so
   Crema resolves the affected classes before the standard autoloader.

## Load-time behaviour (`CremaClassLoader::loadClass()`)
- If the requested class is a replaced FQCN (present in `$info`): finds the replacement
  file (`findCamouflageFile()` → `file_exists`) and calls
  `_crema_include_replacement_file()`; throws `\LogicException('Cannot find replacement class')`
  if missing.
- If the requested class matches `…\_original_\<module>\…` (regex on
  `ORIGINAL_SUBNAMESPACE = '_original_'`): computes the true original FQCN, then loads
  either the camouflaged original file (`findCamouflagedOriginalFile()`, a PSR-4 lookup
  over the copied prefix maps) or the file found by the delegate loader's `findFile()`,
  via `_crema_include_original_file()`; throws `\LogicException('Cannot include original class')`
  on failure.
- Otherwise returns `NULL` (defers to the next autoloader).

Both include helpers build a `ClassCamouflage` from the file, write the rewritten source to
`tmpfile()`, and `include` the stream URI in an isolated function scope
(`_crema_include_file()`), then `fclose()`.

## Source rewriting (`ClassCamouflage` + `ClassCamouflageTokenParser`)
Rewrites happen on PHP tokens (`token_get_all`), not by regex on raw source, via the static
helpers in `ClassCamouflageTokenParser` (`getSimplifiedTokens`, `getNameSpace`, `getName`,
`getNameIndex`, `getExtendedImplemented`, `getClassNamesFromUseStatements`,
`getClassNamesWithDirectUsage`, `tokensToString`, …). `TokenParserShim::massageTokens()`
joins `T_STRING`/`T_NS_SEPARATOR` runs so PHP < 8.1 tokenises like 8.1+.
- **`getNew()`** (replacement file → registers under original name): rewrites the namespace
  `Crema\Foo` → `Drupal\Foo` (or strips a `CremaDropThis\` prefix), and suppresses any
  self-referencing use of the new FQCN by inserting `_original_` so the class does not
  collide with itself.
- **`getCamouflaged()`** (original file → registers under `Drupal\_original_\…`): rewrites
  the namespace to insert `_original_`, adds `use` statements for extended/implemented/used
  classes that lived in the original namespace, fully-qualifies self references, and forces
  every `class` to `abstract` (so the original is only ever used as a parent, never
  instantiated directly).

## Limitations (from README / project page)
- A given class/trait/interface can be replaced **only once**.
- No debugger breakpoints work in a replaced or replacement file (they are loaded from a
  temp stream, not their real path).
- Only `Drupal\*` classes, and "most but not all" — **not** kernels, database driver
  classes, and similar special cases.
- Each file must be **< ~2MB** (PHP `php://temp`/`tmpfile` stream limit).

## Tests (reference for behaviour)
`tests/src/Unit/ClassCamouflageTest.php`, `tests/src/Unit/Utility/ClassCamouflageTokenParserTest.php`,
`tests/src/Kernel/CremaBasicsTest.php`, `tests/src/Functional/CremaTest.php`, plus example
consumers under `tests/modules/` (`crema_migrate_test`, `crema_interface_override_test`)
whose info.yml show real `class_replacements` maps.
