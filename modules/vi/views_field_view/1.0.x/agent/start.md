# views_field_view — agent start

Adds one Views field handler, "Global: View" (`@ViewsField("view")`), that embeds a child
view as a field in a parent view and passes contextual-filter values from the parent row via
tokens. Registered through `hook_views_data_alter()`. Depends on core `views`. No admin
settings form, no permissions, no public service API. Only setting: `views_field_view.settings`
key `evil` (default `false`) — the recursion guard.

- Add & configure the "Global: View" field, map parent fields/args to child contextual
  filters via tokens → [configure/views_field_view.md](configure/views_field_view.md)
