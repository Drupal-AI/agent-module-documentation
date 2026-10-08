<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`content_sync.permissions.yml` — all four are `restrict access: true`, i.e. Drupal warns that
granting them is a trust decision.

| Permission | Gates |
|---|---|
| `synchronize content` | The sync/change-list screen (`content.sync`), the diff routes, and the settings form (`content.settings`) |
| `export content` | Export forms + the archive download (`content.export_full`, `content.export_single`, `content.export_multiple_confirm`, `content.export_download`) |
| `import content` | Import forms (`content.import_full`, `content.import_single`) |
| `logs content` | The module's log screen (`content.overview`) |

Why they are restricted:

- **`import content` is effectively "create/update/delete any content entity"**. The importer runs
  with no entity-access checks, matches on UUID, and saves whatever the YAML says — including
  `user` entities (roles, status; anonymous uid 0 is the only guarded case). Treat it as an
  administrative permission, never grant it to an editor role.
- **`export content` reads all content regardless of access**: `--force` exports run entity
  queries with `accessCheck(FALSE)`, and the UI export includes unpublished entities. The
  download route serves `content.tar.gz` straight from the temp directory.
- `synchronize content` includes the settings form, which can switch on `site_uuid_override` and
  thereby remove the cross-site import guard.

```bash
drush role:perm:add content_admin 'synchronize content'
drush role:perm:add content_admin 'export content'
drush role:perm:add content_admin 'import content'
drush role:perm:add content_admin 'logs content'

# Who has them today?
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if ($r->hasPermission("import content")) print $r->id() . "\n"; }'
```

The only non-admin route is `content_sync.element.message.close`
(`/content_sync/message/close/{storage}/{id}`), which requires just a logged-in user plus a CSRF
token and merely dismisses a UI message.
