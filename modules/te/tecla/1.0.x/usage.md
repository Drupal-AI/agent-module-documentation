<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tecla is a PHPUnit test helper that deregisters PSR-4 namespaces of disabled/uninstalled extensions from Drupal's class loader so tests behave more realistically.
---
When running PHPUnit tests, Drupal's `TestDiscovery::registerTestNamespaces()` registers PSR-4 prefixes for *all* discovered extensions, including disabled ones. This can mask autoload-related bugs. Tecla's `TeclaServiceProvider::alter()` runs at container-build time, reflects into the kernel's class loader, and unsets any `Drupal\<module>\` PSR-4 prefix whose module is not in `container.modules` (keeping core `Drupal\Core\`, `Drupal\Driver\`, `Drupal\Component\`).

The module is test-only and self-defends: `alter()` throws a `\LogicException` if `drupal_valid_test_ua()` is false, so it refuses to run outside a test environment. It has no configuration, routes, permissions, or services beyond the service provider, and uses reflection (minor performance cost) rather than any request-facing code.

Typical setup: install as a dev dependency and enable in the test site profile; no configuration is needed.
---
- Install as a dev/test dependency to harden PHPUnit runs.
- Remove disabled modules' PSR-4 mappings during kernel tests.
- Surface autoload bugs hidden by over-eager test namespace registration.
- Keep only core PSR-4 prefixes in the test class loader.
- Guard against Tecla accidentally running outside a test UA.
- Use in CI to get more realistic autoloading behavior.
- Pair with Kernel tests that assert on class availability.
- Debug "class exists when it shouldn't" test flakiness.
- Add to a testing-only module set enabled by test runners.
- Verify a module's autoloading works without sibling modules present.
- Reproduce production autoload scoping inside kernel tests.
- Catch tests that accidentally depend on a disabled module's classes.
- Enable only during a functional/kernel test bootstrap.
- Keep core `Component`/`Driver` classes available while pruning contrib.
- Confirm a service class fails to load when its module is off.
- Reduce false test passes caused by leaked PSR-4 prefixes.
- Use as a diagnostic when a test behaves differently under Drush vs CI.
