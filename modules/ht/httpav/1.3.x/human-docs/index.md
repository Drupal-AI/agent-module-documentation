# HTTP Anti-virus — manual setup guide

**HTTP Anti-virus** (`httpav`) adds malware scanning to Drupal's file‑upload
pipeline. When a user uploads a file, the module submits that file to an HTTP
endpoint you configure — a virus‑scanning service — and uses the service's reply
to decide whether Drupal accepts the file. If the scanner reports the file as
infected, the upload fails validation and the file is not stored.

The clever part is the transport: instead of talking to a scanning backend over
its native TCP/socket protocol, `httpav` wraps everything in a plain HTTP
interface. That means you can put a small HTTP shim in front of ClamAV, or use a
SaaS scanner that already speaks HTTP, and integrate it as a self‑contained
microservice rather than bolting an antivirus daemon onto your web server.

The module makes some assumptions about the request and response so that a range
of services can be accommodated. It POSTs the file as `multipart/form-data`, and
it expects the service to reply with JSON containing a `result` object with an
`infected` boolean — when `infected` is `true`, the file is rejected. Parts of
the request are configurable so you can adapt to your particular endpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

To put HTTP Anti-virus to work you need two things in place:

1. **A scanning service reachable over HTTP.** This is a prerequisite the module
   does not provide — for example a containerised ClamAV HTTP shim or a hosted
   scanning API. It must accept a file as `multipart/form-data` and return the
   `{"result": {"infected": true|false, ...}}` JSON the module expects.
2. **The module pointed at that service**, telling it the endpoint URL and how
   the request should be shaped so uploaded files are sent there for a verdict.

A few security points are worth getting right:

- **Use TLS (HTTPS) for the endpoint.** Uploaded files and their verdicts travel
  the network, so point `httpav` at a scanning endpoint over HTTPS. (The module
  does **not** disable TLS certificate verification, which is the correct
  behaviour.)
- **Decide what happens when the scanner is unreachable.** For security, prefer
  to *fail closed* — block uploads when the scanner cannot be reached — rather
  than silently accepting unscanned files.
- **Treat scanning as one layer, not a guarantee.** Antivirus scanning reduces
  risk but does not eliminate it; keep your other upload hardening in place.
