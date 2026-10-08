<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Dynamic per-option permission (the one that matters)

For **each** Download Option Config entity, a permission is generated:

- **`use {id} download option link`** — title `"{label} : Use download option"`.
- Defined by the permission callback `DownloadOptionConfigPermissions::downloadOptionConfigConfigPermissions`
  (`file_downloader.permissions.yml` → `permission_callbacks`;
  `src/DownloadOptionConfigPermissions.php`), which iterates `DownloadOptionConfig::loadMultiple()`.

This is the primary access gate: the download route's access check
(`DownloadOptionConfig::accessDownload`) requires the current user to hold this permission before it
even considers the file. Grant it (People → Permissions) to the roles that should be able to use a
given option's download link. It is **not** granted to anonymous by default. Downloads then still
require the file's own `view` access and (if configured) a matching extension — see
[../api/download-route.md](../api/download-route.md).

Because the permission name embeds the config entity id, the permissions list only shows these once
at least one Download Option Config exists.

## Static permission

- **`administer download_option configuration`** — title "Configure download option form".
  Declared in `file_downloader.permissions.yml`. Note: this permission is defined but **not**
  referenced by any route or the config entity type. The admin UI for Download Option Config entities
  (collection/add/edit/delete routes) is instead gated by the entity's
  `admin_permission = "administer site configuration"` (a core permission). So in practice, managing
  download options requires **`administer site configuration`**.
