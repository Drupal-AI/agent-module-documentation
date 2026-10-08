# Configure — connect to an Acquia subscription

## Connect the site (UI)

Routes (all require `administer site configuration`):

| Route | Path | Purpose |
|---|---|---|
| `acquia_connector.settings` | `/admin/config/services/acquia-connector` | Settings form (`SettingsForm`) — the `configure` route |
| `acquia_connector.setup_oauth` | `/admin/config/services/acquia-connector/login` | Start OAuth "Connect to Acquia Cloud" (`AuthController::setup`) |
| `acquia_connector.setup_manual` | `/admin/config/services/acquia-connector/manual` | Paste credentials manually (`CredentialForm`) |
| `acquia_connector.setup_configure` | `/admin/config/services/acquia-connector/configure` | Pick which Acquia application to bind (`ConfigureApplicationForm`) |
| `acquia_connector.refresh_status` | `/admin/config/services/acquia-connector/refresh-status` | Manual subscription/heartbeat refresh (CSRF-protected) |

Two ways to connect: the **OAuth flow** (`acquia_connector.auth.begin` → Acquia Cloud →
`acquia_connector.auth.return`, handled by `AuthService` + `AuthController`), or **manual
credentials** entered on `CredentialForm`.

## Where credentials come from (not stored in config)

A subscription needs three values: **identifier** (e.g. `ABCD-12345`), **secret key**, and
**application UUID**. They are NOT in the settings config object — they are resolved at
runtime by an event-subscriber chain fired on `AcquiaConnectorEvents::GET_SETTINGS`, in
priority order:

- `FromAcquiaCloud` — env vars / metadata on Acquia hosting (auto-detected).
- `FromCoreSettings` — `settings.php` (e.g. `ah_network_identifier`).
- `FromCoreState` — Drupal state.

The resolved values become a `Drupal\acquia_connector\Settings` object (`getIdentifier()`,
`getSecretKey()`, `getApplicationUuid()`). On Acquia hosting the
`acquia_cloud_network` Key provider plugin (`AcquiaNetworkKeyProvider`, requires the `key`
module) can fetch legacy network keys automatically.

## Settings — `acquia_connector.settings`

Edit on the settings form or via `drush cset acquia_connector.settings <key>`. Defaults from
`config/install/acquia_connector.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `debug` | `false` | Log details of failed status-endpoint validation requests |
| `cron_interval` | `30` | Minutes between site-profile/heartbeat sends |
| `cron_interval_override` | `0` | Override for `cron_interval` (minutes) |
| `hide_signup_messages` | `0` | Suppress connector signup/marketing messages |
| `third_party_settings` | `{}` | Per-product settings injected by other Acquia modules |

Schema: `config/schema/acquia_connector.schema.yml`. Subscription **data** (name, expiration,
application, active flag) is cached separately in **state** under
`acquia_connector.subscription_data`, not in this config object.

## Disconnect / reset

`Subscription::delete()` and `ResetConfirmationForm` scrub stored subscription data and the
`spi.site_name` / `spi.site_machine_name` state keys.
