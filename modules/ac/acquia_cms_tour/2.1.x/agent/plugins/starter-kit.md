<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `@AcquiaCmsStarterKit` (+ StarterKitService)

The second plugin type drives the **starter-kit selection wizard** (route
`acquia_cms_tour.selection_wizard`, embedded as a modal from the dashboard). Each plugin is one step;
finishing the wizard installs a chosen set of `acquia_cms_*` modules and themes.

## Moving parts

| Piece | Class / id |
|---|---|
| Annotation | `Drupal\acquia_cms_tour\Annotation\AcquiaCmsStarterKit` (`@Annotation`; keys `id`, `label`, `weight`) |
| Manager service | `plugin.manager.starter_kit` → `AcquiaCmsStarterKitManager` |
| Discovery dir | `Plugin/AcquiaCmsStarterKit/` |
| Interface / base | `AcquiaCmsStarterKitInterface`, `AcquiaCmsStarterKitPluginBase` |
| Form base used | `Drupal\acquia_cms_tour\Form\AcquiaCmsStarterKitBase` (a `FormBase`) |
| Alter hook | `acquia_cms_starter_kit_info` |
| Wizard driver | `Form\StarterKitSelectionWizardForm` |

Built-in steps (sorted by weight): `StarterKitSelectionForm` (id
`acquia_cms_starter_kit_selection`, weight 1) then `StarterKitConfigForm` (id
`acquia_cms_starter_kit_config`, weight 2, the final step).

## What the wizard does

- **Step 1 — selection:** radio/select of three kits, stored in state `acquia_cms.starter_kit`:
  `acquia_cms_enterprise_low_code`, `acquia_cms_community`, `acquia_cms_headless`.
- **Step 2 — extend + install:** asks about demo content / content model (a required "I understand"
  checkbox), then on submit — **only if no kit modules are missing from the codebase** — writes
  `acquia_cms_common.settings:starter_kit_name`, sets state `starter_kit_wizard_completed`, and calls
  `StarterKitService::enableModules()`.

## Service `acquia_cms_tour.starter_kit` — `StarterKitService`

Constructor args: `@module_installer`, `@theme_installer`, `@config.factory`,
`@extension.list.module`. Key methods:

| Method | Behavior |
|---|---|
| `getModulesAndThemes($kit, $demo=NULL, $contentModel=NULL)` | Returns `['enableModules'=>[…], 'enableThemes'=>['admin'=>…,'default'=>…]]` — the fixed module/theme set for each kit (e.g. low-code → site studio + `cohesion_theme`; community/headless → `olivero` + `gin`). `$demo='Yes'` adds `acquia_cms_starter`; `$contentModel='Yes'` adds article/event/page. |
| `enableModules($kit, $demo=NULL, $contentModel=NULL)` | Builds a batch (`batch_set`) whose ops call `enableSingleModule` per module, installs the kit's themes via `theme_installer`, and sets `system.theme:default` / `system.theme:admin`. |
| `enableSingleModule($module)` (static) | `\Drupal::service('module_installer')->install([$module])`. |
| `getMissingModules($kit, …)` | Kit modules not present in `extension.list.module` (comma-joined). |
| `getMissingModulesCommand($missing)` | Formats a `drupal/…` composer-require string. |

`AcquiaCmsStarterKitBase` stores per-step completion in state `acms_<formName>_configured` (via
`getConfigurationState()` / `setConfigurationState()`), analogous to the tour cards.

## Add a starter-kit step

Create `my_module/src/Plugin/AcquiaCmsStarterKit/MyStep.php` with an `@AcquiaCmsStarterKit`
annotation (give it a `weight` between/after the built-ins), extending `AcquiaCmsStarterKitBase` and
implementing `getFormId()`, `buildForm()`, `submitForm()`. The wizard renders steps in weight order
and calls each step's `submitForm()` as the user advances.
