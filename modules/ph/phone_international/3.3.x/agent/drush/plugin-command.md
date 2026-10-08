# International Phone — Drush command

The module registers one Drush command (via `drush.services.yml` →
`PhoneInternationalCommands`).

## `phone_international:plugin`

Aliases: `piplugin`, `pi-plugin`.

Downloads the **intl-tel-input** JavaScript library (jackocnr/intl-tel-input v17.0.19) and
installs it into the site's `libraries/` directory (so the widget can use a local copy
instead of the CDN).

```bash
# default: installs into ./libraries/intl-tel-input
drush phone_international:plugin

# or specify a target path
drush phone_international:plugin sites/default/libraries
```

Behavior: creates the target dir if missing, downloads and unzips the release, and renames
the extracted folder to `intl-tel-input`. Pair with the global setting
`phone_international.settings.cdn = false` to serve the library locally.
