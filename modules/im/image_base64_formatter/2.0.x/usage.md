<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Base64 Formatter renders an image field as a base64 data URI instead of a URL, so the image bytes travel inside the document.

---

There are a handful of places where a URL to an image is no good and the bytes have to be present. **HTML email** is the main one: many clients block remote images by default, so a logo referenced by URL simply does not appear, while an embedded one does. **Offline or self-contained documents** — an exported HTML report, a single-file archive, a PDF generation pipeline — need everything inline. So does anything rendered where the recipient cannot reach the site: a preview inside a closed system, a payload for a third party who will not fetch from your domain. This formatter covers all of them without a template override. Version **2.0.5** on `^9 || ^10 || ^11`, depending on core `image`. Use it knowing the costs, because they are large and easy to overlook. **Base64 inflates by roughly a third**, so a 300 KB photograph becomes about 400 KB of text — inside the HTML, not alongside it. That means it is **not cached separately**: the browser cannot reuse it across pages, and it is re-sent on every render of the containing document, whereas a URL is fetched once and cached for a year. It also bloats the render cache entry holding it. This is the right tool for small images in documents that must be self-contained, and the wrong one for anything on a web page a browser will load normally.

---

- Embed a logo in an HTML email.
- Avoid blocked remote images in email.
- Produce a self-contained HTML export.
- Include an image in a PDF pipeline.
- Embed a small icon inline.
- Send an image to a system that cannot fetch it.
- Produce an offline-readable document.
- Embed a signature image.
- Include a chart in an exported report.
- Avoid a second HTTP request for a tiny image.
- Package an image inside a JSON payload.
- Render an image in a closed preview system.
- Embed a QR code image.
- Include a header image in a newsletter.
- Produce a single-file archive.
- Embed an avatar in a message.
- Support an air-gapped consumer.
- Include an image in a printed template.
