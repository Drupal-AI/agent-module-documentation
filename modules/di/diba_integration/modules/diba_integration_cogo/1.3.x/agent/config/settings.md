<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# diba_integration_cogo — configuration & output

Config: `diba_integration_cogo.settings`. Form: `Form/SettingsForm` at `/admin/config/system/diba_integration_cogo` (`administer site configuration`). Output: `src/Hook/DibaIntegrationCogoHooks.php` + `templates/tmcw-head.html.twig`, `templates/tmcw-body.html.twig`.

## Install / enable
`ddev drush en diba_integration_cogo -y`. Ships install defaults (a DiBa-worded ca/es/en consent text pointing to `diba.cat/…/avislegal`, `expire: 30`, Consent Mode defaults `denied`, accept `granted`, reject `denied`, `gtm: GTM-XXXXXX`). Set your real GTM id to activate output.

## Settings form fields (`SettingsForm::buildForm`)
- Per installed language (`language_manager`): `<lang>-text` (textarea), `<lang>-more_text`, `<lang>-more_link`, `<lang>-accept_text`, `<lang>-reject_text`. Saved into `texts[<lang>]`.
- `style` (extra CSS textarea), `expire` (number, cookie-remember days).
- `verification` (google-site-verification code), `gtm` (container id).
- Consent Mode selects (`denied`/`granted`) for `default_ad_storage`, `default_analytics_storage`, `accept_ad_storage`, `accept_analytics_storage`, `reject_ad_storage`, `reject_analytics_storage`.

## Rendering behavior
`hook_page_attachments` builds a `tmcw_head` head element (keyed `tmcw_body` in `html_head`) carrying `#style`, `#expire`, `#datalang` (= `texts`), `#gtm`, and the four default/accept storage values, plus a `google-site-verification` meta tag with `content = verification`. `hook_page_top` adds a `tmcw_body` element with `#gtm`.

`tmcw-head.html.twig` always loads the DiBa consent CSS/JS from `maqueta.diba.cat` and sets `data-lang-<lang>` attributes and `data-expire`. The Consent Mode + GTM block (`gtag('consent','default',…)`, an accept callback that pushes `gtag('consent','update',…)`, and the standard GTM loader) and the `tmcw-body` `<noscript>` iframe render only when `gtm` is truthy and not the `GTM-XXXXXX` placeholder.

## Operating notes
- All rendered banner values (`text`, `more_text`, `more_link`, accept/reject labels, `style`) come from this config object, editable only by holders of `administer site configuration`. The templates emit the banner text with Twig `|raw` so administrators can include HTML/links in the message — treat this form as an administrator-only, trusted-input surface, consistent with other site-wide script/markup configuration.
- The `expire`, storage-consent, `verification` and `gtm` values are interpolated into the head script; keep `gtm` to a valid `GTM-…` id.
