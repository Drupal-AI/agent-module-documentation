<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchEtat (with CAPTCHA) (captcha_captchetat) — agent index

Adds the French government **CaptchEtat** service (PISTE / api.gouv.fr) as a challenge type for the
**CAPTCHA** module (`drupal/captcha`). `hook_captcha()` registers a challenge named `CaptchEtat`;
when it is selected on a CAPTCHA point, `CaptchaService::generate()` builds a container plus a
response textfield, attaches the bundled `captchetat-js` library, and the JS fetches the actual
image/sound challenge from the site's own route `/captchetat/object`, which proxies the request to
the CaptchEtat API using an OAuth2 client-credentials token. On submit, the CAPTCHA module calls the
module's validation callback, which POSTs the user's `(uuid, code)` to the CaptchEtat
`valider-captcha` endpoint and accepts the form **only** if the API replies with the literal string
`true` — verification is entirely server-side and fails closed on any error/empty input.

Two admin forms live under the CAPTCHA settings area: the main **settings** form (OAuth credentials,
sandbox toggle, widget type) and a **texts** form (the "flooded" / "unreachable" messages). Requires
authorization ("habilitation") from api.gouv.fr to obtain the `client_id`/`client_secret`; without
working credentials `ClientHelper::isAvailable()` returns false and `generate()` falls back to the
default CAPTCHA challenge (Math).

- Depends on: `captcha:captcha`. Composer: `drupal/captcha:^2`.
- Core: `^10.3 || ^11`. Package: `Spam control`.
- Settings page / `configure` route: **yes** — `captcha_captchetat.settings_form`
  (`/admin/config/people/captcha/captchetat`).
- Permission: `administer captcha_captchetat` (`restrict access: true`).
- Provides config schema. No drush commands. No plugin types (the challenge is a `hook_captcha` type,
  not a plugin). No fields/widgets/formatters.

## What you'd do → where

- **Enter OAuth credentials, pick a widget type, toggle sandbox, tune flood limits, edit the
  messages** → [configure/settings.md](configure/settings.md)
- **Understand the services, the OAuth/Captcha client stack, the object-proxy route, and the
  server-side validation flow** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Routes: `captcha_captchetat.object` (`/captchetat/object`, `_access: 'TRUE'`, controller
  `CaptchaObjectController::get`), `captcha_captchetat.settings_form`
  (`/admin/config/people/captcha/captchetat`), `captcha_captchetat.texts_form`
  (`/admin/config/people/captcha/captchetat/texts`) — both admin forms `_permission: 'administer
  captcha_captchetat'`.
- Services: `captcha_captchetat.widget` (`Service\CaptchaService`), `captcha_captchetat.helper.client`
  (`Helper\ClientHelper`), `captcha_captchetat.client.captcha` (`Client\CaptchaClient`),
  `captcha_captchetat.client.oauth` (`Client\OauthClient`), abstract base
  `captcha_captchetat.client.base` (`Client\ClientBase`), and the hook object
  `Drupal\captcha_captchetat\Hook\CaptchaCaptchetatHooks` (autowired).
- Hooks: `hook_captcha` (challenge id `CaptchEtat`, const `CaptchaServiceInterface::CAPTCHA_TYPE`),
  `hook_theme` (`captcha_captchetat_widget_noscript`), `hook_help`, `hook_requirements` (runtime
  healthcheck against the API), plus the CAPTCHA validation callback
  `captcha_captchetat_captcha_validation()`.
- Config objects: `captcha_captchetat.settings` (keys `client.oauth.client_id`,
  `client.oauth.client_secret`, `client.oauth.scope`, `client.sandbox`, `flood.ip_limit`,
  `flood.ip_window`, `widget.type`) and `captcha_captchetat.texts` (keys `flood`, `unreachable`).
- Library: `captcha_captchetat/captchetat-js` (bundled minified JS at
  `vendor/captchetat-js/captchetat-js.js`). Template: `captcha-captchetat-widget-noscript.html.twig`.
- External endpoints (all HTTPS): OAuth `oauth.piste.gouv.fr` / `sandbox-oauth.piste.gouv.fr`; API
  `api.piste.gouv.fr` / `sandbox-api.piste.gouv.fr` under `piste/captchetat/v2/`.
- Known quirk (functional, not security): in `CaptchaObjectController::get()` the sound branch reads
  `if (CaptchaClientInterface::OBJECT_TYPE_SOUND)` — a non-empty constant, always true — so every
  object response (image challenges included) is sent with `Content-Type: audio/x-wav` and a `.wav`
  attachment disposition. Should be `if ($objectType === CaptchaClientInterface::OBJECT_TYPE_SOUND)`.
