<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Workspaces (search_api_workspaces) — agent index

**Workspace-aware Search API datasource/processors so indexing and queries respect the active Workspace.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Depends:** search_api (>=8.x-1.14), workspaces
- **Package:** Search

**Surface:** `WorkspacesContentEntity` datasource (+deriver, tracking manager), processors `WorkspaceAssociation` / `SourceWorkspace`, Views filter `SearchApiWorkspace`, event subscriber + `SearchApiWorkspacesServiceProvider`. No routes/permissions.

**Security:** governed by Workspaces + Search API permissions. Purpose is to keep draft/workspace content correctly scoped so it does not leak into default-workspace search. No request surface. Low risk.
