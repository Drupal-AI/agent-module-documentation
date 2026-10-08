<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchEtat configuration

## Install / enable

```
composer require drupal/captchetat   # pulls drupal/captcha ^2
drush en captchetat -y               # enables captcha automatically
```

Then register an application on the PISTE platform (`api.gouv.fr` → CaptchEtat) to obtain a
**Client ID** and **Client Secret**. A sandbox environment exists and is the default.

## Settings form

`Drupal\captchetat\Form\CaptchetatSettingsForm` (`src/Form/CaptchetatSettingsForm.php`), a
`ConfigFormBase`, form id `captchetat_settings`. Route **`captchetat.settings`** at
`/admin/config/captchetat/settings`, guarded by permission **`administer CAPTCHA settings`**
(that permission is provided by the **Captcha** module, not by captchetat). Menu link under
Configuration (`captchetat.links.menu.yml`); local task tab (`captchetat.links.task.yml`).

Fields (all written to the config object `captchetat.settings` in `submitForm()`):

| Form field | Config key | Type / default | Notes |
|---|---|---|---|
| Sandbox mode | `sandbox` | checkbox, default TRUE | Chooses sandbox vs production API/OAuth hosts. |
| Client ID | `client_id` | textfield, required | OAuth2 client id from PISTE. |
| Client Secret | `client_secret` | textfield, required | OAuth2 client secret from PISTE. |
| CAPTCHA Style | `captcha_style` | select, required, default `captcha` | Character set/length, see below. |
| Keep focus on captcha buttons | `keep_focus` | checkbox, default TRUE | UX/accessibility option (read by the vendored JS). |

### CAPTCHA style options (`captcha_style`)

`captcha` (6–9 alphanumeric), `numerique6_7Captcha` (6–7 numeric), `alphabetique6_7Captcha`
(6–7 alphabetic), `alphanumerique12Captcha` (12 alphanumeric), `alphabetique12Captcha`
(12 alphabetic), `numerique12Captcha` (12 numeric), `alphanumerique4to6LightCaptcha`
(4–6 alphanumeric, light), `alphanumerique6to9LightCaptcha` (6–9 alphanumeric, light).

At request time `captchetat_captcha()` appends the interface language to the style name — `FR`
for French, `EN` otherwise (e.g. `captchaFR`) — and passes it to the API as `captchaStyleName`.

## Config object & schema

Config object **`captchetat.settings`** (no `config/install/` defaults are shipped — defaults are
applied in code via `?? TRUE` / `?? 'captcha'`). Schema in
`config/schema/captchetat.schema.yml` (`config_object`):

```yaml
captchetat.settings:
  mapping:
    sandbox: {type: boolean}
    client_id: {type: text}
    client_secret: {type: text}
    captcha_style: {type: text}
    keep_focus: {type: boolean}
```

## Assign the CAPTCHA to forms

This module only registers the challenge type. Use the **Captcha** module to apply it: at
`/admin/config/people/captcha` add or edit a *Captcha point* for the target form id and choose
challenge **`captchetat/CaptchEtat`**, or set it as the default challenge.

## Operational notes

- API/OAuth hosts are **hardcoded** in `CaptchetatService` (not configurable): production
  `api.piste.gouv.fr` / `oauth.piste.gouv.fr`, sandbox `sandbox-api.piste.gouv.fr` /
  `sandbox-oauth.piste.gouv.fr`, API path `/piste/captchetat/v2`.
- Reports → Status report runs `hook_requirements()` (`captchetat.install`), which fetches a token
  and calls the API `/healthcheck`; shows a warning if the service is unreachable or misconfigured.
- Uninstalling clears the cached OAuth token (`hook_uninstall` → `clearApiToken()`).
