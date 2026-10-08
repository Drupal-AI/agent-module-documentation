# Configure — settings form

Route `google_index_api.settings_form` at `/admin/config/services/google-index-api`
(`\Drupal\google_index_api\Form\SettingsForm`, permission `administer google index api`).
The module stores its settings in **State**, not config — there is no config object and no config
schema, so these values are per-environment and are NOT exported with `drush config:export`. You must
set them on every environment where the module runs.

## Fields

| Form field | State key | Type | Notes |
|---|---|---|---|
| The Base Domain of the site | `google_index_api_base_domain` | string, required | Prepended to every submitted path (e.g. `https://www.example.com`). Set separately because the backend domain can differ from the public one. |
| The Client Service Account JSON File | `google_index_api_json_file` | managed-file fid array | The Google service-account credential JSON. `managed_file`, extension restricted to `json`, uploaded to `private://google_index_api/`. On submit the file is made permanent and a `file.usage` record is added (module `google_index_api`). |

Prerequisite links shown on the form: obtain the JSON via Google's
[Indexing API prereqs](https://developers.google.com/search/apis/indexing-api/v3/prereqs) and enable
the Indexing API in the Google Cloud console. The core **file** module must be enabled and a
**private file system** configured, or the credential upload cannot succeed.

## Set via drush/PHP

State is the only store, so set it directly (fid is the managed File entity id):

```php
\Drupal::state()->set('google_index_api_base_domain', 'https://www.example.com');
\Drupal::state()->set('google_index_api_json_file', [$fid]);
```

```bash
drush state:set google_index_api_base_domain 'https://www.example.com'
```

## What happens at runtime

`GoogleIndexApi::initalizeClient()` (called in the service constructor) reads
`google_index_api_json_file`, loads the File entity, and passes its URI to
`Google_Client::setAuthConfig()` plus `addScope('https://www.googleapis.com/auth/indexing')`. If the
state key is empty it logs an error pointing back to this form and makes no client. `callApi()` then
POSTs `{"type": <URL_UPDATED|URL_DELETED>, "url": base_domain . path}` to the endpoint.
