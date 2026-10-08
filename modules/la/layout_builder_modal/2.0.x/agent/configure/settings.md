# Settings

Config object `layout_builder_modal.settings` (schema
`config/schema/layout_builder_modal.schema.yml`). UI at
`/admin/config/user-interface/layout-builder-modal` (route `layout_builder_modal.config`,
permission `administer layout builder modal`).

| Key | Type | Meaning |
|---|---|---|
| `modal_width` | string | Width of the modal dialog (e.g. `800`, a pixel value). |
| `modal_height` | string | Height of the modal dialog, or `auto`. |
| `modal_autoresize` | bool | Whether the dialog resizes to fit its content. |
| `theme_display` | string | Which theme renders the block form inside the modal — the active front-end theme or the admin theme. |

There is nothing to configure per block or per layout: once enabled, the module's
`AjaxResponseSubscriber` retargets Layout Builder's add/configure-block AJAX responses to a
jQuery UI modal using these settings.

```
drush config:set layout_builder_modal.settings modal_width 900 -y
drush config:set layout_builder_modal.settings modal_autoresize true -y
```

Only one permission is provided: `administer layout builder modal` (gates this settings form).
