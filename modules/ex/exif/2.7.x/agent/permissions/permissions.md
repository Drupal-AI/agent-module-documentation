# Exif permissions

One permission, declared in `exif.permissions.yml` with `restrict access: TRUE`:

| Permission | Gates |
|---|---|
| `administer image metadata` | All Exif admin routes: the settings form (`exif.config`), the sample page (`exif.sample`), and every helper route (`exif.helper`, and the vocabulary/nodetype/mediatype scaffolding sub-routes). |

There is no separate view permission — extraction and field population happen automatically on entity
save for enabled bundles; whether an extracted value is visible is governed by normal Field API view
access on the target field.

Note: the helper scaffolding routes (`exif.helper.vocabulary`, `exif.helper.nodetype`,
`exif.helper.mediatype`) create a vocabulary / node type / media type as a side effect of a GET
request, gated only by this permission.
