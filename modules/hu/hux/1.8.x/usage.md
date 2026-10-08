Hux is a developer-only module that lets you implement Drupal hooks and alters as PHP methods on a plain class using attributes (`#[Hook]`, `#[Alter]`, `#[ReplaceOriginalHook]`), with full dependency injection and no `.module` file.

---

Hux decorates core's `module_handler` service (`HuxModuleHandler`, defined in `hux.services.yml` with a `service_id_collector` on the `hooks` tag) so that any service tagged `hooks` — or any class placed in a module's `Drupal\<module>\Hooks\` namespace, which is auto-discovered — can provide hook implementations as attributed methods. A method annotated `#[Hook('entity_access')]` is registered as `hook_entity_access`; the string is the hook name without the `hook_` prefix. `#[Hook]` takes optional `moduleName` (masquerade as another module) and `priority` (higher runs first) and is repeatable, so one method can implement several hooks and one class can implement a hook many times. `#[Alter('user_format_name')]` registers `hook_user_format_name_alter` (give the name without `hook_`/`_alter`). `#[ReplaceOriginalHook(hook, moduleName)]` overrides another module's existing procedural hook implementation, and a `callable` parameter tagged `#[OriginalInvoker]` receives the original implementation so you can wrap it. Classes outside the `Hooks/` namespace are registered by declaring a public service with the `hooks` tag. Discovery is automatic and cache-driven — you only need a cache rebuild when adding the first hook to a new class, not for subsequent methods. An optional `parameters.hux.optimize` flag (default `false`) in `services.yml` trades developer-friendliness for a small production performance gain. Requires PHP 8.3 and Drupal core ^11.1; note that core 11.1 itself added an OOP `#[Hook]` system, so Hux mainly serves projects wanting its extra features (multiple implementations, hook replacement with the original invoker, masquerading). No routes, permissions, config, or Drush commands.

---

- Write hook implementations as methods on a class instead of in a `.module` file.
- Inject services into hook logic via constructor dependency injection / autowiring.
- Implement the same hook multiple times within one module using repeatable `#[Hook]`.
- Order competing implementations of the same hook with the `priority` argument.
- Register a single method against several hooks by stacking `#[Hook(...)]` attributes.
- Implement `hook_*_alter` handlers with `#[Alter('name')]` methods.
- Override another module's procedural hook with `#[ReplaceOriginalHook(hook, moduleName)]`.
- Wrap and delegate to the original hook via an `#[OriginalInvoker] callable` parameter.
- Masquerade as a different module by setting `moduleName` on `#[Hook]`.
- Group all of a module's hooks into cohesive, testable service classes.
- Auto-discover hook classes by placing them in `Drupal\<module>\Hooks\`.
- Register a hook class stored elsewhere by tagging a public service with `hooks`.
- Add new hook methods without a cache rebuild once the class is registered.
- Unit-test hook logic directly by instantiating the hook class with mocked dependencies.
- Enable optimized mode (`parameters.hux.optimize: true`) for a small production speed-up.
- Keep a legacy `.module`-free codebase on projects predating core's own OOP hooks.
- Provide `entity_access`, `form_alter`, `cron`, and similar hooks from injected-service classes.
- Migrate procedural hooks to classes incrementally, one hook at a time.
