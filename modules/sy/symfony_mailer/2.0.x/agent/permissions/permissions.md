# Permissions

From `symfony_mailer.permissions.yml`:

- **`administer mailer`** — manage all Mailer Plus settings. `restrict access: true`.
  Gates the verify page and every submodule config UI (policies, transports, overrides):
  routes `symfony_mailer.verify`, `entity.mailer_policy.*`, `entity.mailer_transport.*`,
  and `mailer_override.*` all require this permission (or the corresponding entity access).

No other permissions are defined by the base module or its submodules.
