Libraries API provides a generic, module-independent way for Drupal to discover, version-detect, and load external front-end and PHP libraries that cannot be shipped inside contrib modules for licensing reasons.

---

External libraries (jQuery plugins, JS/CSS toolkits, PHP files) are deliberately not bundled with contrib modules, so multiple modules that integrate with the same library need a shared place to describe and locate it. Libraries API solves this by keeping each library's metadata — machine name, files, version, dependencies, variants — separate from any one module, then exposing it through the `libraries.manager` service. In this Drupal 8+ rewrite, libraries are typed, classed objects: a **library type** plugin (asset, multiple-asset, PHP-file) decides how a library is registered and loaded, a **locator** plugin finds it on disk or by URI, and a **version detector** plugin reads its version from a file. Library definitions are discovered as JSON (fetched from a remote registry into `public://library-definitions`) or as local YAML files via a swappable discovery service. Asset library types register the external assets with Drupal core's own library system so they can be attached to render arrays. Modules and themes declare that they need a library by adding a `library_dependencies` key to their info file. The legacy Drupal 7-style `hook_libraries_info()` still exists but is deprecated in favour of the plugin/definition system. It ships config for the definition discovery (remote registry URLs, local path, global locators) and a legacy Drush `libraries-list` command.

---

- Share a single copy of an external JS/CSS library across several modules that all integrate with it.
- Register a third-party asset library (e.g. a jQuery plugin) with Drupal core so it can be attached to render arrays.
- Detect the installed version of an external library from a changelog or source file via a version detector plugin.
- Declare that a module or theme requires a library by adding `library_dependencies` to its `.info.yml`.
- Load a set of PHP files on demand through the PHP-file library type (Drupal 7 feature parity).
- Locate a library placed in the site-wide `libraries` directory using the URI/global locator plugins.
- Serve library definitions as version-controlled local YAML instead of the remote JSON registry.
- Fetch canonical library definitions automatically from the remote libraries registry.
- Disable remote definition fetching entirely and manage definitions locally.
- Point the definition discovery at a custom registry URL for an intranet/offline site.
- Add support for a brand-new library type by implementing a `LibraryType` plugin.
- Add a custom way to find libraries on disk by implementing a `Locator` plugin.
- Add a custom version-detection strategy by implementing a `VersionDetector` plugin.
- Override the class used for an existing library type, locator, or detector via the alter hooks.
- Programmatically fetch a library object with `\Drupal::service('libraries.manager')->getLibrary($id)`.
- Programmatically load a library's files with the manager's `load()` method.
- Enumerate all libraries required by enabled extensions via `getRequiredLibraryIds()`.
- List registered libraries and their install status/version/variants with `drush libraries-list`.
- Declare per-library dependencies (including version constraints) so dependent libraries load together.
- Provide minified vs. source variants of the same library and switch between them.
- Ship version-specific file lists so different library releases load different assets.
- Attach module integration files that load only when a given module is enabled.
- Support decoupled/multi-site setups where the same external library lives in one shared location.
- Migrate a Drupal 7 `hook_libraries_info()` integration to the new typed-library plugin system.
- Cache library detection results and clear them via the `libraries` cache bin.
- Prevent duplicate, race-prone library declarations by centralising metadata outside modules.
