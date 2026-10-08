<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `exif.permissions.yml`:

| Permission | Restrict access | Gates |
|---|---|---|
| `administer image metadata` | `TRUE` | The whole settings/helper/sample UI. |

This single permission is the `_permission` requirement on every module route in
`exif.routing.yml`:

- `exif.config` — `/admin/config/media/exif` (settings form).
- `exif.sample` — `/admin/config/media/exif/sample`.
- `exif.helper` — `/admin/config/media/exif/helper` and the three scaffolding sub-routes
  (`.../helper/vocabulary`, `.../helper/nodetype`, `.../helper/mediatype`), which create config
  entities (vocabulary / node type / media type + fields).

The module defines no other permissions. Metadata extraction itself happens automatically in entity
presave/create hooks and is not separately permissioned — it runs for any content saved on an
enabled bundle, subject to normal entity/field access. Grant `administer image metadata` only to
trusted administrators, as it is marked `restrict access: TRUE` and its helper routes mutate site
configuration.
