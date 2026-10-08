Devel is a developer toolkit that adds debugging helpers, introspection pages, variable dumpers, and a "switch user" feature to inspect and troubleshoot a Drupal site.

---

Devel bundles the everyday tooling Drupal developers reach for. It provides variable-dump helpers (`dpm()`, `dvm()`, `dpr()`, `kint()`, `dd()`) that pretty-print PHP values to the page or a log file, backed by pluggable "dumper" backends (Symfony VarDumper by default, Kint if installed). It exposes introspection pages that list routes, services, events, entity types, render elements, layouts, config, and container parameters, so you can discover what the system exposes without grepping core. A toolbar/menu integration surfaces quick links (clear cache, reinstall modules, rebuild router, config editor). The "Switch user" block and permission let you become any account with one click to test permissions. A built-in config editor lets you view and edit raw configuration objects, and a mail-log backend captures outgoing email to files during development. Devel defines a `DevelDumper` plugin type so other modules can register alternative dumpers, and ships Drush commands (`devel:token`, `devel:hook`, `devel:event`, `devel:services`, `devel:uuid`, `devel:reinstall`). The companion submodule Devel Generate creates bulk dummy content. It is a development-only aid and should not be enabled on production.

---

- Print a variable to the screen while debugging with `dpm($value)` or `dvm($value)`.
- Dump a value with the rich Symfony VarDumper output.
- Log debug output to a file with `dd()` when you can't print to the page.
- Inspect an entity's loaded values via the entity debug tab.
- Browse every registered route and its controller on the route-info page.
- List all services in the container and their classes.
- Discover every dispatched event and its subscribers.
- Review all entity types and their handlers/keys.
- Look up available render/form element types.
- Inspect layout definitions registered on the site.
- View and edit any raw config object through the config editor.
- Switch to another user account with one click to test permissions.
- Reinstall one or more modules to re-run install hooks during development.
- Rebuild the router/menu without a full cache clear.
- Capture outgoing emails to files instead of sending them.
- Enable the Devel toolbar for fast access to developer actions.
- List tokens available for an entity with `drush devel:token`.
- Show which functions implement a given hook with `drush devel:hook`.
- List event subscribers from the CLI with `drush devel:event`.
- Dump the service container definitions with `drush devel:services`.
- Generate a fresh UUID with `drush devel:uuid`.
- Reinstall a module from the CLI with `drush devel:reinstall`.
- Register a custom variable dumper via a `DevelDumper` plugin.
- Swap the default dumper for Kint or another backend in settings.
- Gate developer output behind the `access devel information` permission.
- Debug Twig templates with the added `devel` Twig dump extension.
- Bulk-generate test nodes, users, terms, and menus (via Devel Generate).
