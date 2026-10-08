# Configure

Settings form route `publishcontent.settings` → `/admin/config/workflow/publishcontent`
(menu link under Configuration ▸ Workflow; gated by the `access publish content settings`
permission). Config object: `publishcontent.settings`.

## Config keys (config/install defaults)

| Key | Type | Default | Effect |
|---|---|---|---|
| `ui_localtask` | boolean | `true` | Show the Publish/Unpublish **local task tab** beside View/Edit. Also gates the toggle route (`hasUiLocalTask` custom access). |
| `ui_checkbox` | boolean | `false` | Show a publish **checkbox** near the bottom of node edit forms. When off, the core status widget is disabled for everyone. |
| `create_revision` | boolean | `false` | Create a new node revision on each toggle, with a "Changed to … by …" revision log. |
| `create_log_entry` | boolean | `false` | Write a watchdog/logger notice on each toggle (channel `publishcontent`). |
| `publish_text_value` | label | `Publish` | Text of the publish button/link/tab and the status widget title. |
| `unpublish_text_value` | label | `Unpublish` | Text of the unpublish button/link/tab. |
| `publish_markup_value` | label | `Published` | Markup shown in the node form meta area when published. |
| `unpublish_markup_value` | label | `Unpublished` | Markup shown when unpublished. |

All four text/markup fields are `#required`. Saving the form invalidates the `local_task`
cache tag so the tab label refreshes.

## Set via Drush (no UI needed)

```bash
drush config:set publishcontent.settings ui_localtask 1 -y
drush config:set publishcontent.settings ui_checkbox 1 -y
drush config:set publishcontent.settings create_revision 1 -y
drush config:set publishcontent.settings create_log_entry 1 -y
drush config:set publishcontent.settings publish_text_value 'Go live' -y
```

The form groups `ui_localtask`/`ui_checkbox` under a "User interface preferences" details
element and `create_revision`/`create_log_entry` under "Accountability preferences".
