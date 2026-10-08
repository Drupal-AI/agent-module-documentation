# Permissions

Defined in `dropzonejs.permissions.yml`.

| Permission | Gates |
|---|---|
| `dropzone upload files` | Using any DropzoneJS uploader. Required by the `dropzonejs.upload` route (`_permission`) and checked in the form element's process callback — without it the element is hidden (`#access = FALSE`) and a warning is shown. |

Grant example:
```
drush role:perm:add authenticated 'dropzone upload files'
```
