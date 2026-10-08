<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Streamlike Media (streamlike_media) — agent index
**A 'Streamlike Media' field type (+widget +formatter) that embeds Streamlike video players by media ID.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 · **Package:** Streamlike · **Depends:** field
- **Field type:** `streamlike_media_field` (stores media ID; setting `cdn_default` = `cdn.streamlike.com`)
- **Widget:** `streamlike_media_field_widget` · **Formatter:** `streamlike_media_field_formatter`
- No routes, permissions, or services; configured via Field UI.

**Security:** Field-level only; media ID is entered by editors and the player loads client-side from the Streamlike CDN. No anonymous mutation endpoints and no module-side server fetch.

See [extend/field.md](extend/field.md)
