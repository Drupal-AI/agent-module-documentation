<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Conversion Tracking (webform_ct) — agent index

A **Webform** add-on that lets a permitted editor attach custom JavaScript to a single webform's
**confirmation page** (typically an ad/analytics conversion-tracking snippet). There is no settings
page and no code API of its own: the module is four procedural hooks in `webform_ct.module`. On the
webform's *Confirmation* settings form it adds a `webform_codemirror` JavaScript field, gated by a
dedicated permission; the value is stored as the webform third-party setting
`webform_ct.confirmation_custom_javascript`. On render,
`webform_ct_preprocess_webform_confirmation()` appends that stored string to the confirmation
message markup (adding `script` to the message's allowed tags), so it is emitted when the
confirmation page/message is shown.

The feature is limited to confirmation types **`page`** and **`inline`** — the field is
`#states`-hidden and unsupported for `none`, `message`, `modal`, `url`, and `url_message`
(see the `@todo`s and issue 3314878). Version **1.0.0-alpha3**.

- **Depends on:** `webform:webform`. **Core:** `^8.9 || ^9 || ^10 || ^11`. **Package:** `Webform`.
- **No** settings page / `configure` route, **no** services, **no** routes, **no** plugins, **no**
  drush, **no** src classes. Config is **per webform** (a third-party setting).
- **Permission:** `webform_ct.administer_webform_confirmation_javascript` (one, `restrict access:
  true`). Provides **config schema** (the third-party-setting mapping). One update hook.

## What you'd do → where

- **Attach / read / set the confirmation JavaScript on a webform (UI path, config key, API)** →
  [configure/confirmation-javascript.md](configure/confirmation-javascript.md)
- **Understand the hooks and the render/injection mechanism** → [hooks/hooks.md](hooks/hooks.md)
- **The permission that gates the field** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Hooks (all in `webform_ct.module`): `webform_ct_help`,
  `webform_ct_form_webform_settings_confirmation_form_alter` (alters form
  `webform_settings_confirmation_form`), `webform_ct_preprocess_webform_confirmation`. Extra validate
  callback `_webform_ct_form_validate`.
- Update hook: `webform_ct_update_8001` (`webform_ct.install`) — wraps stored values in `<script>`
  tags.
- Third-party setting: namespace `webform_ct`, key `confirmation_custom_javascript`.
- Config schema key: `webform.settings.third_party.webform_ct` → `confirmation_custom_javascript`
  (`string`).
- Permission: `webform_ct.administer_webform_confirmation_javascript` (`restrict access: true`).
- Form element used (provided by webform, not this module): `webform_codemirror` (`#mode`
  `javascript`).
- Supported confirmation types: `page`, `inline` only.
