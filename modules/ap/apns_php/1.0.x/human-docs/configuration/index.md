# Configuration

All settings live in one form, and delivery can be verified from a companion test
form. Settings are stored in the `apns_php.settings` config object.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → APNs PHP**, or navigate directly to
   `/admin/config/system/apns_php`.

## Settings

- **App bundle ID** — your app identifier, e.g. `com.example.app`.
- **Team ID** — your Apple Developer team ID.
- **Key ID** — the Apple Developer key ID for the certificate/key.
- **Certificate path** — the path to your token/certificate file. **It must live
  outside the Drupal webroot.** The field accepts an absolute path
  (`/etc/apns/key.p8`), a relative path (`../apns/key.p8`), or a stream-wrapper
  path (`private://apns/key.p8`). The module checks the file exists and is
  readable.
- **Certificate secret (passphrase)** — optional. **Stored in plaintext config**
  (see the security note below). Leave the field blank to keep the currently saved
  value.
- **Production** — checked = the production APNs environment; unchecked = the
  sandbox environment.
- **Logging level** — how verbose the module's Drupal logging is.
- **Log token validation result** — whether token validations are written to the
  database.
- **Notification URL key** — the custom payload key that carries a deep-link URL
  the app reads (default `url`; you might use `link` or `deeplink`). It **cannot**
  be `aps`, which Apple reserves.

Save the form.

## Handle the two secrets safely

- **The `.p8`/`.pem` key file** is referenced by path and kept on disk — the safest
  option. Store it outside the webroot (a `private://` path or a location like
  `/etc/apns/`), readable only by the web user.
- **The passphrase (`certificate_secret`)** is stored as plaintext in
  `apns_php.settings`, so it lands in configuration exports. Treat config exports
  as sensitive. To avoid committing it, save the passphrase into the environment on
  this DDEV site (`ddev dotenv set .ddev/.env --apns-cert-secret='<value>'`, then
  `ddev restart`) and override the config value from `settings.php` with
  `getenv('APNS_CERT_SECRET')`, rather than typing it into the form.

## Send a test message

Open **`/admin/config/system/apns_php/test`** to send a test notification through
the `ApnsPhpMessagingService`. Use this to confirm your key, IDs, certificate path
and sandbox/production toggle are all correct before wiring push into a real
workflow.

## Using it from code

Inject the `ApnsPhpMessagingService` service to send notifications from your own
code. It builds the pushok client from the configuration above and raises typed
`ApnsPhp*` exceptions (auth, missing certificate, invalid token, payload, server)
so you can handle each failure mode distinctly.
