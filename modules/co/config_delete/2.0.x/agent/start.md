# Config Delete — agent index

Adds a UI to **delete a single configuration object** (simple config or config entity), with an
option to also delete its config dependencies. One form, one permission. No settings, no
schema, no Drush, no plugin types.

- **The delete form: route, path, permission, the dependencies option, how it deletes** →
  [configure/delete-config.md](configure/delete-config.md)

Key facts:
- Form route `config_delete.delete` at `/admin/config/development/configuration/delete`
  (a *Delete* tab under Configuration synchronization, `config.sync`).
- Permission `delete configuration` (`restrict access: true`).
- Extends core `ConfigSingleExportForm` (Configuration type + name selects); adds a
  **Delete config dependencies** checkbox and a Delete button; removes the export textarea.
- Deletes via `\Drupal::configFactory()->getEditable($name)->delete()`; with the checkbox on,
  first deletes each name in the object's `dependencies.config`.
- Requires core `config`. No configure route in info.yml (`configure: null`).
