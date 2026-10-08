<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Captcha Keypad (captcha_keypad) — agent index

A self-hosted CAPTCHA that shows a short numeric **code** and makes the visitor click it on an
on-screen **keypad** (typing is rejected; keys can shuffle each load). No third-party service.
Package `Spam control`. **No runtime module dependencies** (contrib `captcha` and `forum` are
`test_dependencies` only). Core `^10.2 || ^11 || ^12`, PHP `>=8.1`. License GPL-2.0-or-later.
Version 2.0.1.

- **Settings form, config object/schema, permission, forms list** →
  [config/settings.md](config/settings.md)
- **How the challenge is built & validated (controller, signed token, hooks, CAPTCHA-module mode)** →
  [api/challenge.md](api/challenge.md)

## What it provides

- **One config form**: `CaptchaKeypadSettingsForm` (route `captcha_keypad.settings_form`,
  path `/admin/config/system/captcha_keypad`, permission **`administer captcha keypad`**). Menu
  link under *Configuration → System*.
- **One permission**: `administer captcha keypad` (`captcha_keypad.permissions.yml`).
- **One service**: `captcha_keypad.controller` → `Drupal\captcha_keypad\Controller\CaptchaKeypad`
  (args `@config.factory`, `@private_key`, `@datetime.time`). Builds and validates the challenge.
- **Hook class**: `Drupal\captcha_keypad\Hook\CaptchaKeypadHooks` (OOP `#[Hook]` + `#[LegacyHook]`
  shims in `captcha_keypad.module`): `help`, `form_alter`, `theme`,
  `theme_suggestions_captcha_keypad_buttons_alter`, `page_attachments`, `captcha`.
- **Theme hook** `captcha_keypad_buttons` (+ `__horizontal`, `__vertical` suggestions), templates
  in `templates/`, CSS in `css/`, behavior `js/captcha_keypad.js` (library `captcha_keypad/captcha_keypad`).
- **Config schema**: `config/schema/captcha_keypad.schema.yml` for `captcha_keypad.settings`.
- No entities, no plugin types of its own, no Drush, no routes other than the settings form.

## Two operating modes (from `CaptchaKeypadHooks`)

- **Standalone** (contrib `captcha` NOT installed): `formAlter()` adds the keypad to each form whose
  `form_id` is in config `captcha_keypad_forms`, prepends validator `captcha_keypad_form_validate`,
  and calls `$form_state->setRebuild()`. Validation runs in `CaptchaKeypad::validateForm()`.
- **CAPTCHA-module mode** (contrib `captcha` installed): `captcha()` registers a challenge type
  `Keypad`; on `generate` it returns the keypad `form`, the plain `solution` (code), and validator
  `captcha_keypad_captcha_validate`. The `captcha_keypad_forms` setting is not used in this mode.

## Config keys (`captcha_keypad.settings`, install defaults)

`captcha_keypad_code_size` (int, install default 4), `captcha_keypad_shuffle_keypad` (bool, true),
`captcha_keypad_forms` (sequence of form_ids, []), `captcha_keypad_skip_for_admins` (bool, true),
`captcha_keypad_theme` (string: `plain`|`horizontal`|`vertical`, install default `horizontal`).
Details in [config/settings.md](config/settings.md).

## Notes

- Requires clicking the keypad — **not keyboard/screen-reader accessible**; do not use as the only
  challenge on forms that must be operable without a pointer.
- `captcha_keypad_skip_for_current_user()` exempts user 1 and holders of `administer captcha keypad`
  when `captcha_keypad_skip_for_admins` is on.
