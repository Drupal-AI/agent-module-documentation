<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Builder is a developer tool that scaffolds Drupal module code from an admin UI: you describe a module and its components (hooks, plugins, services, entity types, routes/forms, CLI commands, tests) through tabbed forms, it generates the boilerplate with the Drupal Code Builder library, and writes the files to disk so you start from correct scaffolding instead of copying an old module.

---

The code generation lives in the standalone `drupal-code-builder/drupal-code-builder ^4.6` library (the same engine behind `drush generate`); this module is its Drupal UI. It first analyses the site's own code — the *Analyse site code* form (`module_builder.analyse`, `/admin/config/development/module_builder/analyse`) runs Drupal Code Builder's `Collect` task via the Batch API and stores the result under `public://<data_directory>` — so it learns the hooks, plugin types and tagged services *actually present* on this site and generates code matching the installed core version and enabled modules. Each module you build is saved as a `module_builder_module` config entity (`module_builder.component.*`): its info, write `location` and full component `data` are config-exported, so you can return, add or change components on the section tabs (Info, Hooks, Plugins, Entity types, Routes & forms, Commands, Tests), and regenerate. The Generate tab shows every file with a merge / version-control status, and *Write selected / new / all files* buttons write them through `ModuleFileWriter`, which resolves the target folder from the entity's `location` (standard `modules`/`modules/custom`, a test-module or submodule folder, or a custom path) and `file_put_contents()`s each file. It can also *adopt* an existing module — reading its code into a new entity so further components can be added. Component forms use an autocomplete route for option values. The single permission `create modules` gates every route, from settings to generate-and-write. A `module_builder_devel` submodule adds development helpers. Core range is `^8 || ^9 || ^10 || ^11`; the only dependency is the Composer-installed Drupal Code Builder library.

---

- Scaffold a new custom module from a form instead of copying an old one.
- Generate correct hook implementations with current signatures.
- Create a plugin class with the right annotation and injected services.
- Build an admin settings form with its boilerplate in place.
- Generate a service definition and its class.
- Produce a `permissions.yml` and a routing entry with a controller.
- Scaffold a content or config entity type.
- Generate a Drush command or CLI command class for the target module.
- Produce PHPUnit test case classes and a test module.
- Generate an `api.php` file documenting a module's own hooks.
- Analyse the site's own hooks, plugin types and tagged services before generating.
- Keep generated code matching the installed core version and enabled modules.
- Re-run the code analysis after enabling modules or updating core.
- Save a module as a reusable config entity and regenerate after edits.
- Add more components to a previously generated module and merge the new files.
- Adopt an existing module into Module Builder to extend it further.
- Add an injected service to an already-adopted service class.
- Write generated files straight into `modules/custom`, a submodule folder, or a custom path.
- Teach a new developer Drupal's file and class structure.
- Reduce copy-paste errors when starting a module.
- Generate a block, form, or event-subscriber skeleton.
- Keep scaffolding consistent across a team.
- Preview generated code and choose which files to write.
- Tune generation defaults (e.g. code style) once in the settings form.
