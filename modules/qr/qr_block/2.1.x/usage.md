<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
QR Block provides a placeable block that renders a QR-code image built from tokenized text using a pluggable QR-code URL service.

---

The module registers a `qr_block` Block plugin. In the block configuration you enter QR text (which supports tokens, e.g. `[site:name] [site:url]`), optional visible caption, image width/height, and which QR service plugin to use. At render time the `qr_block.qrimage` service runs the text through the token service, asks the selected `QRUrlServicePlugin` for a URL, and renders an `<img>` (`#theme => image`, `#uri => <service URL>`). Two service plugins ship: "Google Chart API" (`gchart`, default) and "QR Code Generator (goQR.me)" (`goqr`) — both currently build URLs against `https://api.qrserver.com/v1/create-qr-code`.

There are no routes, permissions, or configuration entities beyond the standard block config; placement and configuration are gated by the normal "administer blocks" capability. Important operational/privacy note: the QR image is an external URL rendered as an `<img>` `src`, so the encoded text is sent to a third-party service (api.qrserver.com) by the visitor's browser — the Drupal server does not fetch it, so there is no SSRF, but the QR payload leaves your site. Developers can add their own generator by implementing a `QRUrlServicePlugin` plugin.

---

- Place a QR-code block in any region via Block layout.
- Encode the site name and URL into a QR code with tokens.
- Generate a dynamic QR code per page using contextual tokens.
- Show or hide the human-readable QR text under the image.
- Set the QR image width and height.
- Choose the Google Chart API service plugin.
- Choose the goQR.me service plugin.
- Link a printed QR to your homepage.
- Encode a contact URL for scanning.
- Add a "scan to visit" block in the footer.
- Use tokens to embed the current node URL.
- Provide a custom QR generator via a QRUrlServicePlugin plugin.
- Render the QR image using core image theming.
- Reuse the qr_block.qrimage service programmatically.
- Restrict who can place/configure the block via block permissions.
- Display QR codes in a sidebar for marketing pages.
