<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow Field (machine name `workflowfield`) is a **residual, hidden** submodule of Workflow. The workflow field type it once provided is now part of the main Workflow module, so there is no need to enable it on workflow 8.x-1.0-beta6 or later.

---

In very early Drupal 8 Workflow releases this submodule contributed the `workflow` field type.
That field type now lives in the main `workflow` module
(`Drupal\workflow\Plugin\Field\FieldType\WorkflowItem`, label "Workflow state", default widget
`workflow_default`). The submodule directory now contains **only an `info.yml`** — marked `hidden:
TRUE`, with no dependencies, no code, no config, no schema, no permissions. It is retained solely
so sites upgrading from those old betas do not error on a missing module; enabling it does nothing.
To put a workflow on content, add a "Workflow state" field from the main module — see the parent's
[configure docs](../../../2.2.x/agent/configure/workflows.md) and
[field/plugins docs](../../../2.2.x/agent/plugins/field.md).

---

- Recognize that the `workflow` field type is provided by the main `workflow` module, not this submodule.
- Leave `workflowfield` disabled on new sites (nothing needs it).
- Understand why it shows as `hidden` on the Extend page.
- Safely uninstall it on sites upgraded from old 8.x-1.0 betas.
- Add a "Workflow state" field from the main module instead of enabling this one.
- Avoid enabling it expecting a field type — it is an empty residual placeholder.
