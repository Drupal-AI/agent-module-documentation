# Configure (settings & texts)

Two `ConfigFormBase` forms, both gated by `_permission: 'administer captcha_captchetat'`
(`restrict access: true`) and both surfaced as local tasks / a menu link under the CAPTCHA admin area
(`links.task.yml`, `links.menu.yml`, parent `captcha.settings`). Config translation is declared in
`captcha_captchetat.config_translation.yml`.

## Settings form — `captcha_captchetat.settings_form`

Path `/admin/config/people/captcha/captchetat`. Class `Form\SettingsForm`, editable config
`captcha_captchetat.settings`.

| Form field | Config key | Type | Notes |
|---|---|---|---|
| Enable sandbox mode | `client.sandbox` | boolean | Switches every client to the `sandbox-*.piste.gouv.fr` hosts. Default `false`. |
| Client ID | `client.oauth.client_id` | string | Required. OAuth2 client id from PISTE ("Applications" tab). |
| Client secret | `client.oauth.client_secret` | string | Required. OAuth2 client secret. Stored in config; rendered in the textfield for admins with the manage permission. |
| Scope | `client.oauth.scope` | string | Required but **`#disabled`** in the form — fixed at `piste.captchetat` (the install default). |
| Type | `widget.type` | text | Required radios. One of the 16 `CaptchaClientInterface::TYPES` values (default `captchaFR`). |

The widget `type` drives both the challenge requested from the API and the visible field description
in `CaptchaService::generate()` (a value starting `alphabetique` → "made up of letters", `numerique`
→ "made up of numbers", otherwise "numbers and letters"). Available type ids (from
`CaptchaClientInterface`):

```
captchaEN, captchaFR,
alphabetique6_7CaptchaEN/FR, alphabetique12CaptchaEN/FR,
alphanumerique4to6LightCaptchaEN/FR, alphanumerique6to9LightCaptchaEN/FR, alphanumerique12CaptchaEN/FR,
numerique6_7CaptchaEN/FR, numerique12CaptchaEN/FR
```

Note: `submitForm()` writes `client.sandbox`, `client.oauth.client_id`, `client.oauth.client_secret`
and `widget.type`. It does **not** re-write `client.oauth.scope` (it is disabled) — the scope keeps
whatever the install default set. The `flood.*` keys have no form field and are only editable via
`drush`/config import.

## Texts form — `captcha_captchetat.texts_form`

Path `/admin/config/people/captcha/captchetat/texts`. Class `Form\TextsForm`, editable config
`captcha_captchetat.texts`. Two required textareas:

| Config key | Meaning | Emitted by |
|---|---|---|
| `flood` | Shown when a client IP exceeds the challenge-generation flood limit (HTTP 429). | `CaptchaObjectController::getFloodedResponse()` |
| `unreachable` | Shown when the CaptchEtat service is unavailable or returns no object (HTTP 503). | `CaptchaObjectController::getUnreachableResponse()` |

## Flood control keys (no UI)

`captcha_captchetat.settings` also holds `flood.ip_limit` (default `100`) and `flood.ip_window`
(default `3600` seconds). These are consumed by `CaptchaObjectController::get()` via Drupal's `flood`
service (event name `captcha_captchetat.captcha_generate`) to rate-limit challenge generation per IP.
Set from code:

```php
\Drupal::configFactory()->getEditable('captcha_captchetat.settings')
  ->set('flood.ip_limit', 50)
  ->set('flood.ip_window', 1800)
  ->save();
```

## Install-time defaults (`config/install`)

`captcha_captchetat.settings`: `client.oauth.scope: piste.captchetat`, `client.sandbox: false`,
`flood.ip_limit: 100`, `flood.ip_window: 3600`, `widget.type: captchaFR` (client_id / client_secret
empty). `captcha_captchetat.texts`: English `flood` and `unreachable` sentences.

## Turning the challenge on

Configuring credentials here does not by itself protect any form. As with any CAPTCHA type you must
assign the `CaptchEtat` challenge to a form on the CAPTCHA module's own admin pages
(`/admin/config/people/captcha`, "CAPTCHA points" or the default challenge). If `client_id` /
`client_secret` are blank or the API healthcheck fails, `CaptchaService::generate()` silently falls
back to the CAPTCHA module's default challenge (Math).
