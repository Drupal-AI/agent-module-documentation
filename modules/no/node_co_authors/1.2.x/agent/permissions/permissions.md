# Permissions

The module defines **three** permissions (`node_co_authors.permissions.yml`). They control **who may
edit a node's co-author list** — they do *not* by themselves grant any access to the node's content.
What a co-author can *do* with the node is governed by the core "own content" permissions, conjoined
with co-authorship in `node_co_authors_node_access()` (see
[../api/access-model.md](../api/access-model.md)).

## Module permissions (edit the co-author list)

| Permission (machine name = title key) | Grants | Notes |
|---|---|---|
| `edit co-authors of own content` | The node **owner** may edit the `co_authors` field on nodes they authored. | Checked only when `entity.getOwnerId() === account.id()`. |
| `edit co-authors of co-authored content` | A user already **listed as a co-author** may edit that node's `co_authors` field. | This is the delegation permission: it lets a co-author add *further* co-authors (a chain to grant deliberately). |
| `edit co-authors of all content` | Edit the `co_authors` field on **any** node. | Broad; equivalent power over the list to `administer nodes`. |

`administer nodes` also always allows editing the `co_authors` field (OR'd in by the field-access
hook). None of these are marked `restrict access: true` in the YAML, but all three are administrative
in effect — grant them only to trusted roles.

Editing the co-author list also requires the user to be able to open the node's edit form (node
`update` access), so these permissions compose with normal node edit access.

## Core permissions that actually govern a co-author's access to the node

A user named as a co-author gains capability over that node **only** if they also hold the matching
core permission (the module `andIf`s the two):

- `edit own <type> content` → lets a co-author **edit** that node.
- `delete own <type> content` → lets a co-author **delete** that node.
- `view own unpublished content` → lets a co-author **view** that node while it is **unpublished**.

So a co-author receives exactly the rights their role already has over their *own* content of that
bundle — and nothing more. If you want a co-author to be able to edit but not delete, give them
`edit own <type> content` but not `delete own <type> content`.
