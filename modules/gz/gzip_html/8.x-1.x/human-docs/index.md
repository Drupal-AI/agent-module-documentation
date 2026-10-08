# Gzip Html output — manual setup guide

**Gzip Html output** (`gzip_html`) compresses the rendered HTML of your pages
with gzip before it is sent to the browser. Smaller responses mean less
bandwidth used and faster page loads for your visitors.

Normally HTML compression is handled by the web server (Apache's mod_deflate,
nginx's gzip directive) or by a CDN in front of the site. This module exists for
the cases where you *can't* do that — some hosting platforms don't support or
don't allow server-level gzip. Platform.sh, for example, does not compress
responses at the app-container level, so a Drupal module has to do the job
instead. On a normal server that already compresses output, you don't need this
module.

A couple of things to know before you turn it on. This module **does not work
with core's BigPipe module enabled** — BigPipe streams a page in pieces, which is
incompatible with compressing the whole HTML response, so choose one or the
other. And there is a niche security consideration common to all HTTP
compression: compressing a response that mixes a secret (such as a CSRF token or
session-derived data) with attacker-influenced reflected input can, in specific
setups, enable a compression side-channel attack (BREACH). For ordinary public
HTML this is not a concern; it's simply worth a thought before compressing highly
sensitive, dynamic, user-reflecting responses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn compression on from the core
   Performance settings page.

## Where it lives in the admin menu

Gzip Html output doesn't add a settings page of its own. You switch it on from
core's **Configuration → Development → Performance** page
(`/admin/config/development/performance`) — see
[Configuration](configuration/index.md).
