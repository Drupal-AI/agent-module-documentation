<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services / API

Most `src/Facade/*` classes are marked `@internal` ("External code should not use this class"). The stable,
callable services are below. The facades are documented as an integration mechanism in
[../hooks/integration.md](../hooks/integration.md).

## `acquia_cms_common.utility` — `AcmsUtilityService`

General ACMS helper (args: `module_handler`, `config.factory`, `state`).

| Method | Returns | Purpose |
| --- | --- | --- |
| `getAcquiaCmsModuleList()` | array | Enabled modules whose machine name starts with `acquia_cms`. |
| `getStarterKit()` | ?string | Human-readable label for `acquia_cms_common.settings:starter_kit_name`, or null. |
| `siteStudioPackageImport()` | mixed | Batch-imports Site Studio UI kit/packages when cohesion keys are set. |
| `validateDependencies($config_name, $data, $enabled_extensions, $all_config)` | bool | Config dependency check (ported from core `ConfigInstaller`). |
| `getMissingDependencies(...)` | array | Missing config deps (protected helper of the above). |
| `getEnabledExtensions()` | array | Enabled modules + themes + `core`, read straight from `core.extension`. |
| `setModulePreinstallTriggered($module)` / `getModulePreinstallTriggered()` | void / ?string | Static flag shared across the module-install rebuild (used by content-type submodules). |

```php
$utility = \Drupal::service('acquia_cms_common.utility');
$acms_modules = $utility->getAcquiaCmsModuleList();      // ['acquia_cms_common' => ..., ...]
$kit = $utility->getStarterKit();                        // e.g. "Acquia CMS Existing Site"
```

## `acquia_cms_common.toggle_modules` — `ToggleModulesService`

`toggleModules()` installs/uninstalls modules based on the detected Acquia/local environment (see the
`atm` drush command). `validateModuleExist($module)` guards against missing extensions.

## `acquia_cms_common.config.importer` — `ConfigImporterService`

Backs the `acms:config-reset` drush command; re-imports a module's shipped `config/install` +
`config/optional` into active storage. Constructed with the config manager/storage, module & theme
installers, extension lists, etc. Treat as internal tooling.

## `acquia_cms_common.uninstall_validator` — `AcmsModulesUninstallValidator`

Tagged `module_install.uninstall_validator`. Blocks uninstalling `acquia_cms_article/event/page/person/
place` while nodes of that type exist, `acquia_cms_document/image/video` while media of that type exist,
and `acquia_cms_starter` while any such content/media exists — returning a "please delete content first"
reason.

## Service provider

`AcquiaCmsCommonServiceProvider` conditionally registers `acquia_cms_common.breadcrumb.subtype`
(`SubtypeBreadcrumb`, tagged `breadcrumb_builder` priority 10) only when the `facets` module is present.
