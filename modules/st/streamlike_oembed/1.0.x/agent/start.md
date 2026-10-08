<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Streamlike oEmbed (streamlike_oembed) — agent index
**Discovers a Streamlike media ID from the current entity's configured field/route and embeds the player via oEmbed.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 · **Package:** Streamlike
- **Config route:** `streamlike_oembed.settings_form` → `/admin/config/media/streamlike-oembed` (perm `administer streamlike_oembed configuration`)
- **Service:** `streamlike_oembed.main` → `StreamlikeOembed` (`getMediaId`, `getMediaTitle`, `getPageEntity`, `isValidMediaId`)
- **Config:** `streamlike_oembed.settings:discover_media_id_source` (newline list of `route|field`)

**Security:** Only route is the permission-gated admin form; discovery is read-only against the current canonical entity. No anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md)
