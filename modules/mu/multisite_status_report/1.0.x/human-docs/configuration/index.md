# Configuration

Most of the configuration you need was done for you at install time — a key id, a
shared secret, and a service account were all generated automatically. This page
covers reading those values, rotating the secret, and the smaller options on the
settings form. It also explains the request‑signing contract for whoever writes
the monitoring client.

## Open the settings form

1. Log in as a user with the restricted **administer multisite status report**
   permission.
2. Go to **Configuration → Development → Multisite Status Report**, or navigate
   directly to `/admin/config/development/multisite-status-report`.

## What you can configure

- **Key identifier** — the `key_id` that identifies this site's signing key. Copy
  it and give it to your monitoring client (for example, the Multisite Status
  Dashboard site).
- **Shared secret** — generate or copy the secret here. It is shown **only once**
  when generated, so capture it at that moment. Provide it to the client
  alongside the key id. You can **rotate** the secret from this form whenever you
  need to; update the client with the new value at the same time.
- **Site notes** — free‑text notes that travel with the data, useful for
  identifying which environment a site is (for example "production" vs
  "staging") when you are looking at a fleet.
- **Activation switch** — toggle the endpoints on or off without uninstalling the
  module. Turn it off to temporarily stop responding to polls.

## The three endpoints

All three are read‑only `GET` routes that require both the **access multisite
status report** permission and the module's HMAC authentication provider:

- `/multisite-status-report/status-report` — the full core status report as JSON.
- `/multisite-status-report/modules-updates` — enabled projects, their versions,
  and available‑update info.
- `/multisite-status-report/summary` — a compact summary object for dashboards.

They are marked *no‑cache*, so every poll returns live data.

## How clients sign a request

Whoever builds the monitoring client must sign **every** request. The client
sends four headers — **X‑MSR‑Key**, **X‑MSR‑Timestamp**, **X‑MSR‑Nonce**, and
**X‑MSR‑Signature** — where the signature is an **HMAC‑SHA256** over the canonical
string `METHOD\nPATH\nTIMESTAMP\nNONCE\nSHA256(body)`, keyed with the shared
secret. On each request the server checks that the timestamp is within its
allowed window, that the nonce has not been seen before (a single‑use nonce store
blocks replays), and compares signatures in constant time. Invalid attempts are
throttled per IP. If you use the companion Multisite Status Dashboard module, it
performs exactly this signing for you.

## Keeping the secret safe

The signing secret is the one credential that must not leak:

- **Always serve the endpoints over HTTPS.** HMAC keeps the secret out of the
  URL, but the responses themselves carry sensitive site information.
- For production, consider **overriding the secret in `settings.php`** and
  **excluding it from configuration exports** — Config Ignore or Config Split are
  the usual tools — so the per‑environment secret never lands in shared config or
  version control.
- Grant **access multisite status report** to the dedicated **service account**
  only (the one created at install), not to real users, and keep both of the
  module's permissions restricted to administrators.
