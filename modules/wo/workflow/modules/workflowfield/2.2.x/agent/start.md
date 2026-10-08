<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Field (`workflowfield`) — agent index (residual)

**Residual, hidden submodule.** The `workflow` field type now lives in the main `workflow` module;
this submodule ships only an `info.yml` (no code/deps). You do **not** need to enable it on
workflow 8.x-1.0-beta6 or later.

- Add a workflow to content with a "Workflow state" field from the parent module —
  [configure/workflows.md](../../../../2.2.x/agent/configure/workflows.md) and
  [plugins/field.md](../../../../2.2.x/agent/plugins/field.md).

Key fact: `hidden: TRUE`, no dependencies, `configure: null`. Enabling it is a no-op kept only for
upgrade compatibility.
