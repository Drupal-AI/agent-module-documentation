<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Image Metadata — agent index

Extracts **embedded image metadata (EXIF/IPTC)** — camera/date/caption/copyright/**GPS** — to populate
media entity fields. Depends on core `media`. Version **1.0.6**. Core `^10||^11`.

**Privacy:** embedded metadata can include **GPS location and PII** — choose which fields to extract/
expose; avoid publishing location/PII (consider stripping GPS from public images). No access role.
