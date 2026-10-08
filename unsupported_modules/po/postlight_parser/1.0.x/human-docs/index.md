# Link Content Parser (Postlight Parser) — manual setup guide

**Link Content Parser** (`postlight_parser`) extracts the readable content of a web page from
a URL you give it — returning the article body, title, author, date, excerpt, and lead image.
It can use the Postlight/Mercury parser (if you install it) or a built‑in PHP **Readability**
parser, and it exposes the result through a link‑field widget and an optional CKEditor 5
button, so an editor can pull an article's content into a node from just a link.

> **Important — this module is unsupported.** Its security coverage has been revoked because a
> reported security issue was not fixed by the maintainer, and there is no further development.
> Before using it, strongly consider an actively maintained alternative. If you must use it,
> read the security warning below and do **not** expose its endpoint to untrusted users.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and, optionally, a parser
   backend) with Composer and enable it.

There is no central settings form; configuration happens per link field and per text format,
described under "How to use it" below.

## Security warning — read before enabling

The parser route `/parser/{parser}?url=…` is gated only by the **"Access content"**
permission, which on a typical site is granted to **anonymous** visitors. For the built‑in
`readability` parser, the module fetches the **URL supplied in the request** on the server —
with no validation, following redirects — and returns the fetched content in its response.

That makes it an **unauthenticated server‑side request forgery (SSRF)** and local‑file‑read
risk: an anonymous attacker can point it at your internal services or a cloud metadata endpoint
(for example `?url=http://169.254.169.254/…`, which can expose cloud credentials) or read local
files (for example `?url=file:///etc/passwd`) and read back the response. It is also an
outbound‑traffic (egress) concern, since your server fetches arbitrary attacker‑chosen URLs.

Until this is fixed, **do not expose the endpoint to untrusted users**. At minimum, require a
real, non‑anonymous permission on the route and validate/allowlist the URL — permit only
`http`/`https`, block private and link‑local address ranges and non‑HTTP wrappers, and re‑check
the target after any redirect.

## How to use it

1. Add a **Link** field to your content type (or use an existing one).
2. In the field's **form display**, choose the **Postlight parser** widget (PHP Readability is
   the default backend).
3. **Map** the parser's output (title, content, excerpt, lead image, and so on) to the fields
   that should receive the extracted content.
4. Optionally add the **"Url get Content"** button to a text format's **CKEditor 5** toolbar so
   editors can fetch content while writing.
5. Optional behaviours include **saving images inline** — extracted images are copied to
   `public://inline-images` (or stored as base64) — and enabling `iframe`/`blockquote` tags in
   CKEditor 5 if you want to embed media such as YouTube, Dailymotion, or TikTok.

Developers can also call the `postlight_parser.url_parser` service directly to fetch and parse a
URL from custom code.
