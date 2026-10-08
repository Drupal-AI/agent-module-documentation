<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Download Count (media_entity_download_count) — agent index

**Counts media file downloads into a per-media-type field and logs each download (file, uid, ip).**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Depends on:** media_entity_download
- **Config route:** `media_entity_download_count.settings` (`/admin/config/media/download/count/form/settings`) — permission `administer media entity download count`; stores `download_count_excluded_file_extensions`.
- **Per-type config:** `hook_form_media_type_edit_form_alter` adds enable + count-field select (stored as third-party settings `enable_count` / `count_field`).
- **Counting:** `hook_file_access($op == 'download')` resolves the referencing media, increments the count field, saves the entity, and logs filename/uid/ip.
- **Permissions:** `administer media entity download count`, `skip media entity download counts`.

**Security:** admin settings route is permission-gated; counting is a read-path write (increment + `Media::save()` inside `hook_file_access`) and uses a non-atomic read-modify-write, so counts may drift under concurrency. No unsafe SQL or unverified request writes.

See [configure/setup.md](configure/setup.md)
