<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trusted Proxy Headers Debug is a diagnostic that shows how Drupal is currently interpreting reverse-proxy headers, to help set up and verify the `reverse_proxy` and trusted-header settings correctly.

---

Getting trusted-proxy configuration right matters and is easy to get wrong, and both failure modes are dangerous. If Drupal does not trust the proxy, every request appears to come from the proxy's IP — breaking flood control, IP-based access rules and logging. If Drupal trusts proxy headers it should not, a client can spoof `X-Forwarded-For` and defeat exactly those controls. The settings that govern this (`$settings['reverse_proxy']`, `reverse_proxy_addresses`, the trusted header set) are in `settings.php`, and their effect is invisible until something behaves oddly in production.

This module makes the effect visible. It adds a status-report page, `/admin/reports/status/trusted_proxy_headers_debug`, that shows what Drupal is deriving from the incoming headers — the client IP it resolves, which headers it is honouring — so you can confirm the configuration does what you intended before relying on it.

Two things follow from what it displays. It is a **setup and verification tool**, best enabled while configuring proxy trust and then turned off — it is not something a production site needs running continuously. And because the page reveals how the site interprets request headers, its route should be restricted to administrators; that information is useful to an attacker probing whether header spoofing is possible. Confirm the access requirement before exposing it on a shared environment.

---

- Verify trusted-proxy configuration.
- See the client IP Drupal resolves.
- Check which forwarded headers are honoured.
- Debug reverse-proxy setup.
- Confirm X-Forwarded-For handling.
- Catch a proxy Drupal does not trust.
- Catch headers trusted that should not be.
- Set up reverse_proxy settings safely.
- Test proxy trust before production.
- Diagnose broken flood control behind a proxy.
- Diagnose IP-based access issues behind a proxy.
- Validate a CDN or load-balancer setup.
- Restrict the debug page to admins.
- Turn it off after configuring.
- Understand header interpretation.
- Check settings.php proxy config takes effect.
- Prevent header spoofing misconfiguration.
- Verify logging shows real client IPs.
- Confirm the access requirement before exposing.
- Use it as a setup tool, not a permanent feature.