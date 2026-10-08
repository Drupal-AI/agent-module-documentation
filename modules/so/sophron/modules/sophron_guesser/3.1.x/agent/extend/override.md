# Core guesser override

Mechanism: a service provider, not config.

- `src/SophronGuesserServiceProvider.php` (`extends ServiceProviderBase`) implements `alter()`,
  which takes the core `Drupal\Core\File\MimeType\MimeTypeMapInterface` service definition and
  `setClass(SophronMimeTypeMap::class)`, injecting `SophronMimeTypeMapFactory`.
- `src/SophronMimeTypeMap.php` + `src/SophronMimeTypeMapFactory.php` build the map from
  Sophron's `MimeMapManager`, so core's guesser now uses Sophron's (configurable) mapping.

Because it is a container alter, the swap applies as soon as the module is enabled and the
container is rebuilt — there is nothing to configure. Custom mappings and the selected map class
come from the main Sophron settings.
