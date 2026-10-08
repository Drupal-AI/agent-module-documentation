# Simplifying permissions

All three are `restrict access: TRUE` (defined in `simplifying.permissions.yml`):

- `access simplifying setting` — reach the settings form (`simplifying.settings`,
  `/admin/config/development/simplifying`) and configure what is hidden.
- `access simplifying training page` — view the static Training page (`/admin/training`).
- `access simplifying services page` — view the static "Order additional services" page
  (`/admin/services`).

Not a permission but relevant: the AJAX route `simplifying.local_task_toggle`
(`/simplifying/{action}`) uses the core `access content` permission.
