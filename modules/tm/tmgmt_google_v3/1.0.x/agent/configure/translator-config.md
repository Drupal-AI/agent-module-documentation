# Configure the Google V3 translation provider

The module has **no settings page**. You configure it by creating a TMGMT **Translator**
(provider) config entity that uses the `google_v3` plugin.

## Prerequisites

- `tmgmt` enabled (dependency) and at least two languages configured.
- **Private file system** enabled (`$settings['file_private_path']`) — the credentials key file
  is uploaded to `private://`.
- A Google Cloud project with the Translation API enabled and a **service-account JSON key**
  (see https://cloud.google.com/translate/docs/setup).

## Via the UI

1. Go to *Configuration → Regional and language → Translation providers*
   (`/admin/tmgmt/translators`) → **Add translator**.
2. Set **Translator plugin** to **Google V3**. The plugin form then shows:
   - **Location** — Google API location; default `global`.
   - **Project ID** (`api_project`) — your Google Cloud project id.
   - **Google API Credentials** — upload the service-account JSON key (managed file → `private://`).
   - **Glossary mappings** — optional; one textfield per site language to enter a Google glossary id.
3. Click **Connect** to test — it calls `getSupportedRemoteLanguages()`; "Successfully connected!"
   means the credentials/project work.
4. Save.

## Settings keys (on the `tmgmt_translator` entity, under `settings`)

| Key | Meaning |
|---|---|
| `location` | Google API location (e.g. `global`). |
| `api_project` | Google Cloud project id (used as `projects/<id>/locations/<location>`). |
| `google_credentials` | managed-file value (`fids`) of the uploaded JSON key in `private://`. |
| `glossary_mappings` | array keyed by Drupal langcode → Google glossary id. |

## Via code / drush (no live API call needed)

The provider entity is `Drupal\tmgmt\Entity\Translator`. You can create it and set the non-secret
settings without a key (translation calls will fail until real credentials are added, but the
config is valid):

```php
use Drupal\tmgmt\Entity\Translator;
Translator::create([
  'name' => 'google_v3_provider',
  'label' => 'Google V3',
  'plugin' => 'google_v3',
  'settings' => [
    'location' => 'global',
    'api_project' => 'my-gcp-project',
    'glossary_mappings' => [],
  ],
])->save();
```

Read it back: `drush cget tmgmt.translator.google_v3_provider` → check `plugin: google_v3` and
`settings.api_project`.

## Notes

- `checkAvailable()` returns "yes" only when `location`, `api_project` **and**
  `google_credentials` are all set; otherwise TMGMT shows the provider as not configured.
- The credentials file is set **permanent** on save (form validate handler).
- Uploaded key extension is restricted to `json`.
