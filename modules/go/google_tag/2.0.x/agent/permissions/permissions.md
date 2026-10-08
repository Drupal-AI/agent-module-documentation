# Permissions

From `google_tag.permissions.yml`:

- **`administer google_tag_container`** (`restrict access: TRUE`) — configure the site's Google
  Tag integration: create/edit/enable/disable/delete tag container entities and edit global
  settings. Gates all `google_tag` admin routes and is the entity `admin_permission`. Marked
  restricted because it can inject arbitrary tag/tracking scripts into every page.
