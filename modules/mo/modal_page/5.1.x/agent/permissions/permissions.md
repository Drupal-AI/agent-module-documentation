# modal_page permissions

The module defines exactly one permission (`modal_page.permissions.yml`):

| Permission | Notes |
|---|---|
| `administer modal page` | Title "Administer Modal". `restrict access: true` (marked a security-sensitive permission). |

It gates:

- Every admin route: the modals list (`entity.modal.collection` / `modal_page.default`),
  add/edit/delete modal forms, the settings form (`modal_page.settings`), help
  (`modal_page.help`), and the Bootstrap-enable AJAX endpoint.
- It is the entity `admin_permission` for the `modal` config entity type.

Routes that are **not** behind it:

- `modal_page.hook_modal_submit` (`/modal/ajax/hook-modal-submit`) requires only
  `access content`.
- `modal_page.cron` (`/modal-page/cron/{cron_key}`) uses a custom access check
  (`ModalCronController::access`) keyed on a cron key, not this permission.

Grant it with:

```bash
drush role:perm:add administrator 'administer modal page'
```
