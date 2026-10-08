<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Workflow defines the entity type that holds a workflow — the graph of nodes and edges — with versioning.

---

This is where a FlowDrop workflow actually lives. The visual editor produces a definition; this submodule stores it as an entity, keeps versions of it, and provides the management surface for listing, editing and deleting workflows.

Versioning is the part worth understanding. A workflow that runs in production is a piece of behaviour, and behaviour that can be edited in a browser needs the same safety net as behaviour that is deployed as code: knowing what changed, when, and being able to go back. Storing versions of the definition rather than overwriting it is what makes an editable workflow operable rather than merely convenient.

Because workflows are entities, everything Drupal gives entities applies — access handlers, hooks on save, Views listings, and the normal export/import story. It is the foundation the runtime, the executor and the orchestration layer all read from, so a workflow is defined once here and consumed by whichever of those actually runs it.

---

- Store a workflow definition as an entity.
- Keep versions of a workflow.
- Roll back to a previous workflow version.
- List workflows in an admin UI.
- Edit a workflow definition.
- Delete a workflow safely.
- See what changed between two versions.
- Reference a workflow from the runtime.
- Reference a workflow from another workflow.
- Apply entity access to workflow definitions.
- React to workflow saves with a hook.
- Build a Views listing of workflows.
- Export a workflow definition.
- Audit which workflows a site defines.
- Track authorship of workflow changes.