Adds an OAuth 1.0a two-legged authentication provider to Drupal so external clients can authenticate to the site by signing each request with a per-user consumer key/secret pair.

---

The OAuth module registers a Drupal authentication provider (`authentication.oauth`, priority 100) that inspects the `Authorization: OAuth ...` header on incoming requests and validates the OAuth 1.0a signature using the PHP **PECL OAuth extension** (`OAuthProvider`). It operates in two-legged mode (`is2LeggedEndpoint(TRUE)`): there is no interactive user-authorization redirect flow — a client is identified purely by a consumer key/secret it was issued. Consumer credentials are generated per user and stored in Drupal's `users_data` store; each user can manage their own consumers at `/user/{user}/oauth/consumer`, and administrators can manage anyone's. A replay-protection nonce table (`oauth_nonce`) records seen nonces, and `hook_cron()` purges nonces older than 24 hours. A page-cache request policy prevents OAuth-authenticated responses from ever entering the page cache. This is a compatibility building block for other web-service modules that must speak OAuth 1.0a; new integrations should generally prefer OAuth 2.0 (`simple_oauth`). The module has no runtime PHP dependency other than core `system`, but it will not function unless the PECL `oauth` extension is installed (enforced by `hook_requirements()`).

---

- Authenticate REST / decoupled API requests to a Drupal site using OAuth 1.0a signed requests.
- Provide server-side OAuth 1.0a support for legacy or enterprise clients that mandate 1.0a rather than 2.0.
- Issue a per-user consumer key + consumer secret pair for machine-to-machine (two-legged) API access.
- Let end users self-service their own API credentials from their user profile's "OAuth Consumers" tab.
- Let administrators (permission `administer consumers`) provision or revoke consumer credentials on behalf of any user.
- Add a signature-based authentication layer on top of custom routes exposed via Drupal's authentication provider system.
- Protect an API endpoint against request replay via the built-in nonce store.
- Serve as the authentication backend that other contrib modules build OAuth 1.0a integrations on.
- Integrate a Drupal site with an external platform whose SDK signs outbound calls with OAuth 1.0a credentials.
- Grant a mobile app a stable, per-user credential set to call back into the site.
- Migrate an existing Drupal 6/7 OAuth 1.0a deployment forward to Drupal 10/11.
- Expose an authenticated feed or data export that a partner system polls with signed requests.
- Give each integration partner its own revocable key so access can be cut without disturbing others.
- Configure the request-token lifetime and an alternate login path via the admin settings form.
- Prevent OAuth-authenticated responses from leaking into the shared page cache.
- Audit which consumers a user holds and delete stale or leaked credentials individually.
- Back a headless commerce or content API where signed 1.0a requests are contractually required.
- Provide OAuth 1.0a credentials for server-cron jobs that call the site's web services.
- Bridge to a third-party service that only accepts OAuth 1.0a callbacks.
- Stand up a two-legged OAuth endpoint without running a full authorization-server stack.
