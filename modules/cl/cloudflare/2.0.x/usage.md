<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare integrates a Drupal site with the Cloudflare CDN: it authenticates against the Cloudflare API, restores each visitor's real IP address (which Cloudflare proxies away), and — via its cloudflarepurger submodule — clears the Cloudflare cache by tag, URL, or the whole zone.

---

The base module handles two concerns. **(1) API connection:** settings live in `cloudflare.settings` and are edited through a CTools wizard at `/admin/config/services/cloudflare` (configure route `cloudflare.admin_settings_form`, permission `administer cloudflare`). You authenticate either with an **API token** (`auth_using: token`, `api_token`, sent as `Authorization: Bearer …`) or the legacy **API key + email** (`auth_using: key`, `apikey` + `email`, sent as `X-Auth-Key`/`X-Auth-Email`); the chosen zone(s) are stored in `zones`, and `valid_credentials` records whether a credential check passed. The `cloudflare.api_client` service (`CloudflareApiClient`) talks to the API and `cloudflare.state` tracks API rate-limit / daily-purge counters in State. **(2) Client IP restoration:** an HTTP middleware (`http_middleware.cloudflare`, `CloudFlareMiddleware`, priority 600) reads Cloudflare's `CF-Connecting-IP` / `CF-Visitor` request headers and rewrites the request's client IP to the original visitor, gated by `client_ip_restore_enabled`; `remote_addr_validate` makes it verify the incoming IP is a real Cloudflare edge IP, and `bypass_host` names an origin hostname that legitimately bypasses Cloudflare (suppressing false warnings). Actual cache **purging** is not in this module — it ships in the `cloudflarepurger` submodule (a Purge purger plugin), which requires the Purge module. Requires CTools. Store credentials as environment/Key values rather than committing them.

---

- Connect a Drupal site to a Cloudflare zone via API token authentication.
- Use legacy API key + email authentication where a token isn't available.
- Restore visitors' real IP addresses behind the Cloudflare proxy for logging and geolocation.
- Validate that incoming requests actually come from Cloudflare edge IPs.
- Set a bypass host so direct-to-origin requests don't log false Cloudflare warnings.
- Select which Cloudflare zone(s) the site uses.
- Record whether stored Cloudflare credentials are valid.
- Provide the API client other modules use to call Cloudflare.
- Track Cloudflare API rate-limit usage in Drupal State.
- Feed correct client IPs to flood control, rate limiting, and analytics.
- Ensure `hook_` consumers and Views see the real visitor IP, not Cloudflare's.
- Prepare a site for CDN cache purging by pairing with the cloudflarepurger submodule.
- Manage Cloudflare settings through an admin wizard UI.
- Restrict Cloudflare configuration to trusted admins via a dedicated permission.
- Switch authentication method (token vs key) per environment via config.
- Deploy Cloudflare settings as configuration across environments.
- Keep API credentials out of code using environment variables / Key entities.
- Support multi-zone setups where the site spans several Cloudflare zones.
- Diagnose credential problems before attempting purges.
- Serve as the foundation for cache-tag-header generation used by purging.
- Integrate a reverse-proxy/CDN layer with Drupal's cache system.
- Correctly attribute security events to the originating visitor IP.
