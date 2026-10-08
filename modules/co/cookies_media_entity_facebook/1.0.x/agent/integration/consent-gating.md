<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent gating: how Facebook embeds are blocked and re-enabled

This submodule wires the `media_entity_facebook` module's Facebook embed into the COOKiES
consent lifecycle. There is no configuration form of its own — enabling the module and the
COOKiES service entity is the whole setup.

## Install / enable
- `drush en cookies_media_entity_facebook` (pulls in `cookies` and `media_entity_facebook ^4.0`).
- `hook_install()` calls `module_set_weight('cookies_media_entity_facebook', 11)` so this module's
  hooks run after the third-party integration.
- Enabling installs `config/install/cookies.cookies_service.facebook.yml`, a `cookies_service`
  config entity (id `facebook`) owned by the COOKiES module.

## The COOKiES service entity (`cookies.cookies_service.facebook`)
Key fields (all admin-editable via COOKiES, not this module):
- `id: facebook`, `label: 'Facebook media'`, `group: social`.
- `consentRequired: true` — the service must be accepted before scripts run.
- `placeholderMainText`: "This content is blocked because Facebook cookies have not been accepted".
- `placeholderAcceptText`: "Only accept Facebook cookies".
- `processorCookiePolicyUrl`: `https://www.facebook.com/privacy/policies/cookies`.
- `dependencies.enforced.module`: `cookies_media_entity_facebook` (also set retroactively by
  `cookies_media_entity_facebook_update_8001()` for sites installed before that update).

## Server-side blocking (`cookies_media_entity_facebook.module`)
- `hook_preprocess_media_entity_facebook(&$variables)` rewrites the embed script tag:
  `$variables['script_attributes']['data-sid'] = ['facebook']` and
  `$variables['script_attributes']['type'] = ['text/plain']`. A `text/plain` script is parsed but
  not executed by the browser, so the Facebook SDK/embed does not run on page load.
- `hook_page_attachments(&$page)` attaches the `cookies_media_entity_facebook/default` library only
  when `CookiesKnockOutService::getInstance()->doKnockOut()` returns TRUE (i.e. COOKiES knock-out
  mode is active). When knock-out is off, nothing is deferred.

## Client-side activation (`js/cookies_media_entity_facebook.js`)
`Drupal.behaviors.cookiesFacebook`:
- `attach()`: if `Drupal.behaviors.facebookMediaEntity` exists, it steals that behavior's `attach`
  into `initFacebook` and nulls the original, so the media_entity_facebook init cannot run until
  this module decides to. It then subscribes to the `cookiesjsrUserConsent` DOM event.
- On the event, if `event.detail.services.facebook` is truthy → `activate(context)`; otherwise
  `fallback(context)`.
- `activate()`: for each `script[data-sid="facebook"]`, clone it, remove `type` and `data-sid`, and
  `replaceWith` the executable clone — this runs the previously neutralized embed script.
- `fallback()`: `$('.facebook-embedded-content').cookiesOverlay('facebook')` — renders the COOKiES
  placeholder/overlay (using the service's placeholder text) so visitors can accept in place.

## Styling
`css/cookies_media_entity_facebook.css` sets a Facebook logo (inline base64 SVG data URI) as the
`.cookies-fallback--facebook` background for the overlay. No remote asset is fetched.

## Operating notes
- No routes, permissions, services, or Drush commands are provided; nothing to secure or expose.
- To change placeholder wording or grouping, edit the COOKiES `facebook` service entity, not this
  module.
- If embeds never unblock, confirm COOKiES knock-out mode is enabled (otherwise the deferring
  library is not attached) and that the `facebook` service is accepted in the consent UI.
