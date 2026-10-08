<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Download Count records how many times a media entity's file has been downloaded, storing the running total in a field you designate per media type.

---

The module extends the `media_entity_download` module. On each media type's edit form it injects (via `hook_form_media_type_edit_form_alter`) a "Media Download Count configuration" fieldset where you enable counting and pick a target field — any non-base `string`, `string_long`, or `integer` field on that media type — saved as third-party settings on the media-type config entity. It then implements `hook_file_access()`: when the operation is `download`, it resolves the referencing media entity, reads the configured count field, increments it, saves the media entity, and writes a log entry recording the filename, the downloading user's UID, and their IP address. Users with the `skip media entity download counts` permission are not counted (useful for admins/editors), and downloads triggered while adding media are ignored. A settings form at `/admin/config/media/download/count/form/settings` (permission `administer media entity download count`) stores a list of excluded file extensions.

Typical setup is: add a text or integer field to the media type, enable counting on that type and select the field, then optionally set excluded extensions and grant "skip" to staff roles. Operational notes: the counter is incremented inside the file-access check, so every access that grants download increments it and re-saves the media entity (a write on read path); the increment is not concurrency-safe (read-modify-write), so exact counts under heavy parallel load may drift. No unsafe SQL or request-driven writes beyond the entity save are present.

---
- Track how many times a downloadable media file is fetched.
- Store download totals in a per-media-type integer field.
- Show a "downloaded N times" figure on a media display.
- Enable counting only on specific media types (e.g. Document).
- Choose which existing field holds the download count.
- Exclude private image fields from counting via file extensions.
- Exempt admins/editors from inflating counts with the skip permission.
- Log the filename, user ID, and IP of each download.
- Audit download activity via the dblog channel.
- Identify the most-downloaded assets by sorting the count field.
- Avoid counting downloads during media add/upload flows.
- Add download tracking without writing custom code.
- Report on document/PDF popularity across the site.
- Gate the settings form behind an admin permission.
- Configure excluded extensions in one central form.
- Combine with Views to list media by download count.
- Reset a count by editing the media entity's count field.
- Track downloads for audio/video media as well as documents.
- Give a role permission to skip counting for internal testing.
- Surface download counts in an editorial dashboard.
