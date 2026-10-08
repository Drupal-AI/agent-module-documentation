<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Media Handler (migrate_media_handler) — agent index

**Migrate process plugins + a `MediaMaker` service that convert D7 file/link fields and inline WYSIWYG references into media entities.**

- **Version:** 2.1.x (release 2.1.1)
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** migrate, media, migrate_plus
- **Service:** `migrate_media_handler.mediamaker` (`MediaMaker`)
- **Process plugins:** `update_file_to_image`, `update_file_to_document`, `update_file_to_audio`, `update_link_to_video`, `dom_inline_image_handler`, `dom_inline_doc_handler`, `record_media_ref`
- **Config:** `migrate_media_handler.settings` (`site_uri`, `file_source`, `file_dest`, `file_owner`, `*_field_name`, `img_replace`, `doc_replace`)
- **Install:** adds `field_original_ref` (SHA1 file-hash text field) to each media bundle; removed on uninstall

See [plugins/process-plugins.md](plugins/process-plugins.md)

**Security:** Migration-time CLI/Drush tooling only — no routes, no permissions, no anonymous or mutating endpoints. Entity queries use `accessCheck(FALSE)`, appropriate for a trusted migration context; file copies read from the operator-configured source path. No security findings.
