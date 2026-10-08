consentmanager Analytics is a consent_manager submodule that injects the consentmanager.net privacy-friendly ("trackless") analytics script into the bottom of every non-admin page.

---

The submodule defines the `analytics` consent_manager plugin (`Analytics`, `has_block: FALSE`) with the code template `<script src="https://@host/trackless/delivery/@codeid.js" async ...></script>`. Its settings form (`consent_manager_analytics.settings` at `/admin/config/consent-manager/analytics`, permission `administer consent manager settings`) collects a required `codeid` and an optional `host` (default `delivery.consentmanager.net`, validated as a hostname). `consent_manager_analytics_preprocess_html()` renders the code into `page_bottom` on every non-admin route, with cache tag `consent_manager_analytics`; the script is emitted only when a Code-ID is set. On install it sets `consent_manager_cmp` module weight to 100 so the analytics code loads relative to the banner. Configuration is only editable behind the restricted admin permission.

---

- Add consentmanager.net privacy-friendly analytics to a Drupal site.
- Track visitor usage without setting tracking cookies ("trackless").
- Configure analytics with a consentmanager.net Code-ID.
- Point the analytics script at a custom consentmanager delivery host.
- Load the analytics snippet at the bottom of every front-end page.
- Keep analytics off admin routes.
- Gather usage insights while respecting GDPR/CCPA consent.
- Auto-fill the Code-ID/host via the "Install now" onboarding popup.
- Cache the analytics output and invalidate it on settings change.
- Restrict analytics configuration to trusted administrators.
- Combine privacy-friendly analytics with the consentmanager cookie banner.
- Measure page views without third-party tracking cookies.
- Serve the analytics script asynchronously so it does not block rendering.
- Enable analytics only when a valid Code-ID is configured.
- Use a region-specific consentmanager host for the analytics endpoint.
- Provide consent-aware analytics that integrate with the wider consentmanager account.
