<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Canonical Download — agent index

Makes a media entity's **canonical URL serve its file directly** (download the file vs the media view page).
Alters media routes to a download controller. Version **1.0.x** (dev). Core `^10||^11`.

Media/download — alters the **canonical** route (access-checked with media **view** access), so downloading
requires view access to the media (`Cache-Control: private`). Verify this matches intent for private/
restricted media. No additional access role.
