# HTTP-Headers cleaner — manual setup guide

**HTTP-Headers cleaner** (`http_headers_cleaner`) does the opposite of adding
security headers: it **removes** HTTP response headers and HTML meta tags you don't
want to expose. Its purpose is to reduce information disclosure and fingerprinting —
stripping the signals that tell an attacker (or a scanner) which software and
version your site runs, such as the `X-Generator` header or the generator meta tag.

You define, in the module's settings, exactly which headers and meta tags to remove,
using pattern rules. A response subscriber removes matching headers as responses go
out, and a meta cleaner removes matching meta tags from the HTML. You can strip a
header entirely, or use patterns to remove only certain matching elements within a
header (for example only some of the `Link` header's relations).

Keep the module's scope in mind: it is the **"reduce disclosure" half** of header
hardening, not the "add protections" half. It only removes things — it does not add
security headers like CSP or X-Frame-Options. So configure it to strip only
*informational* headers; do **not** target genuine security headers, since removing
those would weaken your site. If you also need to *add* protective headers, pair this
with a module that does that (for example
[HTTP Headers](https://www.drupal.org/project/http_headers) or Seckit).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the header and meta-tag removal rules,
   with examples.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → HTTP-Headers cleaner settings**.
