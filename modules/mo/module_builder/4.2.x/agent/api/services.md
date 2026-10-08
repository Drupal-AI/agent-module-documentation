# Services & integration

Declared in `module_builder.services.yml`.

## `module_builder.drupal_code_builder`

`\Drupal\module_builder\DrupalCodeBuilder` — an injectable wrapper around the external
`drupal-code-builder/drupal-code-builder` library so it can be used as a service and overridden.

```php
$task = \Drupal::service('module_builder.drupal_code_builder')
  ->getTask('Generate', 'module');   // same signature as \DrupalCodeBuilder\Factory::getTask()
```

`getTask($task_name, $task_options = NULL)` lazily loads the library on first call (`loadLibrary()`
throws `\Exception("Mising library.")` if `\DrupalCodeBuilder\Factory` is absent), sets the DCB
environment to the local `DrupalLibrary` class, and pins the core version number to
`\Drupal::VERSION`, then returns `Factory::getTask(...)`. Tasks the module uses include `Collect`,
`ReportSummary`, `Generate`, `Configuration`, `Adopt`, `AnalyseExtension`. (A legacy
`LibraryWrapper::loadLibrary()` static helper does the same for the install phase, where the class
autoloader is not yet available.)

## `module_builder.module_file_writer`

`\Drupal\module_builder\ModuleFileWriter` — writes generated files to disk. Constructor args:
`@extension.list.module`, `@file_system`.

- `getRelativeModuleFolder($module)` — returns the Drupal-relative folder to write a module into,
  resolving the entity's `location` mapping (`standard` / `test` / `sub` / `custom`; existing
  modules write to their real path). Accepts a `ComponentInterface` entity or (deprecated) the
  machine-name string.
- `writeSingleFile($module_dir, $relative_filepath, $contents)` — creates the target directory
  (`FileSystemInterface::CREATE_DIRECTORY`) and `file_put_contents()`s the code; returns bool. After
  writing an `*.info.yml` it calls `moduleExtensionList->reset()` so Drupal re-scans for the new
  module.

## `logger.channel.module_builder`

Standard logger channel (`module_builder`); errors during the code-analysis batch are logged here.

## Extensibility: component entity types

The module is built around a generic "component" mechanism rather than a plugin manager. Any config
entity type that declares a `component_sections` handler and a `code_builder` annotation (see
`ModuleBuilderModule`) gets section-form routes and tabs generated for it by
`module_builder_entity_type_build()` (`hook_entity_type_build`), `ComponentRouteProvider`, and the
`ComponentSectionFormsLocalTasks` deriver. The `module_builder_devel` submodule and the test modules
use this to add their own component entity types. The module does **not** define a public Drupal
plugin type.

## Rendering

`\Drupal\module_builder\Element\GeneratedFiles` — a render element (`#type
module_builder_generated_files`, `hook_theme` `generated_files`, template
`templates/generated-files.html.twig`) that lists the generated files with their merge / VCS status
and per-file write buttons. Libraries: `component_form`, `typed_data_defaults`, `hooks`,
`generated_files` (`module_builder.libraries.yml`).

## Invoked hook (legacy)

`hook_module_builder_info($version)` (documented in `module_builder.api.php`) let modules declare
extra hook-definition files. It is a Drupal 6/7-era hook and is not part of the Drupal 8+ analysis
flow (which reads `*.api.php` files directly during the `Collect` task); new modules do not need to
implement it.
