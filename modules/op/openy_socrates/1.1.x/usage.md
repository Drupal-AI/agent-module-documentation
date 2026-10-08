<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Socrates is a middleware facade service that lets the modules of an Open Y (YMCA Website Services) site call each other's data and tasks without depending on one another directly.

---

It is an object-oriented take on the Strategy pattern. A module that has data to offer implements `OpenyDataServiceInterface`, lists the method names it answers, and tags its service `openy_data_service` with a `priority` in its `*.services.yml`. At container build a compiler pass collects every tagged service and injects it into the single `socrates` facade. Consumers then call `\Drupal::service('socrates')->someMethod(...)`; the facade routes that call to the highest-priority service that registered the method, and throws `OpenySocratesException` if nobody did. Because the consumer depends only on the facade, a provider can be replaced by tagging a higher-priority one, and a site missing a provider degrades (a catchable exception) rather than fataling on a missing dependency. A second, parallel mechanism runs periodic work: services tagged `openy_cron_service` (implementing `OpenyCronServiceInterface`) with a `periodicity` in seconds are executed by `\Drupal::service('socrates')->cron()`, which Open Y triggers from crontab with `drush ev '\Drupal::service("socrates")->cron();'`; last-run times are stored in Drupal State per service. Install by enabling the module (`drush en openy_socrates`) — there is no settings page, no permissions and no configuration; everything is done in code via services and tags. The package also contains a small independent submodule, **OpenY Theme Overrides** (`openy_theme_override`), enabled separately, which lets a module ship Twig template overrides under its own `themes/<theme_machine_name>/` folders and have them take priority over the active theme's templates via `hook_theme_registry_alter`. Outside an Open Y distribution the module has nothing to do; if you find it enabled it arrived as a dependency of another Open Y module. The name is a play on a middleware that "answers questions" — recognise it as architecture rather than searching for an end-user feature.

---

- Let Open Y modules call each other's data without direct module dependencies.
- Ask the `socrates` facade for data another module provides.
- Register a service's methods through the facade by implementing `OpenyDataServiceInterface`.
- Tag a service `openy_data_service` with a `priority` in `*.services.yml`.
- Override a default data provider by tagging a higher-priority replacement.
- Degrade gracefully (catch `OpenySocratesException`) when no provider is installed.
- Run periodic tasks by tagging a service `openy_cron_service` with a `periodicity`.
- Implement `OpenyCronServiceInterface::runCronServices()` for a scheduled job.
- Trigger the Socrates cron runner from crontab with `drush ev`.
- Track per-service last-run times in Drupal State without writing your own bookkeeping.
- Enable the module with `drush en openy_socrates` (no config, no permissions).
- Delete large sets of entities in memory-safe chunks with `OpenyRepositoryTrait::removeAllByChunks()`.
- Enable the `openy_theme_override` submodule to ship template overrides inside a module.
- Override a theme's Twig templates from a module's `themes/<theme>/` folder.
- Read the facade to understand how the Open Y distribution fits together.
- Join the Open Y ecosystem with a custom module without hard-wiring to specific modules.
- Plan and audit inter-module data dependencies during an Open Y build or upgrade.
- Decouple a schedule feature from the concrete location module that supplies its data.
- Identify why the module is enabled on a non-Open-Y site (it came as a dependency).
- Document the facade's method contracts for a team.
