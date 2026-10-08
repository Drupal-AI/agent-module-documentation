# Search API Workspaces — manual setup guide

**Search API Workspaces** (`search_api_workspaces`) makes Search API cooperate
with core **Workspaces**, so that indexing and search results reflect
workspace-specific (draft or staged) content revisions rather than only the
default, published revision. If you use Workspaces for content staging, this is
what lets your search preview the staged content correctly instead of leaking
drafts into the live workspace's search.

Under the hood it supplies a workspace-aware content **datasource** that replaces
the standard one, indexing items with the ID pattern `{entity_id}:{langcode}:{revision_id}`
so each workspace revision is tracked distinctly. It adds processors that record
and filter by workspace (a workspace-association field and a source-workspace
processor), a **Views filter** so you can scope search results to the currently
selected workspace, and an event subscriber plus a service provider that wire it
all into Search API's indexing pipeline. Together they keep draft content correctly
scoped so it does not appear in the wrong workspace's search.

This module needs configuration to be useful — enabling it is not enough. You must
switch your index's datasource to the workspace-aware variant and re-index for the
associations to be correct. It depends on **Search API (>= 8.x-1.14)** and core
**Workspaces**, and requires **Drupal 9 or 10**. It has no routes or permissions of
its own; access is governed entirely by the Workspaces and Search API permissions
you already have.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in Workspaces, and enable it.

## How to use it

After enabling, edit the Search API index you want to make workspace-aware
(**Configuration → Search and metadata → Search API** → your index) and switch its
**datasource** to the workspace-aware content variant this module provides. Add the
workspace-association processor if you want to filter by workspace, then re-index —
the workspace associations are only correct after a re-index. In your Search API
Views you can then add the **Search API Workspace** filter to scope results to the
active workspace.
