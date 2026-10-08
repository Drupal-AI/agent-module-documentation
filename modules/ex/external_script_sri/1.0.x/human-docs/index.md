# External Script SRI — manual setup guide

**External Script SRI** (`external_script_sri`) hardens the third-party JavaScript
your site loads by attaching **Subresource Integrity** (`integrity`) hashes and
the `crossorigin` attribute to external scripts. With an integrity hash in place,
the browser compares the file it downloads against the hash you supplied and
**refuses to run it if the contents have changed** — so a tampered or unexpectedly
updated script simply doesn't execute.

The problem it solves is a real one. Every externally hosted script — a CDN
library, a widget, an analytics snippet — is a standing grant of execution rights
to whoever controls that URL. A CDN compromise, a hijacked host, a DNS takeover,
or even a maintainer quietly republishing a new build under the same path all
result in your visitors running code you never reviewed, with no way to notice.
SRI is the web platform's answer, and this module gives site administrators a
place to manage it without touching a theme or writing code.

You use it through a table-based settings form: add each external script's URL,
paste in its SRI hash (there are free generators such as `srihash.org`, linked
from the form's own help text), set the `crossorigin` value, and optionally flag a
library as *sensitive* to mark it for extra scrutiny. It's aimed at sites with
security or compliance requirements, payment pages, or anyone who wants to review
third-party script changes deliberately rather than have them slip in unnoticed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add each external script with its
   hash and `crossorigin` value.

## Where it lives in the admin menu

The configuration form is at **Configuration → System → External Script SRI**
(`/admin/config/system/sri-configuration`), behind a restricted **Administer
External Script SRI** permission — grant it only to trusted administrators, since
the scripts listed here run on your site's pages.
