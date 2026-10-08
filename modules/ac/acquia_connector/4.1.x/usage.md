Acquia Connector links a Drupal site to an Acquia Cloud subscription so the site can authenticate to Acquia network services, expose a status endpoint for uptime monitoring, and send anonymized module/telemetry data back to Acquia.

---

Acquia Connector is the glue between a Drupal site and Acquia's hosted services. Site admins connect the site from **Admin → Configuration → Services → Acquia Connector** (`/admin/config/services/acquia-connector`), either by signing in with an OAuth flow against Acquia Cloud (`acquia_connector.setup_oauth` / `AuthController`) or by pasting subscription credentials manually (`CredentialForm`). Credentials are an identifier, a secret key, and an application UUID, resolved at runtime by a chain of event subscribers that read them from environment variables (Acquia hosting), `settings.php`, or Drupal state — never hard-coded in config. The central `acquia_connector.subscription` (`Subscription`) service is the public API other Acquia modules use: it calls the Acquia Cloud API through a `ClientFactory`, caches raw subscription data in state (`acquia_connector.subscription_data`), and reports whether the subscription is active, expired, or gratis. A `StatusController` publishes a JSON endpoint at `/system/acquia-connector-status` (hash + nonce protected) that Acquia's uptime monitoring polls, and a manual refresh route re-fetches subscription data on demand. The `AcquiaTelemetryService` logs anonymized data — enabled contrib/core modules and versions, PHP and Drupal versions, a hashed site UUID — but only from a detected Acquia production environment, throttled to once per 24 hours per event and only when the data changed. On Acquia hosting a `KeyProvider` plugin can fetch legacy network keys automatically. The module also ships Drush commands (subscription refresh, SQL sanitize), a toolbar item gated by its own permission, and migrate source/destination plugins to carry v3/v4 settings forward.

---

- Connect a Drupal site to an Acquia Cloud subscription via the OAuth "Connect to Acquia Cloud" flow.
- Enter Acquia subscription credentials (identifier, key, application UUID) manually when OAuth is not available.
- Provide subscription credentials through environment variables on Acquia hosting (auto-detected).
- Provide subscription credentials through `settings.php` or Drupal state for non-Acquia hosting.
- Check programmatically whether the site has an active Acquia subscription (`Subscription::isActive()`).
- Read raw subscription data (name, expiration date, application, flags) via the `acquia_connector.subscription` service.
- Detect an expired or gratis subscription and surface a renewal message.
- Expose a hash-protected JSON status endpoint (`/system/acquia-connector-status`) for Acquia uptime monitoring.
- Manually refresh subscription/heartbeat data from the admin UI or via Drush.
- Send anonymized telemetry (module list, versions, hashed site UUID) to Acquia from production environments.
- Report which Acquia extensions (acquia_*, cohesion, sitestudio, lightning_*) are installed and enabled.
- Automatically send telemetry when Acquia modules are installed or uninstalled.
- Throttle telemetry to once per 24 hours and skip unchanged payloads to reduce noise.
- Let other Acquia product modules add metadata to subscription data via the `GET_SUBSCRIPTION` event.
- Let other modules supply subscription settings via the `GET_SETTINGS` event subscriber chain.
- Inject per-product settings into the connector settings form via product-settings events.
- Fetch legacy Acquia network keys automatically on Acquia hosting via the Key provider plugin.
- Show an Acquia Connector toolbar item to users with the toolbar permission.
- Sanitize database dumps of Acquia state with the `sql:sanitize` Drush integration.
- Refresh subscription data from the command line with the connector's Drush command.
- Migrate Acquia Connector settings from version 3 to version 4 via migrate source/destination plugins.
- Configure a cron interval for how often site-profile/heartbeat data is sent.
- Enable debug logging to inspect failed status-endpoint validation requests.
- Hide connector signup/marketing messages via the `hide_signup_messages` setting.
- Gate the connector settings and setup routes behind `administer site configuration`.
- Reset/disconnect the subscription, scrubbing stored credentials and cached data.
