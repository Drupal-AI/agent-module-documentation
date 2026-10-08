# Embed permissions

From `embed.permissions.yml`:

- **`administer embed buttons`** — create, edit, delete embed buttons and change the global
  Embed settings (icon file scheme / upload directory). Gates the routes under
  `/admin/config/content/embed`. Grant to trusted site builders only.

Note: whether an author can *use* a given embed button in the editor is not a standalone
permission — it is governed by the text format's `use` access plus the
`access_check.embed_button_editor` check (see [api/api.md](../api/api.md)).
