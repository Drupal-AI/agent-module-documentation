# Permissions — responsive_preview

Defined in `responsive_preview.permissions.yml`:

| Permission | Gates |
|---|---|
| `access responsive preview` | Using the feature: the toolbar tab (`previewToolbar()` returns empty without it), the "Responsive preview controls" block (`blockAccess`), the Navigation top-bar item (submodule), and the admin-chrome stripping in `preprocessHtml()`. |
| `administer responsive preview` | Managing Device config entities — it is the entity `admin_permission`, so it protects the collection/add/edit/delete routes and the "Configure devices" link shown in the device list. |

Notes:
- Both are non-restricted (no `restrict access: true`).
- A content editor typically gets only `access responsive preview`; site builders get
  `administer responsive preview` too.
- Grant with drush, e.g. `drush role:perm:add editor 'access responsive preview'`.
