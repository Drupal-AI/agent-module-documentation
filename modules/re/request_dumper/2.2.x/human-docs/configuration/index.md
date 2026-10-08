# Configuration

Request Dumper is controlled from a single admin form. Dumping is **off by
default** — nothing is written until you submit the form to start a timed capture
or enable the always-on URL.

## Open the form

Log in as a user with the **Administer site configuration** permission and go to
**Configuration → Development → Request Dumper**
(`/admin/config/development/request-dumper`).

## The two ways to capture

### Timed capture

Choose a **duration** (from 60 seconds up to 30 minutes) and submit. For that
window, matching requests are dumped to files, then capture automatically stops.
You can narrow what is captured with:

- **HTTP methods** — restrict to specific methods (for example only POST/PATCH)
  so you don't capture every GET.
- **Path prefix** — an optional prefix such as `/jsonapi/node/` so only requests
  under that path are dumped.

Timing out automatically is the safe default — it means a forgotten capture won't
keep writing sensitive data indefinitely.

### Always-on URL (for webhooks)

Enable the always-on option to generate a random-token endpoint at
`/request-dumper/always/{token}`. Point a third-party webhook at that URL; every
request it receives is dumped, and the endpoint responds with
`{"result":"success"}`. The token is a random base64 value stored in state, and
the route checks it with a constant-time comparison, so the endpoint is not
guessable. Because it dumps unconditionally, disable it as soon as you've finished
capturing.

## Where the dumps go

- **Dump file location** — pick any writeable **non-public** stream wrapper. The
  default is the temporary stream (`temporary://`). The **`public`** scheme is
  deliberately excluded from the options so dumps can never be served over the web.
- Each captured request produces two timestamped files: one with the request
  **body/content** and one with the **headers** (which include cookies and any
  `Authorization` header).

## Cleaning up

Use the **Cleanup existing files** option on the form to delete previously
captured dumps. Because dump files contain sensitive request data, clear them once
you've finished debugging and turn dumping back off.

## Safety notes

- Enabling capture requires **Administer site configuration** — keep that
  permission limited to trusted administrators.
- Dumps contain **sensitive data** (headers, cookies, tokens, request bodies).
  Store them only in a non-public location (the module enforces this), and delete
  them when done.
- Prefer **timed** captures so logging auto-stops; use the always-on URL only for
  as long as you need it.
