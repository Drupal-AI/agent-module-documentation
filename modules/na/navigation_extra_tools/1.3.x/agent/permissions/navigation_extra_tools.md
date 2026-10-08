# Permissions

Defined in `navigation_extra_tools.permissions.yml`. All three are marked
`restrict access: true` (they grant administrative capabilities). Users must be granted the
relevant permission before the corresponding Tools menu items appear and work.

| Permission | Gates |
|---|---|
| `access navigation extra tools cache flushing` | All cache-flush routes: Flush all caches (`/admin/flush`), the "Flush individual cache" links (CSS/JS, plugins, static, routing & links, Twig, render, Views, theme-registry rebuild), and the `/admin/tools/individual` block page. |
| `access navigation extra tools cron` | The Run cron link/route (`navigation_extra_tools.run.cron`, `/run-cron`). |
| `access project browser clear storage` | The deriver's Project Browser "Clear storage" link (`/admin/project_browser/clear`) — clears Project Browser non-volatile storage; intended for development/debugging. |

Notes:

- The top-level **Tools** (`/admin/tools`), **Development** (`/admin/tools/devel`) block pages
  use a custom access check (`navigation_extra_tools.access_checker::access`,
  `ToolsAccess`) rather than a single permission.
- The **Run updates** link points at core's `system.db_update` route, which is governed by
  core's own update-access logic (not a permission defined by this module).
- The wrench icon library is attached only to users who have the core `access navigation`
  permission (see `hook_page_attachments()`).

```
drush role:perm:add site_manager 'access navigation extra tools cache flushing'
drush role:perm:add site_manager 'access navigation extra tools cron'
```
