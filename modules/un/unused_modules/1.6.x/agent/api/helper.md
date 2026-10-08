<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `unused_modules.helper` service

Service id **`unused_modules.helper`** → `Drupal\unused_modules\UnusedModulesHelperService`
(interface `UnusedModulesHelperServiceInterface`). The controller and Drush command both use it.

## Method

```php
$modules = \Drupal::service('unused_modules.helper')->getModulesByProject();
// returns UnusedModulesExtensionDecorator[] keyed by module machine name
```

`getModulesByProject()` scans all modules on disk (`ExtensionDiscovery`), removes core modules,
resolves each module's project + project path, and marks per-project enabled state.

## `UnusedModulesExtensionDecorator` (extends core `Extension`)

Public properties you read off each item:

| Property / method | Meaning |
|---|---|
| `getName()` | Module machine name. |
| `moduleIsEnabled` (bool) | Whether this module is enabled. |
| `projectName` (string) | Project the module belongs to (info `project` key, else Composer package, else `custom`, else `_NO_PROJECT_INFORMATION_`). |
| `projectPath` (string) | Common base path of the project on disk. |
| `projectHasEnabledModules` (bool) | TRUE if any module in the project is enabled. |
| `parsingError` (bool) | TRUE if project info couldn't be parsed (sandbox/no-project). |

## Deriving the two report views

- **Unused modules** = items with `moduleIsEnabled === FALSE`.
- **Projects safe to delete** = projects where `projectHasEnabledModules === FALSE`.

Example — list projects with no enabled modules:

```php
$safe = [];
foreach (\Drupal::service('unused_modules.helper')->getModulesByProject() as $m) {
  if (!$m->projectHasEnabledModules) {
    $safe[$m->projectName] = $m->projectPath;
  }
}
```

## Site Audit integration

Ships `Plugin/SiteAuditChecklist/UnusedModulesChecklist` and
`Plugin/SiteAuditCheck/UnusedModulesCheck`, so unused-module detection can run inside a Site
Audit report when the `site_audit` module is present.
