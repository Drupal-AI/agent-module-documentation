# Permissions / access

Search API Exclude defines **no custom permissions** (there is no
`search_api_exclude.permissions.yml`). Access is governed by existing core permissions:

| Action | Gated by |
|---|---|
| Enable exclusion for a content type (the *Enabled* checkbox on the node-type form) | `administer content types` (core Node) — it edits `node.type.{bundle}` config |
| Toggle a node's "Prevent this node from being indexed." checkbox | Whatever grants edit access to that node (e.g. `edit any {bundle} content` / `edit own {bundle} content`) — the field lives on the node form |
| Add the `node_exclude` processor to an index | `administer search_api` (from the Search API module) |

There is no separate "may exclude from index" permission: any user who can edit a node of an
exclusion-enabled bundle can set its exclusion flag. To restrict who can exclude, restrict who
can edit those nodes, or only enable exclusion on bundles edited by trusted roles.
