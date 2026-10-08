# Configuration

Configuring Acquia Connector is mostly about **connecting the site to your Acquia
subscription**. There are only a handful of actual settings; the credentials
themselves live outside config.

You need the **Administer site configuration** permission for all of this.

## Connect the site

Go to **Configuration → Services → Acquia Connector**
(`/admin/config/services/acquia-connector`). There are two ways to connect:

- **Connect to Acquia Cloud (OAuth)** — start the OAuth flow
  (`/admin/config/services/acquia-connector/login`), sign in to Acquia Cloud, and
  authorize the site. You'll then pick which Acquia **application** to bind the
  site to.
- **Enter credentials manually** — at
  `/admin/config/services/acquia-connector/manual`, paste the three values that
  identify your subscription: the **identifier** (for example `ABCD-12345`), the
  **secret key**, and the **application UUID**. Use this when the OAuth flow isn't
  available.

After connecting, you can **refresh** subscription / heartbeat data on demand from
the admin UI (or via Drush), and **disconnect / reset** to scrub the stored
subscription data and credentials.

## Where credentials come from

This is important: the identifier, secret key, and application UUID are **not
stored in the settings config object**. They are resolved at runtime from, in
order of priority:

1. **Environment variables / metadata on Acquia hosting** — auto‑detected, so on
   Acquia Cloud you typically don't enter anything.
2. **`settings.php`** — for non‑Acquia hosting (for example `ah_network_identifier`
   and related values).
3. **Drupal state** — set programmatically or via the manual form.

On Acquia hosting, a Key provider (requires the **Key** module) can fetch legacy
Acquia network keys automatically. Keeping credentials out of exported config
means they don't leak into version control.

## The settings

The settings form stores only these behavior options (in the
`acquia_connector.settings` config object). You can also set them with
`drush cset acquia_connector.settings <key> <value>`:

- **Debug** (`debug`, default off) — log details of failed status‑endpoint
  validation requests, for troubleshooting monitoring.
- **Cron interval** (`cron_interval`, default 30) — minutes between site‑profile /
  heartbeat sends.
- **Cron interval override** (`cron_interval_override`, default 0) — an override for
  the interval above, in minutes.
- **Hide signup messages** (`hide_signup_messages`, default off) — suppress the
  connector's signup / marketing messages in the admin UI.
- **Third‑party settings** (`third_party_settings`) — per‑product settings injected
  by other Acquia modules; you normally don't edit these directly.

The subscription **data** itself (name, expiration, application, active flag) is
cached in Drupal **state**, separate from this config object.

## Status endpoint and telemetry

Once connected:

- A hash‑ and nonce‑protected JSON status endpoint is published at
  `/system/acquia-connector-status` for Acquia's uptime monitoring to poll.
- Anonymized **telemetry** (enabled modules and versions, PHP / Drupal versions, a
  hashed site UUID) is sent to Acquia — but **only from a detected Acquia
  production environment**, throttled to once per 24 hours and only when the data
  has changed. It is also sent when Acquia modules are installed or uninstalled.

## Drush

The module ships Drush commands to refresh subscription data from the command line
and to sanitize Acquia state in database dumps (integrated with
`drush sql:sanitize`).
