# Permissions

The module declares exactly **one** permission (`localgov_publications.permissions.yml`):

| Permission | Title | Governs |
|---|---|---|
| `access publication views` | View lists of publications content | The `publications` admin View only (set by `hook_update_10004`, replacing the old `access content`). Not restricted (`restrict access` not set). |

Reader access to publication pages and cover pages is **ordinary node access** — each page/chapter is
an independent node honouring its own published/unpublished state and any node-access grants. There is
no aggregate "publication access"; a chapter is not gated by its parent's access.

## Node CRUD permissions

The two content types get the standard node-module permissions automatically, e.g.
`create localgov_publication_page content`, `edit any localgov_publication_cover_page content`,
`delete own localgov_publication_page content`, plus the revision permissions. Book placement also
uses core Book permissions: `administer book outlines`, `add content to books`, `create new books`.

## Default role grants (localgov_roles)

`localgov_publications_localgov_roles_default()` (fires only when the optional `localgov_roles` module
is present) grants the **`localgov_editor`** role the full editor set: `access publication views`,
the Book permissions (`add content to books`, `administer book outlines`, `create new books`), and
create/edit-any/edit-own/delete-any/delete-own/revert/view-revision permissions for **both** publication
content types. `hook_update_10003` back-fills `access publication views` onto an existing
`localgov_editor` role. No permission is granted to anonymous or authenticated by default.
