<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Draggable CAPTCHA challenge types

This module is a **challenge-type plugin for the CAPTCHA module** implemented the
"classic" way, via `hook_captcha()` — not an entity, service, or CAPTCHA `Constraint`
class. Everything lives in `draggable_captcha.module` plus one controller.

## Install & enable

```bash
composer require drupal/draggable_captcha -W   # pulls captcha + jquery_ui_droppable
drush en draggable_captcha -y
```

Dependencies (`draggable_captcha.info.yml`): `captcha:captcha` and
`jquery_ui_droppable:jquery_ui_droppable` (the contrib jQuery UI backport — jQuery UI
was removed from Drupal core). The server also needs **GD with PNG support** (the
target image is cropped with GD). No permissions, no config schema, no Drush commands,
no submodules.

## Enable a type on a form

`configure` points at the CAPTCHA module's own settings route `captcha_settings`
(`/admin/config/people/captcha`) — this module has **no settings form of its own**.
On CAPTCHA's *Form settings* tab, pick a form and choose one of the two challenge
types this module adds, or set one as the site default.

Config equivalent (CAPTCHA stores per-form points in `captcha.captcha_point.*`):

```bash
# captcha_type is "<module>/<challenge label>"
drush cset captcha.captcha_point.user_register_form captchaType 'draggable_captcha/Draggable Captcha' -y
drush cr
```

## The two types (`hook_captcha`)

`draggable_captcha_captcha($op, $captcha_type, $captcha_sid)`:

- `$op === 'list'` → returns `['Draggable Captcha', 'Draggable Captcha Mini']` (Mini is
  the smaller-sprite variant, `$type = 'mini'`).
- `$op === 'generate'` → `draggable_captcha_generate_form($captcha_sid[, 'mini'])`.

Theme hooks are declared in `draggable_captcha_theme()`: `draggable_captcha` and
`draggable_captcha_mini` (templates `templates/draggable-captcha*.html.twig`), each with
variables `image_buttons`, `captcha_codes`, `captcha_sid`, `base_path`.

## How a challenge is built (`draggable_captcha_generate_form`)

1. `_draggable_captcha_image_buttons($type)` returns the **four fixed shapes** —
   `heart`, `bwm`, `star`, `diamond` — each with sprite `on`/`off`/`target` offsets, then
   `_draggable_captcha_shuffle_assoc()` shuffles their order.
2. `_draggable_captcha_setup($type)` assigns each shape a per-challenge hash
   `Crypt::hmacBase64(mt_rand(00000000, 99999999), Settings::getHashSalt())`, picks one
   shape at random with `array_rand()` as the answer, and stores both in the PHP session:
   - `$_SESSION['DraggableCaptchaCodes'][<shape>] = <hash>`
   - `$_SESSION['DraggableCaptchaAnswer'] = <answer shape key>`
   (both keys suffixed `_mini` for the Mini type).
3. The render array attaches library `draggable_captcha/default` and
   `drupalSettings.draggable_captcha.captcha_sid`, and adds a hidden required textfield
   `captcha_response` (class `captchaAnswer visually-hidden`) that the JS fills in.

The four shapes render as CSS-sprite `<div id="draggable_<hash>" class="draggable">`
elements; the answer is presented **only as a server-rendered PNG** at
`/draggable-captcha/target-img` (`<img>` in the template), never as text in markup or
`drupalSettings`.

## Solution storage & server-side validation

This is the security gate and it is the CAPTCHA module's standard path:

- `draggable_captcha_generate_form()` returns
  `$captcha['solution'] = 'draggable_' . $_SESSION['DraggableCaptchaCodes'][$_SESSION['DraggableCaptchaAnswer']]`
  and `$captcha['captcha_validate'] = 'draggable_captcha_custom_validation'`. The CAPTCHA
  module writes that solution into the **`captcha_sessions`** table for this `captcha_sid`.
- On form submit, `draggable_captcha_custom_validation($solution, $response, $element,
  $form_state)` errors if `$response` is empty, otherwise returns `$response == $solution`
  (both operands are the string `"draggable_" . <base64 HMAC>`, so this is a plain string
  compare).

The client's JS writes the chosen shape's `draggable_<hash>` id into the hidden
`captcha_response` field (`js/draggable_captcha*.js`, on `drop` or `click`).

## Routes & controller (`draggable_captcha.routing.yml`, `DraggableCaptchaController`)

All routes are `_access: 'TRUE'` (anonymous — a CAPTCHA must render for logged-out
visitors). Each has a `_mini` twin passing `type: mini`:

| Route | Path | Method | Purpose |
|---|---|---|---|
| `draggable_captcha.verify` | `/draggable-captcha/{captcha_sid}/verify` | `::verify` | Reads `$_REQUEST['captcha']`, returns `{status: success|error}` JSON — drives the JS success/fail styling only; **not** the validation gate. |
| `draggable_captcha.target` | `/draggable-captcha/target-img` | `::targetImg` | GD-crops the fixed sprite (`css/images/bwm-captcha*.png`) for the session answer shape, returns `image/png`. |
| `draggable_captcha.refresh` | `/draggable-captcha/{captcha_sid}/refresh/ajax` | `::generateRefresh` | Re-runs `_draggable_captcha_setup()`, updates the solution with `_captcha_update_captcha_session()`, and returns an `AjaxResponse` `ReplaceCommand` on `#draggable-captcha`. |

`_draggable_captcha_log_error()` increments `captcha_sessions.attempts` and the
`captcha_wrong_response_counter` state value, and logs to the `captcha` channel when
`captcha_log_wrong_responses` state is on.

## Front-end assets (`draggable_captcha.libraries.yml`)

Library `draggable_captcha/default`: CSS `css/draggable-styles.css` +
`css/draggable-styles-mini.css`; JS `js/draggable_captcha.js` +
`js/draggable_captcha_mini.js`; dependencies `core/drupal.ajax` and
`jquery_ui_droppable/droppable`. `Drupal.behaviors.draggable_captcha` wires jQuery UI
`draggable`/`droppable` (snap-to-target drag) plus a click fallback.

## Notes

- Release is **2.2.0-beta4** (beta) on core `^10 || ^11`, GPL-2.0-or-later.
- No config schema is shipped — the challenge has no per-instance settings; placement
  is entirely the CAPTCHA module's config.
- The drag interaction is poor for keyboard/assistive-technology users; the click path
  is the accessible fallback but the challenge is still visual. See the human-docs guide.
