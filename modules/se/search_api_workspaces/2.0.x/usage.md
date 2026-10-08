<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Workspaces makes Search API cooperate with core Workspaces, so that indexing and search results reflect workspace-specific (draft/staged) content revisions rather than only the default/live revision.

---

The module supplies a workspace-aware content datasource (`WorkspacesContentEntity` with its deriver and tracking manager) that replaces the standard datasource, processors (`WorkspaceAssociation`, `SourceWorkspace`) to record and filter by workspace, a Views filter (`SearchApiWorkspace`), and an event subscriber plus a service provider to wire everything into Search API's indexing pipeline. Together they ensure items tracked/indexed under a workspace are associated with it and that queries can be scoped to the active workspace. It requires `workspaces` and Search API >= 8.x-1.14. It has no routes or permissions of its own; behavior is governed by Workspaces and Search API permissions. Correct results depend on re-indexing and on the datasource being switched to the workspace-aware variant.

---

- Index draft content that lives in a non-default workspace.
- Return search results matching the active workspace revision.
- Preview staged content in search before publishing.
- Associate indexed items with their workspace.
- Filter Views search results by workspace.
- Swap in a workspace-aware Search API datasource.
- Keep live search unaffected by unpublished workspace edits.
- Track workspace-specific revisions in the index.
- Support content-staging workflows with search.
- Scope queries to the current workspace automatically.
- Integrate Workspaces with existing Search API indexes.
- Avoid leaking draft content into the default workspace search.
- Use processors to record source workspace on items.
- Combine staged search with Search API facets/views.
- Re-index to reflect workspace associations correctly.
