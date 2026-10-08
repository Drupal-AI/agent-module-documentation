# Plugin types defined by libraries

Three plugin types, each a `default_plugin_manager` child with a `PluginID` annotation and plugins
discovered under `src/Plugin/libraries/<Dir>/`.

| Type | Annotation | Manager service | Dir | Interface | Core plugins |
|---|---|---|---|---|---|
| Library type | `@LibraryType` | `plugin.manager.libraries.library_type` (`LibraryTypeFactory`) | `Plugin/libraries/Type` | `LibraryTypeInterface` | `AssetLibraryType`, `MultipleAssetLibraryType`, `PhpFileLibraryType` |
| Locator | `@Locator` | `plugin.manager.libraries.locator` (`LocatorManager`) | `Plugin/libraries/Locator` | `LocatorInterface` | `ChainLocator`, `GlobalLocator`, `UriLocator` |
| Version detector | `@VersionDetector` | `plugin.manager.libraries.version_detector` (`VersionDetectorManager`) | `Plugin/libraries/VersionDetector` | `VersionDetectorInterface` | `LinePatternDetector`, `StaticDetector` |

### Implement one
```php
namespace Drupal\my_module\Plugin\libraries\VersionDetector;

use Drupal\libraries\Annotation\VersionDetector;
use Drupal\libraries\ExternalLibrary\Version\VersionDetectorInterface;
use Drupal\libraries\ExternalLibrary\Version\VersionedLibraryInterface;

/**
 * @VersionDetector("my_detector")
 */
class MyDetector implements VersionDetectorInterface {
  public function detectVersion(VersionedLibraryInterface $library) {
    // Inspect the library files and call $library->setVersion(...).
  }
}
```

- **Library type** — decides how a library is represented and loaded. Asset types implement
  `AttachableAssetLibraryRegistrationInterface` so their assets register with core.
  Optional lifecycle: `LibraryCreationListenerInterface`, `LibraryLoadingListenerInterface`.
- **Locator** — finds a library on the filesystem/by URI (`ChainLocator` tries several in order).
- **Version detector** — reads the installed version; `line_pattern` scans a file for a regex,
  `static` returns a hard-coded version.

Library objects extend `LibraryBase` and mix in traits (`LocalLibraryTrait`,
`VersionedLibraryTrait`, `DependentLibraryTrait`) to opt into local/versioned/dependent behavior.
