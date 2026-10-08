<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & permission

## Install & enable

```bash
composer require drupal/captcha_keypad
drush en captcha_keypad -y
```

No runtime module dependencies. The contrib **CAPTCHA** module (`drupal/captcha`) is optional and
changes the operating mode (see [../api/challenge.md](../api/challenge.md)); `captcha` and `forum`
appear only under `test_dependencies` in the `.info.yml`.

## Route, permission, menu

- Route `captcha_keypad.settings_form` — path `/admin/config/system/captcha_keypad`, `_form:
  \Drupal\captcha_keypad\Form\CaptchaKeypadSettingsForm`, requirement
  `_permission: 'administer captcha keypad'` (`captcha_keypad.routing.yml`).
- Permission `administer captcha keypad` (`captcha_keypad.permissions.yml`). Also used by the
  admin-exempt logic (see below).
- Menu link `captcha_keypad.settings_form` under `system.admin_config_system`
  (`captcha_keypad.links.menu.yml`).

## Config object `captcha_keypad.settings`

Install defaults (`config/install/captcha_keypad.settings.yml`) and schema
(`config/schema/captcha_keypad.schema.yml`):

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `captcha_keypad_code_size` | integer | `4` | Number of digits the visitor must enter (form field caps input at 1–16; see note). |
| `captcha_keypad_shuffle_keypad` | boolean | `true` | Randomize button order on every page load (client-side, `js/captcha_keypad.js`). |
| `captcha_keypad_forms` | sequence<string> | `[]` | Form IDs to add the keypad to — **standalone mode only**. |
| `captcha_keypad_skip_for_admins` | boolean | `true` | Exempt user 1 and holders of `administer captcha keypad`. |
| `captcha_keypad_theme` | string | `horizontal` | `plain`, `horizontal`, or `vertical` layout. |

Note: `CaptchaKeypadSettingsForm::buildForm()` shows a code-size field with `#maxlength => 2` and a
`#default_value` fallback of `5`, and `getCode()` (controller) hard-caps the digit count at 16.

## The settings form (`CaptchaKeypadSettingsForm`)

`ConfigFormBase`, `getFormId()` = `captcha_keypad_settings_form`, editable config
`captcha_keypad.settings`. `buildForm()` renders:

- `captcha_keypad_code_size` (textfield, required), `captcha_keypad_shuffle_keypad` (checkbox),
  `captcha_keypad_skip_for_admins` (checkbox, defaults TRUE), `captcha_keypad_theme` (select).
- **Forms** (`captcha_keypad_forms`, checkboxes) — built ONLY when contrib `captcha` is **not**
  installed. Options are assembled from enabled modules:
  - `contact`: `contact_message_<id>_form` for each contact form entity.
  - `user`: `user_register_form`, `user_pass`, `user_login_form`, `user_login_block`.
  - `comment`: `comment_<type>_form` for each comment type.
  - `forum`: `comment_comment_forum_form`.
  - `node`: `node_<type>_form` for each node type.
- When `captcha` **is** installed, the Forms checkboxes are replaced by a message linking to
  `/admin/config/people/captcha/captcha-points`; placement is done there instead.

`submitForm()` saves all keys (skipping `captcha_keypad_forms` when `captcha` is installed) and
invalidates the `rendered` cache tag via the injected `cache_tags.invalidator`.

## Admin exemption

`captcha_keypad_skip_for_current_user()` (in `.module`): returns FALSE unless
`captcha_keypad_skip_for_admins` is on; otherwise returns TRUE for user 1 or any account with the
`administer captcha keypad` permission. It is consulted by both `formAlter()` and the `captcha`
generate op, so exempt users are never shown the challenge.

## Config export example

```yaml
# captcha_keypad.settings
langcode: en
captcha_keypad_code_size: 4
captcha_keypad_shuffle_keypad: true
captcha_keypad_forms:
  user_register_form: user_register_form
  contact_message_feedback_form: contact_message_feedback_form
captcha_keypad_skip_for_admins: true
captcha_keypad_theme: horizontal
```
