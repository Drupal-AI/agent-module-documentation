<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Consumer is a generic REST client for Drupal, providing configurable outbound requests to consume external REST APIs.

---

Integrations often need to call an external REST API from Drupal. REST Consumer provides a generic, configurable client for that. The security-relevant consideration is server-side request forgery and credential handling: the module makes the Drupal server issue outbound HTTP requests to configured endpoints, so if any request URL is built from user-controlled input, that is an SSRF surface (an attacker could steer the server to internal services) — keep endpoint URLs static/admin-configured and allow-list destinations where dynamic. And any API credentials for the consumed services are secrets to keep out of plain config. Also ensure outbound requests use TLS with verification (do not disable certificate checks). Configure the endpoints and credentials carefully, and treat any user-derived request parameters as an SSRF risk.

---

- Consume an external REST API.
- Make configurable outbound requests.
- Call a third-party API.
- Provide a generic REST client.
- Keep endpoint URLs static.
- Guard against SSRF.
- Allow-list dynamic destinations.
- Keep API credentials secure.
- Use TLS with verification.
- Avoid user-controlled request URLs.
- Integrate via REST.
- Treat user-derived params as SSRF.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.