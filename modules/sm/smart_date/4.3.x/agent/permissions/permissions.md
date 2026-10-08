# Permissions

From `smart_date.permissions.yml`:

- `administer smart date formats` — declared permission (`restrict access: true`) intended for
  managing `smart_date_format` config entities.

Note: in this release the Smart date formats admin UI and the `smart_date_format` entity's
`admin_permission` are actually gated by core's **`administer site configuration`** (see
`smart_date.routing.yml` and `SmartDateFormat` entity annotation), not by the permission above.
Grant `administer site configuration` to create/edit/delete formats.

The **smart_date_recur** submodule adds (`smart_date_recur.permissions.yml`):
- `make smart dates recur`
- `reschedule smart date recur instances` — required for the Manage Instances UI, reschedule/
  override, apply-changes, and revert endpoints.
- `cancel smart date recur instances` — required to remove (cancel) a single instance.

See that submodule's docs for the recurring routes.
