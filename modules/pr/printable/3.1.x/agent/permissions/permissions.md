# Permissions

`printable.permissions.yml` defines two permissions:

| Permission | Gates |
|---|---|
| `administer printable` | The Printable config UI — all routes under `/admin/config/user-interface/printable` (the `printable.configure`, `...format_configure_print`, `...format_configure_pdf`, `printable.ui`, `printable.pdf_ui` forms). |
| `view printer friendly versions` | Viewing any printable page — the per-entity route `printable.show_format.{type}` at `/{type}/{entity}/printable/{format}`. Combined with core `entity.view` access on the entity. |

Grant, e.g.:

```bash
drush role:perm:add anonymous 'view printer friendly versions'
drush role:perm:add content_editor 'administer printable'
```

Note: the module also declares these two permissions again via a legacy
`printable_permission()` hook in `printable.module`; the effective source is
`printable.permissions.yml`.
