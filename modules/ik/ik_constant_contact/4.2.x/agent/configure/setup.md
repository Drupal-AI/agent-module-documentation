# Configure Constant Contact: credentials, OAuth, lists, tokens

Admin UI under `/admin/config/services/ik-constant-contact` (permission `administer constant
contact configuration`, `restrict access: true`). Three tabs/routes:

| Route | Path | Form/controller |
|---|---|---|
| `ik_constant_contact.config` | `/admin/config/services/ik-constant-contact` | `Form\ConstantContactConfig` |
| `ik_constant_contact.lists` | `…/lists` | `Form\ConstantContactLists` |
| `ik_constant_contact.fields` | `…/fields` | `Controller\CustomFieldsController` (read-only table of CC custom fields + their UUIDs) |
| `ik_constant_contact.authentication_callback` | `…/callback` | `Controller\AuthenticationCallback` (OAuth redirect target) |

## Credentials — settings.php (preferred) or config

`ConstantContact::getConfig()` reads `$settings['ik_constant_contact']` first; only if absent does
it fall back to the `ik_constant_contact.config` config object.

```php
// settings.php
$settings['ik_constant_contact'] = [
  'client_id'     => 'your-api-key',
  'client_secret' => 'your-client-secret',
  'auth_type'     => 'auth_code', // only Authorization Code Flow is supported (PKCE disabled)
];
```

When credentials come from settings.php the admin form shows them disabled and hides the Save
button. When entered via the form they are stored in `ik_constant_contact.config` (the secret is
masked as `*******` on redisplay). Storing the secret in config vs settings.php is an operator
deployment choice.

## OAuth2 authorize + callback

1. On the config form, "Authorize Your Account" links to Constant Contact's authorize URL
   (`authz.constantcontact.com/oauth2/default/v1/authorize`) with `client_id`, `redirect_uri` =
   `<site>/admin/config/services/ik-constant-contact/callback`, `response_type=code`,
   `state` = site UUID, and scope `offline_access+contact_data+campaign_data`.
2. Constant Contact redirects back to the callback with `?code=…`. `AuthenticationCallback::callbackUrl`
   POSTs the code to the token URL (Basic auth = base64 `client_id:client_secret`) and, on success,
   `saveTokens()` persists access + refresh tokens.

The callback route requires `administer constant contact configuration`.

## Enabling lists

`ConstantContactLists` shows a `tableselect` of the account's lists (fetched via
`getContactLists()`); checked lists are saved to `ik_constant_contact.enabled_lists`
(`{ <list_uuid>: 1 }`). Only enabled lists are usable in blocks, the field type, the webform
handler, and the REST endpoint.

## Token storage & refresh

- Tokens persist in DB table `ik_constant_contact_tokens` (`access_token`, `refresh_token` as big
  blobs; `expires_in`; `timestamp` primary key). Legacy installs kept them in
  `ik_constant_contact.tokens` config; update hooks (`_93100/_93101/_93103`) migrate to the table.
- `refreshToken()` is called before each API request and by cron; `hook_cron`
  (`ik_constant_contact_cron`) also re-caches lists (`getContactLists(FALSE)`) and calls
  `deleteExpiredTokens()`. The config form warns if cron isn't set up (recommends `automated_cron`).

## Notes

- Config objects: `ik_constant_contact.config`, `ik_constant_contact.enabled_lists`,
  `ik_constant_contact.tokens` (legacy), `ik_constant_contact.pkce` (code_verifier; PKCE flow is
  present in code but disabled — see issue #3285446).
- Uninstall deletes the `ik_constant_contact` config.
