<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# COOKiES Media Entity Facebook (cookies_media_entity_facebook) — agent index

Glue submodule of **COOKiES** that gates **media_entity_facebook** embeds behind cookie consent. Version-dir `1.0.x` (shipped `1.0.1`). Core `^9.3 || ^10 || ^11`. Package `COOKiES`. License GPL-2.0-or-later.

## What it is
Defers the Facebook embed `<script>` (rendered by media_entity_facebook) until the visitor accepts the COOKiES `facebook` service, then re-enables it client-side. No routes, no permissions, no PHP classes, no admin form.

## Dependencies
- `cookies:cookies` (COOKiES consent framework)
- `media_entity_facebook:media_entity_facebook` (`^4.0`, per composer.json)

## What it provides
- **COOKiES service config entity** `cookies.cookies_service.facebook` (group `social`, `consentRequired: true`, placeholder text + Facebook cookie-policy URL) — `config/install/cookies.cookies_service.facebook.yml`.
- **Hooks** in `cookies_media_entity_facebook.module`:
  - `hook_help` — help page text.
  - `hook_page_attachments` — attaches library `cookies_media_entity_facebook/default` only when `CookiesKnockOutService::getInstance()->doKnockOut()` is TRUE.
  - `hook_preprocess_media_entity_facebook` — sets `script_attributes['data-sid'] = ['facebook']` and `type = ['text/plain']` to neutralize the embed script.
- **Install** (`.install`): `hook_install` sets module weight 11; `update_8001` enforces this module as a dependency of the `facebook` service config.
- **Library** `default` (`cookies_media_entity_facebook.libraries.yml`): `js/cookies_media_entity_facebook.js` + `css/cookies_media_entity_facebook.css`; depends on `core/jquery`, `cookies/cookies.lib`.
- **JS behavior** `Drupal.behaviors.cookiesFacebook`: takes over media_entity_facebook's `facebookMediaEntity` attach, listens for `cookiesjsrUserConsent`, `activate()` (clone script, strip `type`/`data-sid`) on consent, `fallback()` (`cookiesOverlay('facebook')` on `.facebook-embedded-content`) otherwise.

No routes, `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, config schema, or `src/`.

## Solution docs
- [Consent gating integration](integration/consent-gating.md) — how the block/activate flow works and how to operate it.
