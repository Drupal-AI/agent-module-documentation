<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ServiceInjector demo plugins, ContentAuditor service & Drush commands

Source: `src/Plugin/ServiceInjector/ViewStorage.php`, `.../ConfigFactory.php`,
`.../Derivative/ConfigFactoryDeriver.php`, `src/ContentAuditor.php`,
`src/ContentAuditorInterface.php`, `src/Commands/DemoCommands.php`,
`dx_toolkit_demo.services.yml`, `drush.services.yml`.

## The ServiceInjector plugins

Both plugin classes have empty bodies and `extend Drupal\dx_toolkit\Plugin\ServiceInjectorBase`;
all behavior lives in the `@ServiceInjector` annotation.

- **ViewStorage** (`view_storage`): `factoryService = @entity_type.manager`, `factoryMethod =
  getStorage`, `factoryArguments = ["view"]`, `serviceClass = EntityStorageInterface`, prefix
  `service_injector`, suffix `storage`. Intended to generate `service_injector.view.storage`. No
  deriver — one service.
- **ConfigFactory** (`config_factory`): `factoryService = @config.factory`, `factoryMethod =
  getEditable`, `serviceClass = Config`, suffix `config`, `deriver = ConfigFactoryDeriver`.
  `ConfigFactoryDeriver::getDerivativeDefinitions()` returns one derivative per entry of a static
  list (`system.site`, `system.performance`, `node.settings`, `user.settings`), each setting
  `factoryArguments = [<config_name>]` and `configName`. Intended to generate e.g.
  `service_injector.system.site.config`.

## ContentAuditor service

`dx_toolkit_demo.content_auditor` (class `ContentAuditor`, interface `ContentAuditorInterface`) is
wired in `dx_toolkit_demo.services.yml` with four generated services as constructor arguments:
`@service_injector.node.storage`, `@service_injector.taxonomy_term.storage`,
`@service_injector.user.storage`, `@service_injector.system.site.config`. This is the whole point
of the demo: a clean constructor of typed storage/config objects instead of injecting
`EntityTypeManagerInterface` and calling `getStorage()` in the body.

- `auditSite()` → `['site_name', 'node_count', 'term_count', 'user_count', 'total_content']`.
  Counts via `countEntities()` (`getQuery()->accessCheck(FALSE)->count()->execute()`).
- `auditByType($entity_type_id)` — `match` on `node`/`taxonomy_term`/`user` (else throws
  `InvalidArgumentException`), returns `total_count` plus a sample of up to 10 entities
  (`id`, `label`, `bundle`). Query uses `accessCheck(FALSE)` — acceptable here because the code path
  is CLI/Drush-only reporting with no web-facing output.

## Drush commands (`DemoCommands`, tagged `drush.command`)

Attribute-based commands injecting `@dx_toolkit_demo.content_auditor`:

- `dx:demo:audit` — prints a table of site name and node/term/user/total counts.
- `dx:demo:audit-type <entity_type>` — argument `node`|`taxonomy_term`|`user`; prints the total and
  a sample table, catching `InvalidArgumentException` and printing an error for unsupported types.

## Accuracy caveat

The `service_injector.*` service ids these plugins/services depend on require a ServiceInjector
runtime (a `ServiceInjectorBase` class + a manager/compiler pass that registers the services) that
**is not present in the dx_toolkit 1.0.1 release**. As shipped against 1.0.1, enabling and running
the demo would not resolve those services. Use this code as a reference template for the pattern.
