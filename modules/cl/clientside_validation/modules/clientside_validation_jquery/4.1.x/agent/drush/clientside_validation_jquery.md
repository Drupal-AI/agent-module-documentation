# Drush commands — jQuery Validate library

Registered via `drush.services.yml`
(`Drupal\clientside_validation_jquery\Commands\ClientsideValidationJqueryDrush`). These manage the
third-party jQuery Validate library at `web/libraries/jquery-validation`.

| Command | Alias | Purpose |
|---|---|---|
| `clientside_validation_jquery:library-download` | `cvjld` | Download jQuery Validation **1.21.0** from GitHub, unzip into `libraries/jquery-validation`, and flush caches. Throws if the folder already exists. |
| `clientside_validation_jquery:library-status` | `cvjls` | Log whether the library is installed (checks `libraries/jquery-validation/dist/jquery.validate.min.js`). |
| `clientside_validation_jquery:library-remove` | `cvjlr` | Delete `libraries/jquery-validation` recursively and flush caches. |

```
drush cvjld    # install the library locally (avoids the CDN)
drush cvjls    # is it installed?
drush cvjlr    # remove it
```

After `cvjld` the module serves the local copy instead of the CDN (unless `use_cdn` is set). The
download unzips to `jquery-validation-1.21.0` and is renamed to `jquery-validation`.
Alternatively install via Composer using `npm-asset/jquery-validation` (see the module's
`composer.example.json`).
