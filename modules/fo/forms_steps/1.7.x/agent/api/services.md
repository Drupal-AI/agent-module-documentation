# Forms Steps services & events

## Services (`forms_steps.services.yml`)
| Service id | Class | Purpose |
|---|---|---|
| `forms_steps.manager` | `Service\FormsStepsManager` | Resolves steps, form modes, and form-display info for a workflow. Deps: `entity_display.repository`, `config.factory`. |
| `forms_steps.workflow.manager` | `Service\WorkflowManager` | Tracks a workflow **instance** (the per-run UUID) and the entities attached to each step; creates/loads instances. Deps: `entity_type.manager`, `forms_steps.manager`, `uuid`, `current_route_match`. |
| `forms_steps.helper` | `Service\FormsStepsHelper` | Convenience lookups from the current route to the active workflow/step. |
| `forms_steps.workflow.repository` | `Repository\WorkflowRepository` | DB queries over workflow instances. Deps: `database`, `string_translation`. |
| `forms_steps.route_subscriber` | `EventSubscriber\RouteSubscriber` | Generates the per-step front-end routes (see configure/workflow.md). |

## Instances
A workflow **instance** is one run of the wizard, identified by a UUID that appears in each
step URL (`<step url>/{instance_id}`). The `WorkflowManager` binds the same instance across
steps so step 2 can edit the entity created in step 1 (or create linked entities). Entities
are associated to a step+instance in storage; the Drush command
`forms_steps:attach-entity` does this programmatically (see drush/commands.md).

## Event
`\Drupal\forms_steps\Event\StepChangeEvent` is dispatched when the user moves between steps.
Subscribe to run custom logic (side effects, notifications, extra validation) on transitions:

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\forms_steps\Event\StepChangeEvent::EVENT_NAME => 'onStepChange'];
}
```

## Entities
- `forms_steps` — the wizard definition (config entity; see configure/workflow.md).
- `forms_steps_workflow` — a content entity representing an instance/run (has a list builder
  and the `view forms_steps_workflow entity` permission).
- Value objects: `Step`/`StepInterface`, `ProgressStep`/`ProgressStepInterface`,
  `Workflow`/`WorkflowInterface`.
