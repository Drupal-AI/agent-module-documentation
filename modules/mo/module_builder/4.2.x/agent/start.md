<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Builder (module_builder) — agent index

Developer tool that scaffolds Drupal module code from an admin UI. It stores each module you build
as a `module_builder_module` config entity, lets you add components (hooks, plugins, services,
entity types, routes/forms, CLI commands, tests) through tabbed forms, generates the code with the
external **`drupal-code-builder/drupal-code-builder ^4.6`** library, and writes the files to disk.
No module dependencies; core `^8 || ^9 || ^10 || ^11`. Configure route: `module_builder.settings`.
One permission (`create modules`), no Drush commands, ships a `module_builder_devel` submodule.

- **Settings form, the `data_directory` + generator settings, running the code analysis** →
  [configure/settings.md](configure/settings.md)
- **Building a module: the config entity, section-form tabs, write locations, generate & write** →
  [configure/build.md](configure/build.md)
- **The single permission and what it gates** → [permissions/permissions.md](permissions/permissions.md)
- **Services (DCB wrapper, file writer), the DCB integration, the invoked hook** →
  [api/services.md](api/services.md)

Key facts:
- Config object `module_builder.settings`: `data_directory` (string, default `module_builder_data`,
  a folder under `public://` where DCB stores its analysis) and `generator_settings.module` (mapping,
  schema type `ignore`, holds DCB `Configuration` task values applied to all generated code).
- Built modules are `module_builder.component.*` config entities (entity type
  `module_builder_module`, config prefix `component`); config-exported keys `id`, `name`,
  `location`, `data`.
- Services: `module_builder.drupal_code_builder` (`DrupalCodeBuilder::getTask($name, $opts)` wraps
  `\DrupalCodeBuilder\Factory`), `module_builder.module_file_writer`
  (`ModuleFileWriter::getRelativeModuleFolder()` / `writeSingleFile()`),
  `logger.channel.module_builder`.
- Permission `create modules` (`restrict access: true`) is the entity `admin_permission` and the
  requirement on every route.
- Routes: `module_builder.settings` (`/admin/config/development/module_builder/settings`),
  `module_builder.analyse` (`…/analyse`), `module_builder.adopt_module_form` (`…/adopt-module`),
  `module_builder.autocomplete` (`/module_builder/autocomplete/{property_address}`),
  `entity.module_builder_module.collection` (`/admin/config/development/module_builder`) plus the
  add/edit/section/generate/delete entity routes.
- Run **Analyse site code** (`module_builder.analyse`) first and after any core/module change: the
  generator learns hooks, plugin types and tagged services from *this* site's code.
