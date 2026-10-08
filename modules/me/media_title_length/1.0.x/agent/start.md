<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Title Length - agent index

Sets the max length of the media `name` field via config + a live DB schema alter. Depends on core `media`.

Key facts:
- Config `media_title_length.config` -> `title_length` (default 255).
- `hook_entity_base_field_info_alter()` applies `title_length` to `media.name` `max_length`.
- Form `TitleLengthForm` at `/admin/mtl/config` (perm `modify title length`, restricted) validates 1-65535,
  then calls `media_title_length_changer()` which runs `Database::changeField()` on `media_field_data`,
  `media_field_revision` (and `admin_audit_trail.ref_char` if present).
- Shrinking below existing name lengths risks truncation; increases are safe. Version dir `1.0.x`.
