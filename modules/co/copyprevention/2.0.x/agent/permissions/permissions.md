# Permissions

From `copyprevention.permissions.yml` (both `restrict access: TRUE`):

| Permission | Gates |
|---|---|
| `administer copy prevention` | Access to the settings form route `copyprevention.settings_form` (`/admin/config/user-interface/copyprevention`). |
| `bypass copy prevention` | Users with this permission are **exempt** from the body/image deterrents: `_copyprevention_is_enabled()` returns FALSE for them, so no `<body>` attributes and no `drupalSettings`/JS are attached. |

Notes:
- `bypass copy prevention` does **not** exempt the image search-engine options
  (`copyprevention_images_search`): the header/meta-tag/robots.txt output in
  `hook_page_attachments()` / `hook_robotstxt()` runs before the enabled check, so `noimageindex`
  applies to everyone.
- Grant `bypass copy prevention` to editor/admin roles so the deterrents never impede content work.
