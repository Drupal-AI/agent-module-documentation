<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Photos access — agent index

Submodule of **Photos**. Adds per-album privacy — **Open / Locked / User list / Password** —
enforced via Drupal node access grants. No configure route, no permissions of its own, no config
schema. Its master switch is a flag in the parent's `photos.settings`; per-album state lives in
two DB tables.

- **Turn album privacy on and set an album's privacy level (the toggle, the node form, viewids)** →
  [configure/album-privacy.md](configure/album-privacy.md)
- **How access is enforced (node grants, tables, Views access plugin, password flow, file moves)** →
  [api/access-model.md](api/access-model.md)

Key facts:
- Master switch: `photos.settings:photos_access_<content_type>` (e.g. `photos_access_photos`).
  When true, album privacy is active for that album/node type.
- Per-album privacy stored in table `photos_access_album` as `viewid`:
  **0 = Open, 1 = Locked, 2 = User list, 3 = Password** (+ `pass` hash). Allowed users in
  `photos_access_user`.
- Password entry route: `photos_access.page` → `/photos_privacy/pass/{node}`.
- Views access plugin id: `photos_access` (`Plugin/views/access/PhotosAccess`).
- Uninstalling resets `photos.settings:photos_access_photos` to 0.
- Parent module docs: `../../../6.1.x/` (photos).
