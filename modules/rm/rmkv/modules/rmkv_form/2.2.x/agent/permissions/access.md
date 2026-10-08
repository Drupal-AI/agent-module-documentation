# Permissions

Defined in `rmkv_form.permissions.yml`.

| Permission title | Machine name | restrict access | Grants |
|---|---|---|---|
| Access to "Remove system.schema key/value storage" form. | `access to rmkv form` | TRUE | Reach the removal form at `/admin/config/development/rmkv` and delete orphaned `system.schema` records. |

The route `rmkv_form.form` requires exactly this permission (`_permission: "access to rmkv form"`),
so only roles explicitly granted it can open the form or perform a deletion. `restrict access: TRUE`
marks it as sensitive on the People ▸ Permissions page (Drupal shows a warning before granting).
Grant it only to trusted administrators/developers — deleting a schema record tells Drupal the
extension was uninstalled.

Grant via drush:

    drush role:perm:add administrator 'access to rmkv form'
