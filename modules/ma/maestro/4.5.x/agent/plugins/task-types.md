# Maestro — plugin types (engine tasks & set-process-variable)

Maestro defines two plugin types.

## 1. Engine Task plugins
- Manager: `plugin.manager.maestro_tasks` (`MaestroEngineTasksPluginManager`).
- Discovery: classes in `src/Plugin/EngineTasks/` implementing
  `Drupal\maestro\MaestroEngineTaskInterface`, annotated with the generic `@Plugin`
  (`id`, `task_description`). Alter hook: `maestro_tasks_info`. Cache key `maestro_tasks_info`.
- Most tasks extend `PluginBase` and `use MaestroTaskTrait`. Constructor receives
  `[$processID, $queueID]`.

Built-in task ids:

| Id | Purpose |
|---|---|
| `MaestroStart` | Entry point; `execute()` returns TRUE (auto-completes). |
| `MaestroEnd` | Terminates the process. |
| `MaestroIf` | Conditional branch on a process variable → true/false next step. |
| `MaestroAnd` | Join: proceeds only when all inbound branches arrive. |
| `MaestroOr` | Join: proceeds on any inbound branch. |
| `MaestroInteractive` | Human task; shows a form in the task console. |
| `MaestroManualWeb` | Manual web task (assignee marks complete). |
| `MaestroContentType` | Create/edit a content-type entity as a step (accept/reject branches). |
| `MaestroBatchFunction` | Calls a registered batch handler function. |
| `MaestroSetProcessVariable` | Sets a process variable (optionally via an SPV plugin). |
| `MaestroSpawnSubFlow` | Launches a sub-process and continues on its completion. |

### Key interface methods (`MaestroEngineTaskInterface`)
- `execute()` (from `ExecutableInterface`) — run the task; return TRUE to have the engine complete it.
- `isInteractive()` — whether it needs a task-console form.
- `getExecutableForm($modal, MaestroExecuteInteractive $parent)` / `handleExecuteSubmit(&$form, $form_state)`
  — the interactive form and its submit handling.
- `getTaskEditForm(array $task, $templateMachineName)` / `validateTaskEditForm()` /
  `prepareTaskForSave(&$form, $form_state, &$task)` — template-editor config for the task.
- `shortDescription()`, `description()`, `getTaskColours()`, `getTemplateBuilderCapabilities()`
  (e.g. `['drawlineto','removelines']`), `performValidityCheck(&$failures,&$info,$task)`.

### Adding a task type (sketch)
```php
// src/Plugin/EngineTasks/MyTask.php
/**
 * @Plugin(id = "MyCustom", task_description = @Translation("My custom task."))
 */
class MyTask extends PluginBase implements MaestroEngineTaskInterface {
  use MaestroTaskTrait;
  public function __construct($configuration = NULL) { if (is_array($configuration)) { $this->processID = $configuration[0]; $this->queueID = $configuration[1]; } }
  public function isInteractive() { return FALSE; }
  public function execute() { /* do work with $this->processID/$this->queueID via MaestroEngine */ return TRUE; }
  // …implement the remaining interface methods (edit form, colours, validity check)…
}
```
Per-task config schema is keyed `maestro.task.<TaskType>` (see `config/schema/maestro.schema.yml`).

## 2. Set Process Variable (SPV) plugins
- Manager: `plugin.manager.set_process_variable_plugins` (`MaestroSetProcessVariablePluginManager`).
- Discovery: `src/Plugin/MaestroSetProcessVariablePlugins/` implementing
  `MaestroSetProcessVariablePluginInterface` (extend `MaestroSetProcessVariablePluginBase`),
  annotated with `@MaestroSetProcessVariablePlugin` (`id`, `short_description`, `description`).
  Alter hook: `maestro_set_process_variable_plugin_info`.
- Used by the `MaestroSetProcessVariable` task to compute a value. Key methods:
  `getSPVTaskConfigFormElements(): array`, `execute(): ?string` (returns the value),
  `validateSPVTaskEditForm(&$form,$form_state): void`, `prepareTaskForSave(&$form,$form_state,&$task): void`.

Built-in SPV plugins: `GetContentTypeFieldValue`, `GetNumberOfItems`,
`GetEntityIdentifierFieldValueDeltaFromProcessVariable`, `GetWebformSubmissionElementValue`.
