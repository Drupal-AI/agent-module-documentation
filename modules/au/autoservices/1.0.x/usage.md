<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autoservices lets other modules register services, plugin managers, and event subscribers into the container purely by dropping a class into a conventional directory, with no `*.services.yml` entry at all.

---

Symfony has had autowiring since 3.3 and Drupal adopted it only partly: core supports `autowire: true` on a service definition, but the definition still has to exist, so adding a service remains a two-file operation — write the class, then restate it in YAML with each argument listed in order. That YAML is boilerplate echoing what the constructor's type hints already say, and it is where mistakes happen: an argument in the wrong position, a service id typed from memory, a constructor changed without the YAML following. This module removes it. After you enable it (as a **dependency** of your own module — it does nothing on its own), a compile-time service provider scans every module's `src/` for three directories: **`src/Autoservice/`** registers each class as an **autowired** service, **`src/AutoPluginManager/`** registers each class as a child of `default_plugin_manager` (not autowired, for plugin managers), and **`src/AutoEventSubscriber/`** registers each class autowired and tagged `event_subscriber`. Each service id is the class's fully qualified name and every definition is made public; a class whose id is already defined in a real `*.services.yml` is left alone. Autowiring by interface needs a mapping Drupal does not publish, so the module also aliases `\<ServiceClass>Interface` to the matching service for every conventional (lowercase-id) service whose interface follows the `<Class>Interface` same-namespace naming rule — that alias set is what to check if a type-hint fails to resolve. Because registration happens during container compilation, run `drush cr` after adding or moving a class, and weigh one trade before adopting it broadly: convention-registered services live in no YAML file, so `drush` service listings and a text search for the id will not find them. Note the README still names the third directory `AutoEventListener` with an `event_listener` tag; the working source uses `AutoEventSubscriber` and the `event_subscriber` tag.

---

- Register a service without writing any `*.services.yml`.
- Autowire a service's constructor dependencies from interface type hints.
- Reduce `services.yml` boilerplate across a module.
- Avoid argument-order mistakes in service definitions.
- Add a service by dropping a class into `src/Autoservice/`.
- Register an event subscriber via `src/AutoEventSubscriber/` (tag added automatically).
- Register a plugin manager via `src/AutoPluginManager/` (inherits `default_plugin_manager`).
- Alias core and custom services so autowiring resolves interfaces.
- Refactor a constructor without editing YAML afterwards.
- Ship a code-first module with a minimal file footprint.
- Reduce merge conflicts in a shared `services.yml`.
- Register several small services quickly by convention.
- Prototype a service layer without container config.
- Provide autowiring to a module that depends on this one.
- Onboard Symfony developers with familiar conventions.
- Keep an explicit `services.yml` definition and have it take precedence.
- Rebuild the container (`drush cr`) to pick up newly added convention classes.
- Adopt convention-over-configuration for the service container.
- Reduce container configuration errors in custom modules.
- Install it as a dependency of another contrib or custom module.
