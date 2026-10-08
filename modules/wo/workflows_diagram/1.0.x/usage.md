<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflows Diagram visualises a core Workflow as a Mermaid flowchart.

---

**Workflows Diagram** renders a core Workflows entity (states and transitions) as a Mermaid.js flowchart. It hooks into the `workflow_edit_form` (via `hook_form_alter`) and adds a diagram fieldset, using a theme hook and a controller helper (`convertWorkflowToMermaid`) that escapes quotes for the Mermaid string. Requires the core `workflows` module. Its routing and settings form are shipped commented-out, so the diagram appears only on the admin workflow edit page (gated by `administer workflows`); state/transition labels come from admin-defined workflow config.

Use it to understand and document content-moderation or custom workflow state machines.

---

- Visualise a workflow as a Mermaid diagram.
- Show states and transitions graphically.
- Add a diagram to the workflow edit form.
- Document content-moderation state machines.
- Render the initial state first.
- Draw transition arrows between states.
- Choose a flowchart orientation (TB/LR/etc.).
- Exclude selected states/transitions from the diagram.
- Escape labels for safe Mermaid output.
- Depend on the core Workflows module.
- Help editors understand allowed transitions.
- Attach a Mermaid JS library on operation nodes.
- Generate a Mermaid string from a workflow.
- Review moderation flows at a glance.
- Present workflows to stakeholders.
- Keep the diagram admin-only.
- Class-annotate states in the diagram.
- Turn workflow config into a flowchart.