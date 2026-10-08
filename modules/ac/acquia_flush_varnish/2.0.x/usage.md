Purge the Acquia Cloud Varnish (and Platform CDN) edge cache for a hosted site's domain from the Drupal admin, via the Acquia Cloud API.

---

Acquia Flush Varnish adds a single admin action — a "Clear varnish cache" menu link under Configuration → Development — that authenticates to the Acquia Cloud API with a stored API key/secret, resolves the current site's environment and domain, and triggers Acquia's `clear-caches` action so the edge Varnish and (if enabled) Platform CDN cache for that domain are flushed. It only works on Acquia Cloud / Site Factory hosted sites, where the platform sets the `AH_SITE_ENVIRONMENT`, `AH_APPLICATION_UUID`, and `HTTP_HOST` environment variables that the module reads. Credentials are expected to be supplied out-of-repo (via `secrets.settings.php` overriding `acquia_flush_varnish.settings`), never committed. The bundled `AcquiaCloudUtility` service is also reusable from custom code to call arbitrary Acquia Cloud API endpoints with an OAuth client-credentials access token.

---

- Manually flush the Acquia Varnish edge cache for the current environment's domain after a content or config deployment.
- Give editors/admins a one-click "Clear varnish cache" link instead of asking DevOps to purge via the Acquia Cloud UI.
- Clear the Platform CDN cache (when Platform CDN is enabled) alongside Varnish in the same action.
- Purge stale cached pages immediately after a hotfix so visitors see the corrected content.
- Bust the edge cache after changing site-wide theming or menu structure that pages have already cached.
- Force fresh delivery of a landing page ahead of a marketing launch or campaign go-live.
- Reduce the wait for TTL-based cache expiry during active development or QA on an Acquia environment.
- Scope the purge to the site's own domain (environment + domain resolved from Acquia env vars), avoiding a full-app cache wipe.
- Restrict who can purge by granting only the "Clear varnish cache" permission to trusted roles.
- Trigger the purge from a bookmarked admin path (`/admin/config/development/flush-all-cache`) as part of a release checklist.
- Verify a cache issue is edge-side (Varnish/CDN) rather than Drupal-side by purging and re-testing.
- Integrate Acquia Cloud API access into a custom module by injecting the `acquia_flush_varnish.cloudutility` service.
- Obtain a short-lived Acquia Cloud OAuth access token via `getaccesstoken()` for custom API calls.
- Call any Acquia Cloud API endpoint (GET or POST) from custom code with `getAcquiaApi($url, $token, $method, $data)`.
- List an application's environments programmatically through the Acquia Cloud `applications/{uuid}/environments` endpoint.
- Automate domain-level cache clears from custom workflows that reuse the utility service.
- Keep API credentials out of the codebase and database by loading them from `secrets.settings.php` on the Acquia server.
- Support both Acquia Cloud and Acquia Site Factory hosting models with the same module.
- Run on Drupal 9, 10, or 11 sites hosted on Acquia.
- Provide a lightweight alternative to configuring the full Purge/Acquia Purge stack when only manual, on-demand domain purges are needed.
- Confirm a purge succeeded via the status message returned from the Acquia Cloud API response.
