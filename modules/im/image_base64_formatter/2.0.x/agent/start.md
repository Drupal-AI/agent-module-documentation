<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Base64 Formatter (image_base64_formatter) — agent index

Renders an image field as a **base64 data URI** rather than a URL. Depends on core `image`.
Version **2.0.5**. Core requirement `^9 || ^10 || ^11`.

**Where it is genuinely needed:**
- **HTML email** — many clients block remote images by default, so a URL-referenced logo simply
  does not appear;
- **self-contained documents** — exported HTML, single-file archives, PDF pipelines;
- **recipients who cannot reach the site** — a closed preview system, a third party who will not
  fetch from your domain.

**The costs are large and easy to overlook:**
- **~33% size inflation.** A 300 KB photo becomes ~400 KB of text, **inside** the HTML.
- **Not separately cacheable.** The browser cannot reuse it across pages and re-receives it on
  every render of the containing document — where a URL is fetched once and cached for a year.
- It bloats the **render cache entry** holding it.

Right for small images in documents that must be self-contained. Wrong for anything on a web page
a browser will load normally.
