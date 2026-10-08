# Configure Mailjet (settings, credentials, mail transport, tracking)

All base configuration lives under `/admin/config/system/mailjet`. The tabs are Drupal local tasks
(`mailjet.links.task.yml`) grouped under `base_route: mailjet_settings.settings_form`.

## Routes and what each does

| Route | Path | Handler | Access requirement |
|---|---|---|---|
| `mailjet_settings.settings_form` | `/admin/config/system/mailjet` | `MailjetSettingsForm` | `_mailjet_access_check` |
| `mailjet_api.admin_settings_form` | `/admin/config/system/mailjet/api` | `MailjetApiForm` | `_permission: access administration pages` |
| `trusted_domains.custom_form` | `/admin/config/system/mailjet/domains` | `DomainSettingsForm` | `_mailjet_access_check` |
| `save_domain.settings` | `/admin/config/system/mailjet/domains/add-domain` | `DomainSaveForm` | `_mailjet_access_check` |
| `mailjet_test_email.settings` | `/admin/config/system/mailjet/test` | `MailjetTestEmailForm` | `_mailjet_access_check` |
| `mailjet_other_settings.page` | `/admin/config/system/mailjet/mailjet-panel` | `MailjetController::content` | `_mailjet_access_check` |
| `mailjet_regester.page` | `/admin/config/system/mailjet/register` | `MailjetRegisterController::redirectRegister` | `_mailjet_access_check` |
| `mailjet_my_profile.page` | `/admin/config/system/mailjet/my-profle` | `MailjetMyAccountController::redirectMyProfile` | `_mailjet_access_check` |
| `mailjet_upgrade.page` | `/admin/config/system/mailjet/upgrade` | `MailjetUpgradeController::redirectUpgrade` | `_mailjet_access_check` |

`_mailjet_access_check` resolves to `Drupal\mailjet\Access\MailjetConfigurationAccessCheck` (service
`mailjet.access_check`, tagged `access_check` / `applies_to: _mailjet_access_check`). Its `access()`
grants when the account has `access administration pages`, and adds a "enter your API keys" warning
message when credentials are not yet set.

## Step 1 — enter API credentials (`MailjetApiForm`, `…/api`)

`MailjetApiForm::submitForm()` writes two `mailjet.settings` keys and validates them against the
Mailjet API:

```php
$config->set('mailjet_username', $form_state->getValue('mailjet_username')); // API Key
$config->set('mailjet_password', $form_state->getValue('mailjet_password')); // Secret Key
$config->save();
$client = MailjetApi::getApiClient($key, $secret);
if ($client->get(Resources::$Myprofile)->success()) {
  $config->set('mailjet_active', TRUE);
  // creates an iframe API token, stores it in 'APItoken', then mailjet_first_sync(...)
}
```

On success it also creates a Mailjet iframe token (`Resources::$Apitoken`), saves it as `APItoken`,
runs an initial full user→contact sync (`mailjet_first_sync()`), and flushes caches.

## Step 2 — turn on the Mailjet mail transport (`MailjetSettingsForm`, `/admin/config/system/mailjet`)

- The **"Send emails through Mailjet"** checkbox writes `system.mail:interface.default`. Ticked ⇒
  `mailjet_mail`; unticked (when it was `mailjet_mail`) ⇒ `php_mail`. `hook_uninstall` resets it to
  `php_mail`.
- **"Allow HTML"** ⇒ `mailjet.settings:mail_headers_allow_html_mailjet` (controls whether
  `MailjetMail` sends HTML or converts to plain text).
- `validateForm()` probes SMTP reachability to `in-v3.mailjet.com` across a list of protocol/port
  pairs (`ssl://:465`, `tls://:587`, `:587`, `:588`, `tls://:25`, `:25`) with `fsockopen()` and stores
  the working `mailjet_protocol` (`ssl`/`tls`/`standard`) and `mailjet_por`.
- The **Account Information** fieldset (name/company/address/country/state) is pushed to the Mailjet
  profile on save via `mailjet_mjuser_update()`.

## Step 3 — event tracking

The Settings form shows the **Event callback URL** (`<base_url>/mailjetevent`) to paste into Mailjet's
trigger config, and checkboxes for `open`/`click`/`bounce`/`spam`/`blocked`/`unsub`. Saving calls
`mailjet_user_trackingupdate()`, which POSTs/DELETEs `Resources::$Eventcallbackurl` entries on the
Mailjet side. Actually storing/handling the inbound events requires the `mailjet_event` submodule —
see [../events/webhooks.md](../events/webhooks.md).

## `mailjet.settings` config keys (schema `config/schema/mailjet.schema.yml`)

| Key | Type | Meaning |
|---|---|---|
| `mailjet_username` | string | Mailjet **API key** (public part). |
| `mailjet_password` | string | Mailjet **Secret key**. |
| `mailjet_active` | boolean | Set TRUE once credentials validate against the API. |
| `mailjet_mail` | boolean | Legacy "send through Mailjet" flag (install default `1`). |
| `mail_headers_allow_html_mailjet` | boolean | Send HTML mail vs plain text (install default `1`). |
| `apitoken` | string | Iframe/API token returned by Mailjet (schema key `apitoken`; code also writes `APItoken`). |
| `mailjet_title` | string (translatable) | Display title (install default `Mailjet API module`). |

Additional runtime keys written by the forms but not in the shipped schema: `mailjet_protocol`,
`mailjet_por`/`mailjet_port`, `mailjet_host`. The credentials live in the `mailjet.settings` config
object — treat it as sensitive, keep it out of shared config exports, and supply the key/secret from an
environment variable / Key entity where your workflow allows.

## Set credentials from code / Drush

```php
$config = \Drupal::configFactory()->getEditable('mailjet.settings');
$config->set('mailjet_username', getenv('MAILJET_API_KEY'))
       ->set('mailjet_password', getenv('MAILJET_API_SECRET'))
       ->set('mailjet_active', TRUE)
       ->save();
// Route Drupal mail through Mailjet:
\Drupal::configFactory()->getEditable('system.mail')->set('interface.default', 'mailjet_mail')->save();
```
