<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parallel Workspaces adds support for parallel workspaces, allowing content to exist in multiple workspaces at the same time.

---

Parallel Workspaces extends core Workspaces to support parallel workspaces — allowing content to exist
in multiple workspaces simultaneously, rather than the strict hierarchical model core provides. This helps
teams stage independent sets of changes in parallel (multiple concurrent campaigns/releases) without them
being forced into a single line. It ships a `workspaces_parallel_graph` submodule and depends on core
Workspaces.

Use it for advanced content-staging workflows with concurrent workspaces. It is an automation/content-
staging feature building on Workspaces; workspace access and publishing are governed by Workspaces'
permissions, so verify who can create/publish parallel workspaces (publishing a workspace makes its content
live). It has no access-control role of its own. Configure the parallel-workspace behaviour.

---

- Support parallel workspaces.
- Let content exist in multiple workspaces.
- Stage independent changes in parallel.
- Go beyond core's hierarchical model.
- Depend on core Workspaces.
- Use the workspaces_parallel_graph submodule.
- Handle concurrent campaigns/releases.
- Govern access via Workspaces permissions.
- Verify who can create/publish workspaces.
- Know publishing makes content live.
- Have no access-control role of its own.
- Stage concurrent changes.
- Support advanced content staging.
- Manage parallel workspaces.
- Configure parallel behaviour.
- Stage multiple releases.
- Handle concurrent staging.
- Verify publishing permissions.
- Support Workspaces workflows.
- Enable parallel staging.
