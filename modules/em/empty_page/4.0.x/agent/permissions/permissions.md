# Permissions (empty_page.permissions.yml)

| Permission | Restrict access | Gates |
|---|---|---|
| `administer empty pages` | yes | The admin screens (`/admin/structure/empty-page` add/edit/delete callbacks) |
| `view empty pages` | no | Viewing the generated empty pages (each `empty_page.page_<cid>` route requires this) |

- `administer empty pages` is a restricted/admin permission — grant only to trusted roles.
- `view empty pages` gates the front-facing dynamic routes; grant it to whichever roles
  (often `anonymous`/`authenticated`) should be able to reach the block-built pages.

Grant with Drush: `drush role:perm:add anonymous 'view empty pages'`.
