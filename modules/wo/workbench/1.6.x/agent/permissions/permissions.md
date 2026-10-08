# Permissions

Defined in `workbench.permissions.yml`.

| Permission | Title | Gates |
|---|---|---|
| `access workbench` | Access My Workbench | The whole "My Workbench" area — all `/admin/workbench*` pages (overview, My edits, All recent content, Create content), the Workbench toolbar tab, the shipped Views, and the `workbench_block`. Give this to any editor role. |
| `administer workbench` | Administer Workbench content settings | The settings form at `/admin/config/workflow/workbench` (route `workbench.admin`) that maps Views to the five dashboard regions. Trusted/administrative. |

The three shipped Views (`workbench_current_user`, `workbench_edited`,
`workbench_recent_content`) each set their access to require `access workbench`.

For Workbench to be useful an editor role also needs core content permissions, e.g.:

```
drush role:perm:add editor 'access workbench'
drush role:perm:add editor 'access toolbar'
drush role:perm:add editor 'create article content'
drush role:perm:add editor 'edit own article content'
```
