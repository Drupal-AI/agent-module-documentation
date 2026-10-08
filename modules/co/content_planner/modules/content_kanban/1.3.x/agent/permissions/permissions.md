# Permissions — content_kanban

From `content_kanban.permissions.yml`:

- `manage own content with content kanban` — access the board and manage own content. Not
  `restrict access: true`.
- `manage any content with content kanban` — access the board and manage any content. Not
  `restrict access: true`.
- `administer content kanban settings` — the settings form. `restrict access: true`.
- `add kanban log entities`, `edit kanban log entities`, `delete kanban log entities`,
  `view published kanban log entities`, `view unpublished kanban log entities` — CRUD on the
  `content_kanban_log` entity.
- `administer kanban log entities` — the log entity's `admin_permission`. `restrict access: true`.

Note: board access (the two `manage … content with content kanban` perms) only opens the board;
the actual drag-and-drop state change is separately validated per user against the Content
Moderation workflow's allowed transitions, so holding a board permission does not let a user
perform transitions they lack moderation permission for.
