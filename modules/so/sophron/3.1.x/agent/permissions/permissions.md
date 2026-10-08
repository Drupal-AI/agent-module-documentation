# Permissions & JSON feed

Defined in `sophron.permissions.yml`.

| Permission | Gates |
|---|---|
| `access mime types json feed` | Access to the MIME types JSON feed at `/sophron/mime-types.json` (route `sophron.mime_types.json`, controller `JsonController::mimeTypes`). |

The admin settings form itself is gated by core's `administer site configuration`
(route `sophron.settings`). The JSON feed returns `getMimeTypesJson()` from the
MimeMapManager — a machine-readable dump of every known MIME type and its extensions.
