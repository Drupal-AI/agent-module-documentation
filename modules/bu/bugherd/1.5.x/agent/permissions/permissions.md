# Permissions

Defined in `bugherd.permissions.yml`.

| Permission | Grants |
|---|---|
| `administer bugherd` | Access the settings form (`bugherd.settings_form`, `/admin/config/development/bugherd`). This is the route's only requirement. Administer-only; restrict to trusted roles. |
| `access bugherd` | **Determines who receives the widget.** `hook_page_attachments()` attaches the BugHerd loader and `drupalSettings` only if the current user `hasPermission('access bugherd')`. Grant it to reviewer roles only. |

Notes:
- `access bugherd` is not marked `restrict access`, so it can be granted to any role,
  including the *anonymous user* role — do that only if you intend the widget (and its
  project key) to be delivered to the public (e.g. a BugHerd public-feedback setup).
- Neither permission gates server-side data; `access bugherd` only toggles whether the
  client-side snippet is emitted.
