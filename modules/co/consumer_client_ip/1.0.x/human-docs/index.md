# Consumer Client IP — manual setup guide

**Consumer Client IP** (`consumer_client_ip`) solves a narrow but real problem in
decoupled setups: when requests reach Drupal through something that carries the real
visitor's IP in a **non-standard header** — say a serverless function or a CDN that
uses `X-Client-IP`, `CF-Connecting-IP`, or `True-Client-IP` — Drupal's normal
client-IP detection doesn't see it. This module, integrated with the **Consumers**
module, takes the value of a header you nominate and writes it into the standard
`X-Forwarded-For` header on the incoming request, so Drupal's usual reverse-proxy
resolution then reports that value as the client IP. In practice this is what makes
core's **flood control / rate limiting** (and anything else that keys off the
client IP) operate on the real visitor behind such an edge. It depends on the Consumers
module and supports Drupal 10.3 and 11.

For the rewrite to take effect, two pieces of your site setup need to be in place:
the header you map should be one your **proxy or CDN sets**, and your site's
reverse-proxy trust must be configured (`reverse_proxy` and `reverse_proxy_addresses`
in `settings.php`) so that Drupal reads the client IP from `X-Forwarded-For` at all.
The module adds no page or permission of its own; it only remaps a header per consumer.
The project is covered by Drupal's security advisory policy.

Because it configures through the Consumers entity rather than a page of its own,
the setup is covered here under "How to use it".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Consumers dependency.

There is **no dedicated settings page** — configuration happens per consumer (see
"How to use it" below), together with your site's `reverse_proxy` settings.

## Where it lives in the admin menu

Consumer Client IP works through the Consumers module rather than adding a page of
its own. You manage consumers at **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`); the reverse-proxy trust side lives in
`settings.php`.

## How to use it

1. **Decide which header carries the real client IP** at your edge — for example
   `CF-Connecting-IP` (Cloudflare) or `True-Client-IP`. It should be a header your
   proxy/CDN sets on requests it forwards to Drupal.
2. **Enable the mapping for the relevant consumer** and set that header as the
   source, via the Consumers configuration at **Configuration → Web services →
   Consumers**. When enabled for a request's negotiated consumer, the module copies
   the header's value into `X-Forwarded-For`. (If the value is empty the request is
   left unchanged; a literal `0.0.0.0` is treated as "no valid IP" and logged.)
3. **Configure trusted reverse proxies** in `settings.php` — set `reverse_proxy`
   and `reverse_proxy_addresses` to your actual proxy addresses so Drupal reads
   `X-Forwarded-For`. Without this, the rewritten header has no effect.
4. **Verify** that `\Drupal::request()->getClientIp()` (and IP-dependent features
   like flood control) now report the real visitor IP rather than the edge's.
