DX Toolkit Demo is the example submodule of DX Toolkit that shows the ServiceInjector factory-service pattern through a small content-auditing service and two Drush commands.

---

DX Toolkit Demo is reference-only example code bundled with DX Toolkit. It ships two ServiceInjector plugins (`ViewStorage`, a simple no-deriver plugin, and `ConfigFactory`, which uses `ConfigFactoryDeriver` to expose several editable config objects), a `ContentAuditor` service whose constructor cleanly injects three entity storage handlers and one config object via `service_injector.*` service ids, and a `DemoCommands` Drush class exposing `dx:demo:audit` (site-wide node/term/user counts and site name) and `dx:demo:audit-type <entity_type>` (per-type totals plus a sample of up to 10 entities). It has no routes, controllers, permissions, blocks, or web-facing output — everything runs through Drush on the command line. It depends on `dx_toolkit`, `node`, and `taxonomy`, and targets Drupal 10 or 11. Because the ServiceInjector runtime is not present in dx_toolkit 1.0.1, the submodule is best read as a template rather than run as-is.

---

- Learn the ServiceInjector pattern from working plugin examples before writing your own.
- See a no-deriver ServiceInjector plugin in `ViewStorage` (would generate `service_injector.view.storage`).
- See a deriver-driven ServiceInjector plugin in `ConfigFactory` + `ConfigFactoryDeriver` (config objects for system.site, system.performance, node.settings, user.settings).
- Study a clean constructor that injects multiple entity storage handlers directly instead of injecting `EntityTypeManagerInterface` and calling `getStorage()`.
- Compare the "traditional vs ServiceInjector" dependency-injection styles side by side (see the submodule README/COMPARISON docs).
- Run `drush dx:demo:audit` to print site name plus node, taxonomy term, and user counts.
- Run `drush dx:demo:audit-type node` (or `taxonomy_term`, `user`) for a per-type total and a sample list of up to 10 entities.
- Use `ContentAuditor::auditSite()` as a template for a lightweight site-statistics service.
- Use `ContentAuditor::auditByType()` as a template for a `match`-dispatched per-type query helper.
- Wire a Drush command to an injected service using the `drush.command` service tag, as shown in `drush.services.yml`.
- Copy `DemoCommands` as a starting point for attribute-based (`#[CLI\Command]`) Drush commands.
- Model your own `services.yml` argument wiring on `dx_toolkit_demo.services.yml`.
- Understand how a `DeriverBase` returns multiple definitions from a static list (`ConfigFactoryDeriver::getDerivativeDefinitions`).
- Use the submodule as a scaffolding reference when building an internal developer/QA auditing tool.
- Enable it in a development environment only, then disable it before production since it is example code.
