# Use libraries in code

Central service `libraries.manager` → `Drupal\libraries\ExternalLibrary\LibraryManagerInterface`.

```php
/** @var \Drupal\libraries\ExternalLibrary\LibraryManagerInterface $m */
$m = \Drupal::service('libraries.manager');

$library = $m->getLibrary('my_library');   // LibraryInterface (throws if def/type not found)
$id      = $library->getId();

$m->load('my_library');                     // load non-asset library files (PHP-file etc.)
$ids = $m->getRequiredLibraryIds();         // IDs required via extensions' library_dependencies
```

- `getLibrary($id)` — resolves the definition (JSON/YAML), instantiates the typed library object.
  Throws `LibraryDefinitionNotFoundException` / `LibraryTypeNotFoundException`.
- `load($id)` — loads files for library types that support explicit loading. **Asset** libraries
  are *not* loaded this way: they are registered with core's library system (see below) and then
  attached via `#attached['library']`.
- `getRequiredLibraryIds()` — libraries any enabled module/theme/profile declared through a
  `library_dependencies:` info-file key.

### How asset libraries reach a page
`libraries_library_info_build()` (in `libraries.module`, implementing `hook_library_info_build`)
walks `getRequiredLibraryIds()`, and for each type implementing
`AttachableAssetLibraryRegistrationInterface` registers its assets with core so they become
attachable like any `module/library`.

### Related services
- `libraries.definition.discovery` — resolves a library's definition. Built by
  `libraries.definition.discovery.factory`; default fetches JSON from the remote registry into
  `public://library-definitions`. Swappable for `FileDefinitionDiscovery` (local YAML).
- `plugin.manager.libraries.library_type` / `.locator` / `.version_detector` — the three plugin
  managers (see [plugins/plugin-types.md](../plugins/plugin-types.md)).
- `cache.libraries` — the `libraries` cache bin holding detection results.
- Stream wrappers: `library-definitions://`, `asset://`, `php-file://`.
