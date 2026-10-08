<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File entity (file_entity) — agent index

Makes core **files fieldable, typed and viewable** — file **types** (bundles), fields, display modes, field formatters, plus Views/Token/Entity-API integration and a file admin UI. Version **8.x-2.8**. Core `^10.5 || ^11.2`. Depends on core **file, text, views, image** and **token**. Configure at `/admin/config/media/file-settings` and `/admin/structure/file-types`.

Key routes (all access-gated): `/admin/structure/file-types*` (`administer file types`), `/file/add` (`_entity_create_access: file`), `/file/{file}` view/download/edit/delete (`_entity_access: file.*`), `/admin/content/files*` (`administer files`). The two `/file/add/upload*` routes gated by `access content` map to **empty controller stubs** (no-op) — not an upload bypass.

Permissions: `bypass file access`, `administer files`, `administer file types`, `create files`, `view files`, `view own files`, `view private files`, `view own private files`, plus per-type permissions.

Security: entity access + permissions throughout; private-file viewing gated by dedicated permissions; the `access content` routes are inert stubs. See [configure/file-types.md](configure/file-types.md).