# BUEditor — permissions

Defined in `bueditor.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer bueditor` | **true** | All editor/button/settings admin routes (`/admin/config/content/bueditor…`) and the `admin_permission` of both config entities. Trusted admin — holders define button `code`/`template`/libraries. |
| `access ajax preview` | (not restricted) | The `/xpreview` Ajax preview endpoint and whether the `xpreview` toolbar button is attached. |

## The `/xpreview` endpoint (`XPreviewController::response`)

Route `drupal.xpreview`, `_permission: access ajax preview`. Renders the `input` POST body through
a text format and returns JSON. Access model:

- **Authenticated users:** a CSRF `token` (scope `xpreview`, added to the JS settings URL in
  `bueditor_js_settings_alter` for non-anonymous users) is validated; an invalid/missing token
  returns "Invalid security token." So authenticated preview is CSRF-protected.
- **Anonymous users:** the token check is skipped, but rendering is still bounded by format access:
  the `format` requested is only applied if `filter_format` `access('use')` passes for that user;
  otherwise it falls back to `filter_fallback_format()` (typically plain_text, which escapes).
- The rendered output is returned to the **same requester** who supplied the input (a self-preview),
  not stored or shown to other users — so it is not a stored/cross-user XSS vector.

Grant `access ajax preview` to roles that should be able to use the live-preview button. Because the
endpoint only ever renders formats the caller already has `use` access to and reflects output back
to that caller, it does not widen a user's effective privileges.
