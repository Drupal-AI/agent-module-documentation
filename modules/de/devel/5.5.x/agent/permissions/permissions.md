# Devel permissions

From `devel.permissions.yml` (both `restrict access: TRUE` — grant only to trusted developers):

- `access devel information` — view developer output: variable dumps, query log,
  introspection pages (routes/services/events/entities), config editor, etc.
- `switch users` — use the Switch User block/links to become any account on the site.

Most admin action routes (reinstall, menu rebuild, config editor, settings) are additionally
gated by core's `administer site configuration`.
