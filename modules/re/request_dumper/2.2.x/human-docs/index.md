# Request Dumper — manual setup guide (2.2.x)

**Request Dumper** (`request_dumper`) is a **developer/debugging tool** for
capturing incoming HTTP requests — especially API calls and webhooks whose
payloads are otherwise hard to see. It registers an HTTP middleware that, **only
when you explicitly enable dumping**, writes each matching request's **body** and
**headers** to timestamped files in a **non-public** part of the filesystem, where
you can open and inspect them.

This is the **2.2.x** release, which supports **Drupal 9 and 10**
(`core_version_requirement: ^9.0 || ^10.0`). If you are on Drupal 11, use the
`3.0.x` release instead.

Dumping is turned on from an admin form and works in two modes:

- **Timed:** enable capture for a fixed duration (60 seconds to 30 minutes),
  optionally restricted to specific HTTP methods and a path prefix (for example
  `/jsonapi/node/`).
- **Always-on URL:** generate a random-token endpoint at
  `/request-dumper/always/{token}` — meant for pointing a third-party webhook at.
  It returns `{"result":"success"}` and dumps whatever is posted to it.

The tool is designed to be safe: dumping is **off by default**, enabling it
requires the **Administer site configuration** permission, dump files go to a
**non-public** stream wrapper (the `public` scheme is deliberately excluded so
dumps are never web-served), and the always-on URL is protected by a random token
compared in constant time.

That said, **captured request data is inherently sensitive** — bodies and headers
can contain cookies, `Authorization` tokens, and other PII. Keep this a
development/debugging tool, restrict who can enable it, clean up the files when
you're done, and don't leave dumping running longer than you need.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the enable form, timed vs. always-on
   dumping, file location, and cleanup.

## Where it lives in the admin menu

Request Dumper's form sits at **Configuration → Development → Request Dumper**
(`/admin/config/development/request-dumper`), behind the **Administer site
configuration** permission.
