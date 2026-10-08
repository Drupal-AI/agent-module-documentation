# Configure FormAssembly: API endpoint, credentials, OAuth

Settings form: `\Drupal\formassembly\Form\FormAssemblyEntitySettingsForm` (form id
`FormAssemblyEntity_settings`).
Route **`fa_form.settings`** → `/admin/structure/fa_form/settings` (permission
`administer formassembly form entities`, an admin route). Menu link `fa_form.admin.structure.settings`
under *Structure*.

## Config object `formassembly.api.oauth`

Schema: `config/schema/formassembly.api.oauth.yml` (type `config_object`).

| Key | Type | Meaning |
|---|---|---|
| `endpoint` | uri | Base URL of your FormAssembly instance, e.g. `https://app.formassembly.com`, `https://developer.formassembly.com`, `https://<name>.tfaforms.net`, or a self-hosted path. Required. |
| `admin_index` | boolean | Use the Enterprise admin form index (`/admin/api_v1/...`) instead of the standard index (`/api_v1/...`). Requires admin-level OAuth credentials. |
| `credentials.provider` | string | `formassembly` (store client id/secret in this config) or `key` (reference a Key entity). |
| `credentials.data.cid` | string | OAuth Client ID — present when provider is `formassembly`. |
| `credentials.data.secret` | string | OAuth Client Secret — present when provider is `formassembly`. |
| `credentials.data.id` | string | Key entity id — present when provider is `key`. |

Path segments used against `endpoint` (see `ApiBase::getUrl()`): standard `/api_v1`, admin
`/admin/api_v1`; form list `/api_v1/forms/index.json`; rendered form `/rest/forms/view/{faid}`.

### Credential provider

The `provider` selector only appears when the Key module is installed
(`FormAssemblyKeyService::additionalProviders()` returns true). Without Key, credentials are stored as
plaintext `cid`/`secret` inside `formassembly.api.oauth` config. With Key, choose a key of type
`formassembly_oauth` (a multivalue authentication KeyType this module defines, fields `cid` + `secret`,
stored as JSON) and only its id is written to config. `FormAssemblyKeyService::getOauthKeys()` resolves
either provider to a `['cid' => ..., 'secret' => ...]` array.

## OAuth authorization flow

After saving the form, the module redirects to `fa_form.authorize` if "Reauthorize" is checked or no
valid token exists. Two controller routes (`OauthInteractions`), both requiring
`administer formassembly form entities`:

| Route | Path | Action |
|---|---|---|
| `fa_form.authorize` | `/admin/structure/fa_form/settings/authorize` | Builds the provider authorization URL and `TrustedRedirectResponse`s the browser to FormAssembly. |
| `fa_form.authorize.store` | `/admin/structure/fa_form/settings/code` | FormAssembly redirect target; reads the `code` query param and exchanges it for an access token. |

`ApiAuthorize::authorize($code)` performs the `authorization_code` grant via
`Fathershawn\OAuth2\Client\Provider\FormAssembly` and stores the resulting League `AccessToken` object
in Drupal **State** under `fa_form.access_token`. `getToken()` transparently refreshes it with the
`refresh_token` grant when expired. `isAuthorized()` reports whether a non-expired token is present.
The redirect URI registered with FormAssembly is the absolute URL of `fa_form.authorize.store`.

## Sync trigger

The form's "Sync now" checkbox (`batch_sync`, disabled until authorized) queues a batch
(`formassembly_batch_get_forms` / `formassembly_batch_finished`) that pulls the form list and
creates/updates `fa_form` entities. See [../drush/commands.md](../drush/commands.md) to sync on cron.

## Set via PHP / drush

```php
$config = \Drupal::configFactory()->getEditable('formassembly.api.oauth');
$config->setData([
  'endpoint' => 'https://app.formassembly.com',
  'admin_index' => FALSE,
  'credentials' => [
    'provider' => 'formassembly',
    'data' => ['cid' => 'CLIENT_ID', 'secret' => 'CLIENT_SECRET'],
  ],
])->save();
// Or with the Key module:
// 'credentials' => ['provider' => 'key', 'data' => ['id' => 'my_fa_key']],
```

Then visit `/admin/structure/fa_form/settings/authorize` as a user with
`administer formassembly form entities` to complete the OAuth handshake (the token cannot be set
programmatically without the interactive grant).
