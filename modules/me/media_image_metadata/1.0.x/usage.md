<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Image Metadata extracts embedded image metadata (EXIF/IPTC) and makes it available for use in media entities.

---

Media Image Metadata extracts metadata embedded in image files — EXIF and IPTC fields such as
camera, capture date, caption, copyright and geolocation — and makes it available to populate fields on
media entities. This lets sites auto-fill media metadata (photographer, description, date) from what the
photographer embedded, instead of retyping it. It depends on core Media.

Use it to enrich media library items from embedded metadata (photo archives, DAM-style workflows).
**Privacy caveat: embedded image metadata can contain sensitive data — notably GPS geolocation (where a
photo was taken) and personal information.** Decide which EXIF/IPTC fields to extract and expose, and be
careful not to publish location/PII metadata unintentionally (consider stripping GPS from public
images). It is a media/metadata feature; it reads and maps metadata and has no access-control role.

---

- Extract EXIF/IPTC image metadata.
- Auto-fill media fields from metadata.
- Use camera/date/caption data.
- Populate photographer/copyright fields.
- Depend on core Media.
- Enrich media library items.
- Avoid retyping metadata.
- Mind GPS geolocation in EXIF.
- Avoid publishing location/PII unintentionally.
- Choose which metadata to extract.
- Consider stripping GPS from public images.
- Map metadata to fields.
- Support DAM-style workflows.
- Read embedded metadata.
- Handle photo archives.
- Have no access-control role.
- Extract capture date.
- Fill descriptions from IPTC.
- Enrich images automatically.
- Manage image metadata carefully.
