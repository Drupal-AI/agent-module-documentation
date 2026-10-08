# GSearch settings (API token & endpoint)

Route `gsearch.settings` → `/admin/config/gsearch/config`
(`\Drupal\gsearch\Form\GsearchSettingsForm`, permission `administer site configuration`).
Editable config object: **`gsearch.settings`**.

| Key | Type | Default | Purpose |
|---|---|---|---|
| `api_url` | string | `https://api.dataforsyningen.dk/rest/gsearch/v2.0/` | Base URL of the Dataforsyningen GSearch v2 REST API. Kept configurable to point at local stubs / alternate endpoints for testing. |
| `token` | string | `''` | Dataforsyningen API token, sent as the `token` request header on every call. Required. |

Both form fields are `#required`. `api_url` falls back to `Gsearch::$defaultApiUrl` (the same
default value) when left empty in code paths.

## Token validation on save

`GsearchSettingsForm::validateForm()` calls `Gsearch::validateToken($token)`, which does a live
lookup (`getAddress('Algade', $token)`) and returns the token as invalid unless the API returns a
`GsearchAddress`. A wrong token therefore cannot be saved through the form (error
"Supplied Dataforsyningen token is invalid.").

## Set without the form

drush (note: `config:set` bypasses the live token validation above):

```
ddev drush config:set gsearch.settings token 'YOUR_TOKEN' -y
ddev drush config:set gsearch.settings api_url 'https://api.dataforsyningen.dk/rest/gsearch/v2.0/' -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('gsearch.settings')
  ->set('token', 'YOUR_TOKEN')
  ->set('api_url', 'https://api.dataforsyningen.dk/rest/gsearch/v2.0/')
  ->save();
```

A free token is created at `https://dataforsyningen.dk/user#token`.

Config schema: `config/schema/gsearch.schema.yml` (`gsearch.settings` is a `config_object`).
Install defaults: `config/install/gsearch.settings.yml`.
