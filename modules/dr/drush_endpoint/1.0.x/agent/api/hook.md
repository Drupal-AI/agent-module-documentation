<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_help() implementation

The module implements a single hook, `hook_help()`, using Drupal's OO hook system.

- `drush_endpoint.module` keeps only a thin `#[LegacyHook]` `drush_endpoint_help()` shim that delegates to
  the service: `\Drupal::service(DrushEndpointHooks::class)->help($route_name)`.
- The real implementation is `Drupal\drush_endpoint\Hook\DrushEndpointHooks::help()`
  (`src/Hook/DrushEndpointHooks.php`), annotated `#[Hook('help')]`. The class is registered as an
  autowired service in `drush_endpoint.services.yml` and uses `StringTranslationTrait`.
- `help(string $route_name): string|null` returns, for `help.page.drush_endpoint`, the markup
  `<p>Provides HTTP endpoints for executing Drush commands.</p>`; for any other route it returns `null`.

That is the module's entire hook surface — there are no install/update hooks, no theme hooks, and no
other hook implementations.
