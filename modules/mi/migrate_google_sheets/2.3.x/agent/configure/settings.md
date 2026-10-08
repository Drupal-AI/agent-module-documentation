# Configure the Google API key

Single settings form storing one Google API key that the `google_sheets` parser appends to
request URLs.

- Route: `migrate_google_sheets.settings` → `/admin/config/services/google_sheets`.
- Permission: `administer site configuration` (core; `restrict access: true`).
- Form class: `\Drupal\migrate_google_sheets\Form\SettingsForm`.

## Config

```
migrate_google_sheets.settings:
  api_key: '<your Google API key>'   # type: string
```

Set via Drush instead of the UI:

```bash
drush config:set migrate_google_sheets.settings api_key 'AIza...' -y
```

## How the key is used

At fetch time the parser reads `migrate_google_sheets.settings:api_key` and, **only if the source
URL doesn't already carry a `key` query param**, appends it as `?key=<api_key>` before requesting
the sheet (`GoogleSheets::fetchSourceData()`). Provide `key=` directly in a migration's `urls` to
use a different key for that migration. A key is only needed for sheets that require one; a fully
published/public sheet may be readable without it.
