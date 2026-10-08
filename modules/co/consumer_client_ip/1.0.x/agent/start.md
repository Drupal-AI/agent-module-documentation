<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consumer Client IP — agent index

**Consumer Client IP** (`consumer_client_ip`) — info.yml name "Consumer Client IP",
version **1.0.1**, package Authentication. Core `^10.3 || ^11`. Depends on
`consumers:consumers`. No permissions, routes, config schema, or Drush commands of its
own.

## What it does

Integrates with the **Consumers** module to copy a per-consumer configured HTTP header
into the request's `X-Forwarded-For` header. On each incoming request a kernel
`REQUEST` event subscriber negotiates the request's consumer (via Consumers'
`consumer.negotiator`); if that consumer has header mapping enabled, the subscriber
reads the value of the configured source header (default `X-Client-IP`) and sets it as
`X-Forwarded-For`. Drupal's normal reverse-proxy client-IP resolution then reports that
value from `$request->getClientIp()`. Intended for decoupled setups where the front end
(e.g. a serverless function or CDN) forwards the real visitor IP in a non-standard
header, so core flood control and other IP-keyed logic operate on the visitor's IP.

## Mechanism / structure

- `consumer_client_ip.module`
  - `hook_entity_base_field_info()` adds two base fields to the `consumer` entity:
    `client_ip_header_mapping_enabled` (boolean, default `FALSE`) and
    `client_ip_header_name` (string, default `X-Client-IP`).
  - `hook_form_consumer_form_alter()` groups the two fields under a "Client IP" details
    section inside the consumer form's "Additional Settings" vertical tabs; a validate
    handler (`_consumer_client_ip_consumer_form_validate`) requires the header name when
    mapping is enabled.
- `src/EventSubscriber/KernelEventSubscriber.php` — the `REQUEST` subscriber (priority
  `999999`). Returns early when no consumer is negotiated, mapping is disabled, or the
  source header is absent. If the header value is exactly `0.0.0.0` it logs a critical
  message and skips. Otherwise it sets `X-Forwarded-For` to the header value.
- `consumer_client_ip.services.yml` — registers the subscriber (`@consumer.negotiator`,
  logger) and a `consumer_client_ip` logger channel.

## Configuration

Per consumer at **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`) — enable "Enable Client IP header mapping" and set
"Client IP Source HTTP Header". There is no standalone settings page. For the rewritten
header to affect the resolved client IP, the site's `reverse_proxy` /
`reverse_proxy_addresses` trust settings in `settings.php` must be configured, and the
mapped header should be one set by your proxy/CDN.

## Files

- Header rewrite: `src/EventSubscriber/KernelEventSubscriber.php`
- Fields + consumer form: `consumer_client_ip.module`
- Kernel test: `tests/src/Kernel/ClientIpTest.php`

See `../usage.md` for prose and `../human-docs/` for the manual guide.
