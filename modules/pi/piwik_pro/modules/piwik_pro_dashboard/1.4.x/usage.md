Piwik Pro Dashboard is a submodule of Piwik PRO that renders an in-admin analytics dashboard (visitors, page views, returning-visitor and bounce rates, trends over time, top pages, and device breakdown) by calling the Piwik PRO Analytics API with OAuth client-credentials, with the client secret stored via the Key module.

---

The dashboard page at `/admin/reports/piwik-dashboard` (`DashboardController`) loads a React app
that fetches data from three JSON API routes — `/api/piwik-dashboard/overview`, `/devices`, and
`/top-pages` (all `ApiController`, gated by the `access piwik pro dashboard` permission). Those
controllers use `PiwikApiClient`, which authenticates through `AccessTokenManager`:
it reads `client_id` and a **Key ID** (`client_secret`) from `piwik_pro_dashboard.settings`,
loads the referenced **Key entity** to get the real secret, POSTs a `client_credentials` grant to
`https://<client>.piwik.pro/auth/token`, and caches the resulting access token (in the default
cache bin) until just before it expires. The `<client>` host is derived from the base module's
`piwik_domain` via `ClientNameHelper`, and the date range is selectable (last 7 or 30 days,
`DateRange` enum). Configuration lives at `/admin/config/services/piwik-pro/dashboard`
(`SettingsForm`, permission `administer piwik pro dashboard`, `restrict access: TRUE`): you enter
the Client ID and **select a Key** (from Key module) that holds the client secret — the form
deliberately stores a key reference, not the secret itself, and warns against putting the secret
in config. Requires the base `piwik_pro` module (configured) and the `key` module.

---

- View site visitor and page-view totals inside the Drupal admin.
- Track returning-visitor rate and bounce rate without leaving Drupal.
- See visitors and page views trended over time on a chart.
- Review the top pages by traffic for the last 7 or 30 days.
- Break down traffic by device type (desktop/mobile/tablet).
- Give editors read access to analytics via a dedicated dashboard permission.
- Keep the Piwik PRO client secret in the Key module instead of config.
- Reference an env-var or file-based key for the API secret (via Key providers).
- Authenticate to the Piwik PRO Analytics API with OAuth client credentials.
- Reuse the base module's tracking domain to target the right Piwik PRO account.
- Toggle the reporting window between last 7 and last 30 days.
- Cache the API access token to avoid re-authenticating on every request.
- Expose analytics JSON endpoints for a custom front-end or widget.
- Restrict who can change API credentials with a restricted admin permission.
- Surface key metrics to stakeholders without Piwik PRO platform logins.
- Consolidate analytics viewing and Drupal administration in one place.
- Provide a quick health-check of traffic after a deployment.
- Monitor device-mix shifts over a reporting period.
- Let a marketing role view stats while an admin manages credentials.
- Add analytics reporting to an existing Piwik PRO tracking setup.
