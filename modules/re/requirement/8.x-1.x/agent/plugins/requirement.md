# `Requirement` and `RequirementGroup` plugin types

The module defines two annotation-based plugin types. You write these in **your own** module — the
`requirement` module ships none of its own.

## `Requirement` plugin type

- Manager service: `plugin.manager.requirement` (`Plugin\RequirementManager`, extends
  `DefaultPluginManager`).
- Discovery dir: `Plugin/Requirement/Requirement` (i.e. `my_module/src/Plugin/Requirement/Requirement/*.php`).
- Interface: `Plugin\RequirementInterface`. Abstract base: `Plugin\RequirementBase`.
- Annotation: `Drupal\requirement\Annotation\Requirement` (`@Requirement`).
- Alter hook: **`hook_requirement_info(&$definitions)`**. Cache: `requirement_info_info_plugins`.
- Definitions are sorted ascending by `weight` (`RequirementManager::findDefinitions`, default 0).

### `@Requirement` annotation fields

| Field | Type | Meaning |
|---|---|---|
| `id` | string | Plugin id. Also used to build the fix route `requirement.{id}` and `/admin/reports/requirement/{id}`. |
| `label` | string | Shown as the requirement's title on the report. |
| `description` | string | Shown under the label. |
| `group` | string | Id of a `@RequirementGroup` this belongs to. Omitted ⇒ falls under an "Other" (`_`) group. |
| `severity` | string | `error`, `warning`, or `recommendation`. Default `warning` when unset. |
| `weight` | int | Sort order in the report and in `listRequirement()`. Default 0. |
| `action_button_label` | string | Label of the fix button. **If empty, no button renders** (`getActionButton()` returns `[]`). |
| `form` | string | FQCN of the form to open. Default `Plugin\RequirementFormBase` (see [../api/services.md](../api/services.md)). |
| `dependencies` | array | Ids of other requirements that must be `isCompleted()` before this one is shown. |

### Interface contract (`RequirementInterface`)

`RequirementBase` implements most of these from the annotation. The two you **must** implement in your
subclass are `isCompleted()` and `isApplicable()` (they are declared on the interface but have **no**
implementation in `RequirementBase`).

```php
public function getId(): string;                 // from definition['id']
public function getGroup(): ?RequirementGroupInterface;   // resolves definition['group']
public function getLabel(): string;              // definition['label']
public function getDescription(): string;        // definition['description']
public function getForm(): ?string;              // definition['form'] ?? RequirementFormBase::class
public function getActionButtonLabel(): ?string; // definition['action_button_label'] ?? NULL
public function getActionButton(): array;        // modal ajax link to requirement.{id}, or []
public function getSeverity(): string;           // 'completed' if isCompleted(), else definition['severity'] ?? 'warning'
public function getDependencies(): array;        // definition['dependencies'] ?? []
public function buildConfigurationForm(array $form, FormStateInterface $form_state): array;  // base returns []
public function submitConfigurationForm(array &$form, FormStateInterface $form_state);        // base is a no-op
public function isApplicable(): bool;   // YOU implement — is it relevant on this site at all?
public function isCompleted(): bool;    // YOU implement — is the requirement met?
public function isResolvable(): bool;   // base: TRUE unless a dependency is not isCompleted()
```

- `isApplicable()` — return FALSE to drop the requirement entirely (e.g. only relevant if some module
  is enabled). `RequirementManager::listRequirement()` skips non-applicable instances, so they never
  reach the report **or** the Status Report summary.
- `isCompleted()` — return TRUE when the site already satisfies the requirement. Drives both the
  Status Report severity roll-up and whether the fix button renders (`requirement-report.html.twig`
  hides the button when completed).
- `isResolvable()` — the base walks `getDependencies()` and returns FALSE if any dependency is not
  completed; unresolvable requirements are filtered out of the report page by
  `RequirementReportPage::preRenderRequirement`. (Note the base has a `TODO`: no circular-dependency
  guard, so avoid dependency cycles.)

### Helpers available in your plugin

`RequirementBase` uses `RequirementTrait`, `LoggerChannelTrait`, and `MessengerTrait`. `RequirementTrait`
provides lazy `\Drupal::`-backed getters (no constructor injection needed): `getEntityTypeManager()`,
`getModuleHandler()`, `getModuleInstaller()`, `getRequirementManager()`, `getRequirementGroupManager()`,
`getConfigFactory()`, `getConfigStorage()`, `getConfigManager()`.

### Minimal example

```php
namespace Drupal\my_module\Plugin\Requirement\Requirement;

use Drupal\Core\Form\FormStateInterface;
use Drupal\requirement\Annotation\Requirement;
use Drupal\requirement\Plugin\RequirementBase;

/**
 * @Requirement(
 *   id = "my_module_content_type",
 *   group = "my_module",
 *   label = "Default content type",
 *   description = "Create the content type MY_MODULE uses by default.",
 *   severity = "error",
 *   action_button_label = "Create content type",
 *   weight = 100,
 *   dependencies = { "my_module_prerequisite" }
 * )
 */
class ContentTypeRequirement extends RequirementBase {

  public function isApplicable(): bool {
    return $this->getModuleHandler()->moduleExists('node');
  }

  public function isCompleted(): bool {
    return (bool) $this->getConfigFactory()->get('my_module.settings')->get('type');
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form['name'] = ['#type' => 'textfield', '#title' => $this->t('Name'), '#required' => TRUE];
    return $form;
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {
    // …create the content type and persist config; the fix runs here…
  }
}
```

The button opens `requirement.{id}` (`/admin/reports/requirement/my_module_content_type`) in a modal;
the default `RequirementFormBase` wraps `buildConfigurationForm()` with Submit/Cancel actions and calls
`submitConfigurationForm()` on submit. Clear caches after adding a plugin so the plugin definition and
the dynamic route are registered.

## `RequirementGroup` plugin type

- Manager service: `plugin.manager.requirement_group` (`Plugin\RequirementGroupManager`).
- Discovery dir: `Plugin/Requirement/RequirementGroup`.
- Interface: `Plugin\RequirementGroupInterface`. Base: `Plugin\RequirementGroupBase` (fully
  implements the interface — usually an empty subclass is enough).
- Annotation: `Drupal\requirement\Annotation\RequirementGroup` (`@RequirementGroup`), fields `id`,
  `label`, `description`. Alter hook `requirement_group_info`.
- A requirement's `group` field references a group `id`; the report renders each group as a fieldset
  (legend = group `label`, then the group `description`). Requirements without a group land under a
  synthetic "Other" fieldset.

```php
namespace Drupal\my_module\Plugin\Requirement\RequirementGroup;

use Drupal\requirement\Plugin\RequirementGroupBase;

/**
 * @RequirementGroup(
 *   id = "my_module",
 *   label = "My Module",
 *   description = "Review the following configuration.",
 * )
 */
class MyModuleGroup extends RequirementGroupBase {}
```
