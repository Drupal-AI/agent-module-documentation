<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Content Parser (Postlight Parser) — agent index

**Extracts article content/metadata from any URL** (Postlight/Mercury/Readability). Depends on core `link`. Version
**1.0.2**. Core `^9||^10||^11||^12`.

**SECURITY (campaign finding, Danger 4)** — `/parser/{parser}?url=` is gated only by **`access content`**
(anonymous); the `readability` parser fetches the **client-supplied URL** server-side (`file_get_contents`/`curl` +
`FOLLOWLOCATION`, no validation) and **returns the content** → unauthenticated **read-SSRF** (internal services /
cloud-metadata credential theft) + **`file://` local file read**. Don't expose publicly until the route is
permissioned and the URL validated/allowlisted (http/https only, block private ranges, re-check redirects).
