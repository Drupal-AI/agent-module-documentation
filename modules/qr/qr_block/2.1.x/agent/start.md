<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QR Block (qr_block) — agent index

**Placeable block that renders a QR-code `<img>` from tokenized text via a pluggable QR-URL service.**

- **Version:** 2.1.x
- **Core:** `^8.8 || ^9|| ^10 || ^11`
- **Depends:** token, block
- **Block plugin:** `qr_block` (`QRImageBlock`) — config: text (tokens), display_text, width/height, qrcode_plugin.
- **Services:** `qr_block.qrimage` (`QRImage::build()` → `#theme=image`, `#uri`= service URL); `plugin.manager.qr_block`.
- **Plugin type:** `QRUrlServicePlugin` — ships `gchart` (Google Chart API) and `goqr` (goQR.me), both targeting `api.qrserver.com`.
- **Routes / permissions:** none of its own; block placement via core block admin.

**Security:** admin-gated block config; no anonymous or mutating endpoint. Privacy note: the QR payload is rendered as an external image URL (`api.qrserver.com`) fetched by the visitor's browser — data leaves the site, but the server performs no fetch (no SSRF). See [extend/generator-plugin.md](extend/generator-plugin.md). No security findings.
