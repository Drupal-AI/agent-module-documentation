# Permissions

Defined in `default_content_deploy.permissions.yml`. Both are flagged
`restrict access: TRUE` (Drupal marks them as trusted-role permissions).

| Permission | Title | Grants | Used by |
| --- | --- | --- | --- |
| `default content deploy import` | Import content | Run a content import through the UI (folder or uploaded archive), overwriting existing content. | Route `default_content_deploy.import` (form `ImportForm`). Also the info.yml `configure` link. |
| `default content deploy export` | Export content | Run a content export through the UI and download the resulting archive. | Routes `default_content_deploy.export` and `default_content_deploy.export.download`. |

Notes:

- The settings form route `default_content_deploy.settings` is gated by core
  `administer site configuration`, not by these permissions.
- Drush commands do not check these UI permissions — they run under the Drush user
  and, in CLI, the importer/exporter switch to an administrator account (see
  `api/services.md`).
- `default_content_deploy.install` update `8001` migrates a legacy `import content`
  permission to `default content deploy import`.

Grant example:

```bash
drush role:perm:add content_deployer 'default content deploy import'
drush role:perm:add content_deployer 'default content deploy export'
```
