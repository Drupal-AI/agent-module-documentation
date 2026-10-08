Crema (Class Replacement Manager) is a proof-of-concept developer module that lets a module "replace" existing PHP classes by declaring them in its own `info.yml`, without patching core or contrib source.

---

Crema reads a `class_replacements` key from every enabled module's `.info.yml` at container-build time and, when any is found, prepends a custom Composer class loader (`CremaClassLoader`) in front of Drupal's autoloader. Each entry maps a fully-qualified class name (the class you want to replace, e.g. `Drupal\migrate\Plugin\MigrationPluginManager`) to a replacement PHP file relative to the declaring module's root. When PHP first needs the replaced class, Crema loads your replacement file instead — rewriting its namespace from `Crema\…` to `Drupal\…` on the fly (token-level "camouflage") so the class registers under the original name. The original class is still reachable under a synthesised `Drupal\_original_\…` namespace (rewritten to an `abstract` class), so your replacement can `extend` it and call through. This is an intentionally hacky, experimental mechanism: it works for most `Drupal\*` classes (services, plugin managers, etc.) but not kernels, database driver classes, or other special cases, a class can only be replaced once, breakpoints do not work in replaced/replacement files, and each file must be under ~2MB because loading goes through a PHP temporary stream. It ships no routes, permissions, services.yml, configuration, or UI — everything is driven purely by module info.yml declarations and consumed by developers.

---

- Override Drupal core's `MigrationPluginManager` to change default migration behaviour without a core patch.
- Swap a contrib module's service class for a fixed/patched version while waiting on an upstream release.
- Prototype a bug fix in a core or contrib class quickly to confirm a hypothesis before writing a real patch.
- Provide a site-specific behavioural tweak to a class that offers no plugin/alter/event hook of its own.
- Replace a plugin manager class to inject different `$defaults` (e.g. a custom plugin base class).
- Extend a `final`-ish or hard-to-decorate class by declaring a replacement that `extends` the camouflaged original.
- Change protected properties or methods of an existing class that cannot be reached via a service decorator.
- Test alternative implementations of an interface or trait during development.
- Apply a temporary hotfix to a class in production-adjacent environments without editing vendor files.
- Centralise several class overrides for one feature in a single custom module's info.yml.
- Replace a class that is instantiated directly (not via the service container) where a `ServiceProvider` alter cannot help.
- Demonstrate/teach how Drupal's autoloader and Composer `ClassLoader` internals work (educational PoC).
- Layer a replacement on top of another module's class as long as no one else already replaced it.
- Adjust default configuration baked into a class constructor by subclassing it through Crema.
- Verify that a proposed refactor of a core class behaves before contributing it upstream.
- Replace a utility/helper class to add logging or instrumentation during debugging sessions.
- Provide a compatibility shim for a class whose signature changed between Drupal versions.
- Ship an override alongside a module (as its own dependency) so installs get the replaced behaviour automatically.
