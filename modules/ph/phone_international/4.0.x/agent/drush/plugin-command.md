# International Phone — Drush command

The module registers one Drush command (via `drush.services.yml` →
`PhoneInternationalCommands`, injects `@library.discovery`).

## `phone_international:plugin`

Aliases: `piplugin`, `pi-plugin`.

Downloads the **intl-tel-input** JavaScript library (jackocnr/intl-tel-input) and installs it
into the site's `libraries/` directory, so the widget can use a local copy instead of the CDN.

```bash
# default: installs into DRUPAL_ROOT/libraries/intl-tel-input
drush phone_international:plugin

# or specify a target path
drush phone_international:plugin sites/default/libraries
```

Behavior: if the target path already exists it does nothing (logs "already present"); otherwise
it creates the dir, downloads the library's GitHub `archive/master.zip` (remote from the
`phone_international_general` library definition), unzips it (requires the PHP `ext-zip`
extension), flattens the extracted `intl-tel-input-master/` into the target, and removes the
zip. On download or unzip failure it removes the dir and logs an error. Pair with the global
setting `phone_international.settings.cdn = false` to serve the library locally; the module's
status-report check expects the local library to be **v25.3 or newer**.
