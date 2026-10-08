# Permissions

| Permission | Gates |
|---|---|
| `administer schemadotorg` | Everything: the admin landing page, all four settings forms, the mapping and mapping-type collections, and mapping edit/delete forms. |

This single permission is **not** flagged `restrict access: TRUE` in `schemadotorg.permissions.yml`, yet it
grants the ability to create/delete content types, bundles, and fields (via mappings). Treat it as a
trusted content-architecture admin permission comparable to core's `administer content types` /
`administer node fields` — grant only to roles you trust to shape the content model.
