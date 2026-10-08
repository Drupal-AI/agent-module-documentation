<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consumer Client IP maps a configurable HTTP client-IP header to the X-Forwarded-For header, per consumer.

---

Consumer Client IP **remaps a configurable HTTP header into `X-Forwarded-For`**, on a
per-consumer basis. On each request a kernel event subscriber negotiates the request's
consumer (through the Consumers module) and, if header mapping is enabled for that
consumer, reads the value of an admin-chosen source header (default `X-Client-IP`, or
another your edge uses such as `CF-Connecting-IP` or `True-Client-IP`) and writes it
into the request's `X-Forwarded-For` header. Drupal's normal reverse-proxy client-IP
resolution then reports that value as the client IP (from `$request->getClientIp()`).
It depends on the Consumers module.

Use it in decoupled deployments where the real client does not connect to Drupal
directly — the front end (a serverless function, a Next.js app, a CDN) connects
instead and forwards the real visitor IP in a non-standard header. Mapping that header
into `X-Forwarded-For` lets IP-dependent features such as core flood control operate on
the visitor's IP rather than the front end's. For the rewrite to take effect, the mapped
header should be one your proxy/CDN sets, and the site's reverse-proxy trust settings
(`reverse_proxy` and `reverse_proxy_addresses` in `settings.php`) must be configured so
Drupal reads the client IP from `X-Forwarded-For`. Configuration is done in the consumer
settings form (Configuration → Web services → Consumers): the mapping toggle and the
source header name. The module adds no page or permission of its own.

---

- Remap a chosen HTTP header into `X-Forwarded-For`.
- Read an admin-chosen source header per request.
- Operate per consumer, via the Consumers module's negotiation.
- Feed Drupal's reverse-proxy client-IP resolution.
- Default the source header to `X-Client-IP`.
- Skip the rewrite when mapping is disabled or the header is absent.
- Log a critical message and skip when the header value is exactly `0.0.0.0`.
- Require the source header name when mapping is enabled (form validation).
- Depend on the Consumers module.
- Serve decoupled / proxy / CDN client-IP integration.
- Rely on `reverse_proxy` + `reverse_proxy_addresses` trust settings to take effect.
- Configure through the consumer settings form.
- Add no page or permission of its own.
