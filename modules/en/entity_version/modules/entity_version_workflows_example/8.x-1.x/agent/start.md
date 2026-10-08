<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Version Workflows Example (entity_version_workflows_example) — agent index

Demo/reference sub-module of **entity_version**. Installs a fully wired example — content type,
version field, settings mapping and a moderation workflow with version rules — that demonstrates
`entity_version_workflows`. Depends on `entity_version_workflows`. Core `^10 || ^11`.
GPL-2.0-or-later. **Not for production** — reference + test scaffolding.

- **What it installs and the test event subscriber** → [config/example.md](config/example.md)

## What it provides (from source)

- **Install config** (`config/install/`, enforced/`config_devel`):
  - `node.type.entity_version_workflows_example` — the "Example" content type (revisions on).
  - `field.storage.node.field_version` (`type => entity_version`) + `field.field.node.entity_version_workflows_example.field_version` (default `0.0.0`).
  - `entity_version.settings.node.entity_version_workflows_example` — marks `field_version` as the
    bundle's **main** version field.
  - `core.entity_view_display.node.entity_version_workflows_example.default`.
  - `workflows.workflow.example_workflow` — Content Moderation workflow (Draft → Validated →
    Published) whose `entity_version_workflows` third-party settings pre-configure:
    `create_new_draft` → `patch: increase` (`check_values_changed: true`);
    `validate` → `minor: increase`, `patch: reset`; `publish` → `major: increase`, `minor: reset`.
- **Service / event subscriber** `TestCheckEntityChangedSubscriber`
  (`src/EventSubscriber/TestCheckEntityChangedSubscriber.php`, built with `@state`) — subscribes to
  `CheckEntityChangedEvent`; when the state key `entity_version.test_skip_title_on` is `TRUE`, adds
  `title` to the change-detection blacklist. Used by the project's tests.
- **Permissions**: none. **Config schema**: none of its own. **Drush**: none.

Note: this is a real project sub-module under `modules/`, not a `tests/` fixture — hence documented.
