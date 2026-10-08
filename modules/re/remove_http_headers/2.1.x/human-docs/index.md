# Remove HTTP Headers — manual setup guide

**Remove HTTP Headers** (`remove_http_headers`) strips a list of HTTP response
headers you choose from every page your site serves, so the site gives away less
about the software running behind it. Out of the box it removes three headers
that reveal Drupal's presence and caching behavior — `X-Generator`,
`X-Drupal-Dynamic-Cache`, and `X-Drupal-Cache` — and you can add or remove any
header name from the list.

This is a small, focused security‑hardening module. Headers like `X-Generator`
announce "Drupal", which makes a site easier for automated scanners to
fingerprint and target; removing them is a common recommendation on security
audits and penetration tests. As a bonus, when you strip `X-Generator` the module
also removes Drupal's default `<meta name="Generator">` tag from the page's HTML,
so the version hint is gone from the markup too, not just the headers.

Under the hood it uses an HTTP middleware that runs late in the response cycle
(after the page cache), so even cached responses are cleaned. It works on main
requests only, leaving internal subrequests untouched, and it needs nothing
beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the list of headers to remove and
   the permission that guards it.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Remove HTTP headers settings**
(`/admin/config/system/remove-http-headers`), gated by the **Remove HTTP headers
settings access** permission.

## How to use it

1. Enable the module — the three default headers are removed immediately.
2. Open the settings form and edit the list if you want to add other headers
   (for example `X-Powered-By`) or keep only some of the defaults.
3. Save. The change takes effect on the next response.

See [Configuration](configuration/index.md) for the details.
