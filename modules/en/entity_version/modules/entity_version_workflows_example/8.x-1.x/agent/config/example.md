<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What the example installs

## Enable

```bash
drush en entity_version_workflows_example -y
```

Pulls in `entity_version_workflows` (and thus `entity_version` + core `content_moderation`). Enabling
imports the `config/install/*` objects below. **Demo/test module** — enable on a scratch or local
site, not production.

## Installed configuration (`config/install/`)

The `.info.yml` lists these under `config_devel.install`; the node type and workflow carry
`enforced` module dependencies.

| Config object | What it is |
|---|---|
| `node.type.entity_version_workflows_example` | Content type **"Example"** (machine `entity_version_workflows_example`), `new_revision: true`. |
| `field.storage.node.field_version` | Field storage `field_version`, `type: entity_version`, `cardinality: 1`. |
| `field.field.node.entity_version_workflows_example.field_version` | The version field on the Example type, label "Version", `default_value: {major:0, minor:0, patch:0}`. |
| `entity_version.settings.node.entity_version_workflows_example` | Settings entity `node.entity_version_workflows_example` → `target_field: field_version` (marks it the **main** version field so the workflow acts on it). |
| `core.entity_view_display.node.entity_version_workflows_example.default` | Default view display for the type. |
| `workflows.workflow.example_workflow` | Content Moderation workflow (below). |

## The example workflow (`workflows.workflow.example_workflow.yml`)

- **States**: `draft` (unpublished, default) → `validated` (unpublished) → `published` (published,
  default revision).
- **Transitions & version rules** (`third_party_settings.entity_version_workflows`, keyed by
  transition id — consumed by `EntityVersionWorkflowManager`):

  ```yaml
  create_new_draft:
    patch: increase
    check_values_changed: true   # only bump patch if the entity actually changed
  validate:
    minor: increase
    patch: reset
  publish:
    major: increase
    minor: reset
  ```

- **Applies to** `node: [entity_version_workflows_example]`, default moderation state `draft`.

So on this demo type: editing/creating a new draft bumps `patch` (when values changed), Validate does
`minor+1` / `patch=0`, and Publish does `major+1` / `minor=0`.

## Test hook — `TestCheckEntityChangedSubscriber`

`src/EventSubscriber/TestCheckEntityChangedSubscriber.php` (service
`entity_version_workflows_example.event_subscriber.test_check_entity_changes`, argument `@state`).

- Subscribes to `CheckEntityChangedEvent::EVENT`
  (`entity_version_worfklows.check_entity_changed_event`) via `skipTitle()`.
- `skipTitle()` returns early **unless** the state key
  `entity_version.test_skip_title_on` (constant `STATE`) is exactly `TRUE`; when set, it appends
  `title` to the event's field blacklist so a title-only edit is treated as "no change" by
  `EntityVersionWorkflowManager::isEntityChanged()`.
- Toggle it in tests/local:

  ```php
  \Drupal::state()->set('entity_version.test_skip_title_on', TRUE);
  ```

This exists to exercise the "Check values changed" path of the parent sub-module; it has no effect
until the state flag is set.
