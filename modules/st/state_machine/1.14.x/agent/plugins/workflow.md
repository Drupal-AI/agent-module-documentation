# Define workflows and workflow groups (YAML plugins)

Two plugin types, both defined in YAML (discovered via `state_machine.plugin_type.yml`):
`workflow` (manager `plugin.manager.workflow`) and `workflow_group`
(manager `plugin.manager.workflow_group`).

## Workflow group — `mymodule.workflow_groups.yml`
```yaml
commerce_order:
  label: Order
  entity_type: commerce_order
  # optional: workflow_class to override \Drupal\state_machine\Plugin\Workflow\Workflow
```
Groups bind workflows to an entity type and let related workflows share a purpose (they also
scope which guards run — see extend/guards.md).

## Workflow — `mymodule.workflows.yml`
```yaml
default:
  id: default
  label: Default
  group: commerce_order
  states:
    new:        { label: New }
    fulfillment:{ label: Fulfillment }
    completed:  { label: Completed }
    canceled:   { label: Canceled }
  transitions:
    create:  { label: Create,  from: [new],              to: fulfillment }
    fulfill: { label: Fulfill, from: [fulfillment],      to: completed }
    cancel:  { label: Cancel,  from: [new, fulfillment], to: canceled }
```
- A transition has one `to` state but may allow several `from` states.
- Multiple workflows can share a group; a `state` field picks one via its `workflow` setting
  or a `workflow_callback` that resolves it at runtime.
- After adding/editing YAML run `drush cr` (definitions are cached).
- Alter definitions from another module → [../hooks/hooks.md](../hooks/hooks.md).

Attach the state to an entity by adding a `state` field (base field or config field) whose
`workflow` setting names the workflow id. Reading/applying → [../api/state-field.md](../api/state-field.md).
