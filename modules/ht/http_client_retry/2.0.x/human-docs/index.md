# HTTP Client Retry — manual setup guide

**HTTP Client Retry** (`http_client_retry`) makes your site's outbound HTTP calls
more resilient. It adds a **retry middleware** to Drupal's core HTTP client so that
requests which fail transiently — a 5xx server error, a timeout, a passing network
blip — are automatically retried instead of failing on the first attempt. That
turns a lot of intermittent integration failures into calls that just quietly
succeed on the second or third try.

You control which response status codes trigger a retry, how many times to retry,
and the backoff between attempts, all from a settings form. Each time a request is
retried the module dispatches an event (`http_client_retry.request.retry`), which is
how the module does its optional retry logging and how your own code can react to
retries if you need to.

Retries can also be controlled **per request** in custom code: you can leave global
retries disabled and opt individual requests in by passing `['retry_enabled' =>
TRUE]` to the client, or otherwise pass Guzzle retry options on a single request.

Two things to keep in mind. First, retrying re-sends the request — that is perfectly
safe for idempotent calls (GET and the like) but you should be careful with
non-idempotent POSTs that would cause duplicate side effects. Second, tune the retry
count and backoff sensibly: too many retries can pile load onto an already-struggling
dependency and delay the moment a real error surfaces. Note that retrying does **not**
change TLS or verification behavior — retries reuse the same request options.

> **Project status:** at the time of writing this module is marked *Unsupported /
> No further development* on drupal.org. It still works on the listed core versions,
> but factor that into your decision to adopt it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its
   required library) and enable the module.
2. [Configuration](configuration/index.md) — the retry settings form, field by
   field, plus per-request control.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → HTTP Client Retry**
(`/admin/config/system/http_client_retry`).
