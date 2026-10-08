<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yunke QRcode provides a render element that draws a QR code in the browser.

---

**yunke QRcode** adds a `yunke_qrcode` render element that generates a QR code entirely on the client using a bundled jquery.qrcode JS library (canvas or table rendering). Element properties control text, size, colours, fault-tolerance level, tag (div/span/p only, validated) and HTML attributes (escaped via `Attribute`/`Xss`). It ships a demo form and has no routes or permissions. Because generation is front-end only, no URL is fetched server-side.

Use it to embed QR codes (links, text, contact info) in render arrays without server-side image generation.

---

- Render a QR code as a render element.
- Generate the QR code in the browser (JS).
- Encode links or text as a QR code.
- Choose canvas or table rendering.
- Set QR width and height.
- Set foreground and background colours.
- Set the fault-tolerance/correction level.
- Restrict the wrapper tag to div/span/p.
- Escape custom HTML attributes safely.
- Embed QR codes in twig/render arrays.
- Show a demo via the bundled form.
- Avoid server-side image generation.
- Encode contact or URL data.
- Add QR codes to any page programmatically.
- Use the bundled jquery.qrcode library.
- Support noscript wrapping.
- Keep QR generation client-side only.
- Reuse the element across the site.