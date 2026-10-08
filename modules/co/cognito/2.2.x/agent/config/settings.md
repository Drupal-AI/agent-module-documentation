<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# settings.php connection, config, messages & plugin type

## Install / enable

`drush en cognito` (pulls in `externalauth`; requires `aws/aws-sdk-php ~3.32` and `gree/jose ^2.2`
via Composer). Enabling immediately replaces the core login/registration/password-reset forms (see
[forms/auth-flow.md](../forms/auth-flow.md)), so the AWS connection below must be configured or
those flows will error.

## AWS connection — `settings.php` (not an admin form)

`Aws\CognitoIdentityProviderClientFactory::create()` and `Aws\CognitoFactory::create()` read
`$settings['cognito']` (Drupal `Settings`, i.e. `settings.php`). Nothing here is stored in Drupal
config or editable in the UI.

```php
$settings['cognito'] = [
  'region' => 'us-east-2',
  'credentials' => [
    'key' => getenv('COGNITO_KEY'),        // AWS IAM access key id
    'secret' => getenv('COGNITO_SECRET'),  // AWS IAM secret access key
  ],
  'user_pool_id' => 'us-east-2_XXXXXXX',
  'client_id' => getenv('COGNITO_CLIENT_ID'),
];
```

- `region` + `credentials` → passed straight to `new CognitoIdentityProviderClient([... ] + ['debug' => FALSE, 'version' => '2016-04-18'])`.
- `client_id` + `user_pool_id` → passed to the `Aws\Cognito` service constructor.
- Per README the app client should be created **without** a generated client secret and with
  **`ADMIN_NO_SRP_AUTH`** (server-based auth) enabled; the sign-in flow uses email as the unique
  identifier (chosen at pool creation, immutable). There is **no `client_secret` key** in this
  config block — the AWS IAM `credentials.secret` is the only secret here.
- `credentials` values are the standard AWS SDK credentials array; they are never written to Drupal
  config, never echoed to a page, and not logged by this module.

## Editable config — `cognito.settings`

Schema `config/schema/cognito.schema.yml` (`config_object`); defaults `config/install/cognito.settings.yml`.
Only two behavioural toggles plus seven UI message strings:

| key | type | default | effect |
|-----|------|---------|--------|
| `click_to_confirm_enabled` | boolean | `false` | Registration shows a "click the email link" message instead of an inline confirmation-code step; relies on a Cognito Lambda to email a link to `/cognito/confirm/…`. |
| `auto_confirm_enabled` | boolean | `false` | Registration auto-logs-in the new user (no confirmation step); requires a Cognito pre-sign-up Lambda that auto-confirms. |
| `messages.*` | label (≤255) | see below | Customisable UI strings. |

Message keys (`messages` mapping): `password_reset_required`, `account_blocked`,
`registration_complete`, `registration_confirmed`, `attempt_confirmation_resend`,
`user_already_exists_register`, `click_to_confirm`. Served by the `cognito.messages`
(`CognitoMessages`) service; some defaults contain HTML links (e.g. `password_reset_required`
links to `/user/password`).

### The only admin form

`cognito.admin_settings` → `/admin/config/people/cognito/settings` (permission
**`administer cognito`**), `Form/SettingsForm` (a `ConfigFormBase`). It edits **only the seven
message strings** — the two boolean toggles are set via config import/`drush cset`, not exposed on
this form. There is no UI for the AWS connection. Menu link `cognito.admin_overview` sits under the
People admin index (`user.admin_index`).

## Permission

`cognito.permissions.yml`: **`administer cognito`** — `title: 'Administer Cognito'`,
`restrict access: true` (marked security-sensitive). Gates only the message settings form. All
other privileged operations (block/enable/create user in Cognito) are reached through the standard
core user routes, which the module re-forms and which keep their own core permissions
(`administer users`, `administer account settings`).

## `CognitoFlow` plugin type

Annotation `Annotation/CognitoFlow`; manager `plugin.manager.cognito.cognito_flow`
(`CognitoFlowManager`, discovery dir `Plugin/cognito/CognitoFlow`, cache `cache.discovery`).
`getSelectedFlow()` is **hard-coded to `cognitoflow_email`** — there is no config to switch flows;
the "Username" flow mentioned in the README is not yet implemented. See
[forms/auth-flow.md](../forms/auth-flow.md) for how the flow maps form slots to classes and
challenge names to routes.
