# permissions — what ai_ckeditor defines

From `ai_ckeditor.permissions.yml` — a single permission.

| Permission | Gates |
|---|---|
| `use ai ckeditor` | Use of the AI CKEditor endpoints. It is the `_permission` requirement on both routes (`ai_ckeditor.dialog` and `ai_ckeditor.do_request`), so without it the modal dialog and the request/streaming controller are inaccessible and the editor plugin will not work. The CKEditor 5 plugin also exposes `hasAccess` to the JS based on this permission. |

Grant it to roles that are allowed to edit content with the AI-enabled text formats, e.g.:

```bash
drush role:perm:add content_editor 'use ai ckeditor'
```

Note: this permission only controls access to the AI editor tools. The underlying AI calls
still run through AI Core's configured provider, which holds the API credentials (via the Key
module) and incurs usage cost — so grant it only to trusted editorial roles.
