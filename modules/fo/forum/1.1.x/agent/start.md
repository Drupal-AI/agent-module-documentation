# forum — agent start

Threaded discussion boards. Containers + forums are **taxonomy terms** in the `forums`
vocabulary (leaf terms flagged `forum_container = 0`, grouping terms `= 1`); topics are
`forum` nodes tied to one forum via the `taxonomy_forums` field; replies use the
`comment_forum` comment type. Depends on `node`, `taxonomy`, `comment`, `options`,
`history`. Admin UI: **Admin → Structure → Forums** (`/admin/structure/forum`, configure
route `forum.overview`). Global settings: `/admin/structure/forum/settings`
(`forum.settings` route + config object).

- Build the board: containers, forums, `forum.settings`, the two blocks → [configure/forums.md](configure/forums.md)
- Query the board in code (`forum_manager`, `forum.index_storage`) → [api/forum-manager.md](api/forum-manager.md)
- Theme hooks, templates, validation constraint, entity hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions that gate admin, posting and replies → [permissions/permissions.md](permissions/permissions.md)
