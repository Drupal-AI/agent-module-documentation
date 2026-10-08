<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Content Parser extracts article content and metadata from any URL.

---

Link Content Parser (postlight_parser) **extracts the readable content from a URL** — given a URL it returns
the article content, title, author, date, excerpt and lead image (via the Postlight/Mercury parser or a local
Readability parser), usable from a CKEditor 5 plugin/field to import article content. It depends on core Link.

Use it to import article content from links. It has a **serious unauthenticated SSRF/local-file-read flaw** you must
address before exposing it (recorded as a campaign security finding). The parser route `parser/{parser}` is gated
only by **`_permission: 'access content'`** (anonymous on typical sites); the controller reads a **client-supplied
`url` query parameter with no validation**, and for the built-in **`readability`** parser (selectable via the path
segment, so an attacker can force it regardless of any configured external Mercury endpoint) `UrlParserService`
fetches that URL **server-side** with `file_get_contents($url)` / `curl_init($url)` + `CURLOPT_FOLLOWLOCATION`, then
returns the fetched content in the JSON response. So an anonymous attacker can point it at **internal services or
cloud metadata** (`?url=http://169.254.169.254/…` → credential theft; redirects are followed) and read the response,
or read **local files** via `?url=file:///etc/passwd` (through `file_get_contents`'s `file://` wrapper). Until fixed,
**do not expose this endpoint to untrusted users** — require a real permission, and validate/allowlist the URL
(http/https only, block private/link-local ranges and non-http wrappers, re-check after redirects). It has no
access-control role. Configure the parser (and lock down the endpoint).

---

- Extract article content/metadata from a URL.
- Return title/author/date/excerpt/image.
- Import content from links (CKEditor/field).
- Depend on core Link.
- Serve content import.
- Parse via Postlight/Mercury/Readability.
- EXPOSE /parser/{parser}?url= gated only by 'access content' (anonymous).
- FETCH the client-supplied URL server-side (file_get_contents/curl + FOLLOWLOCATION) with NO validation, returning the content.
- ALLOW unauthenticated read-SSRF (internal services / cloud-metadata credential theft) + file:// local file read.
- NOT be exposed to untrusted users until fixed (require a real permission + validate/allowlist the URL).
- Validate http/https only + block private/link-local ranges + re-check after redirects.
- Configure the parser and lock down the endpoint.
- Handle URL parsing.
- Parse URLs.
- Configure the parser.
- Extract content.
- Handle the fetch.
- Import articles.
- Restrict the endpoint.
- Provide (unsafe) URL parsing.
