# Building a module

The collection page `entity.module_builder_module.collection` →
`/admin/config/development/module_builder` lists the module you have started building. Each is a
`module_builder_module` config entity (config prefix `component`, so config names are
`module_builder.component.<id>`). All routes require the `create modules` permission.

## The config entity

`\Drupal\module_builder\Entity\ModuleBuilderModule` (a `ConfigEntityBase`). Entity keys: `id` (the
module machine name), `name` (label). `config_export`: `id`, `name`, `location`, `data`.
`admin_permission = "create modules"`. `getComponentType()` returns `'module'`.

- `id` / `name` are set on the **Info** form (`\Drupal\module_builder\Form\ModuleNameForm`, the
  add/edit form). `id` is a core `machine_name` element — lowercase letters, numbers and
  underscores only, max length 32 — used as the module's machine name in generated file and
  function names.
- `data` (schema type `ignore`) holds the full DCB component data structure for the module — every
  component you add across the section tabs is serialised here so you can return and regenerate.
- `location` (a mapping) records where files are written — see below.

## Section-form tabs

The entity annotation's `code_builder.section_forms` defines the editing tabs; each maps a set of
DCB root-component properties to its own route/form (route provider
`\Drupal\module_builder\Routing\ComponentRouteProvider`, local tasks derived by
`\Drupal\module_builder\Plugin\Derivative\ComponentSectionFormsLocalTasks`). Most use the generic
`ComponentSectionForm`; a few have dedicated classes.

| Tab | op | Properties edited |
|---|---|---|
| Info | `name` | `short_description`, `module_package`, `module_dependencies`, `lifecycle` (`ModuleNameForm`) |
| Hooks | `hooks` | `hook_classes`, `hook_implementation_type`, `hooks` (`ModuleHooksForm`) |
| Plugins | `plugins` | `plugins`, `plugin_types` |
| Entity types | `entities` | `content_entity_types`, `config_entity_types` |
| Routes & forms | `routes_forms` | `router_items`, `dynamic_routes`, `settings_form`, `forms` |
| Commands | `cli` | `cli_commands`, `drush_commands` |
| Tests | `tests` | `phpunit_tests` |

Component forms load the `component_form` library and use the autocomplete route
`module_builder.autocomplete` (`/module_builder/autocomplete/{property_address}`,
`AutocompleteController::handleAutocomplete`) to suggest option values (e.g. service names, event
names) from the analysed data. Underscores and dots are treated interchangeably when matching.

## Write location

The `location` mapping (edited in the **Write location** details on the Info form) drives
`\Drupal\module_builder\ModuleFileWriter::getRelativeModuleFolder()`. `location_type` is one of:

| `location_type` | Where files go |
|---|---|
| `standard` (default) | The existing module's folder if a module of that name already exists; else `modules/custom` if it exists; else `modules`. |
| `test` | `<parent module path>/tests/modules` (parent chosen in `test_parent_module`). |
| `sub` | `<parent module path>/modules` (parent chosen in `parent_module`). |
| `custom` | The path given in `location['custom']` (a textfield, max 128). |

If a module of the same machine name already exists and is registered with Drupal, the writer always
targets that module's real path (via `extension.list.module`), regardless of `location_type`. A
`module_builder_post_update_location_array` update converted the pre-4.x string `location` into this
mapping.

## Generate & write

Generate tab: route `entity.module_builder_module.generate_form`
(`…/manage/{module_builder_module}/generate`, `\Drupal\module_builder\Form\ComponentGenerateForm`).

1. The form loads the entity's `data`, imports the `generator_settings.module` config into a DCB
   `Configuration` data object, and calls `Generate::generateComponent()` to produce the file set.
   Invalid input surfaces as a `DrupalCodeBuilder\Exception\InvalidInputException` message.
2. Each file is shown with a merge status (new / merged / overwritten) and, if the module already
   exists under git, a version-control status. It warns when the target module is currently enabled
   (writing may break the running site) or already exists on disk.
3. Write buttons — **Write selected files**, **Write new files**, **Write all files** — call
   `ModuleFileWriter::writeSingleFile()` for each chosen file (submit handlers `writeSelected`,
   `writeNew`, `writeAll`). The writer creates directories with
   `FileSystemInterface::CREATE_DIRECTORY` and `file_put_contents()`s the code; after writing a
   `*.info.yml` it resets the module extension list so the new module is detected.

## Adopt an existing module

Two entry points let you seed a module entity from code that already exists:

- `module_builder.adopt_module_form` (`…/adopt-module`, `\Drupal\module_builder\Form\AdoptModuleForm`)
  — pick an installed module; DCB's `Adopt` task reads its files and creates a `module_builder_module`
  entity (id = `root_name`, label = `readable_name`) with the discovered `data`. "Adopt module and
  adopt components" then jumps to the component-adopt form.
- `entity.module_builder_module.adopt_form` (`…/manage/{id}/adopt`,
  `\Drupal\module_builder\Form\ComponentAdoptForm`) — for a module that already exists on disk,
  list adoptable components (services, plugins, etc.) and pull selected ones into the entity's data
  so you can extend them and regenerate.
