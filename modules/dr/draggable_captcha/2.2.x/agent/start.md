<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Draggable CAPTCHA (draggable_captcha) — agent index

A **CAPTCHA challenge type** (integration with the `captcha` module), not a standalone
form-protection module. It registers two types via `hook_captcha()`:
**"Draggable Captcha"** and **"Draggable Captcha Mini"**. Attach them to forms on
CAPTCHA's admin UI (`/admin/config/people/captcha`); `configure` points at
`captcha_settings` — the module has **no settings form or config schema of its own**.

- **Install/enable, the two `hook_captcha` types, challenge generation, server-side
  validation, routes and libraries** → [captcha/challenge-type.md](captcha/challenge-type.md)

- **Version:** 2.2.0-beta4 (beta). Core `^10 || ^11`. GPL-2.0-or-later.
- **Dependencies:** `captcha` and `jquery_ui_droppable` (the contrib jQuery UI backport;
  jQuery UI was removed from Drupal core).
- **Requires server-side GD** with PNG support (the target image is cropped with GD).
- No permissions, no Drush commands, no plugin types.

## How the challenge works (real mechanism, from source)

`draggable_captcha.module`:
- On render, `_draggable_captcha_setup($type)` builds four shapes — `heart`, `bwm`,
  `star`, `diamond` — each given a random per-challenge hash:
  `Crypt::hmacBase64(mt_rand(00000000,99999999), Settings::getHashSalt())`. It picks one
  shape at random (`array_rand`) as the answer and stores in the PHP session:
  `$_SESSION['DraggableCaptchaCodes'][shape] = hash` and
  `$_SESSION['DraggableCaptchaAnswer'] = <answer shape key>` (suffixed `_mini` for the
  mini type).
- The four shapes render as shuffled CSS-sprite `div`s, each `id="draggable_<hash>"`
  (`templates/draggable-captcha*.html.twig`). The **answer is shown only as a
  server-rendered PNG**, `/draggable-captcha/target-img`, cropped by GD from the session
  answer key — it is **not** emitted as text in markup or `drupalSettings`.
- **Server-side solution & validation (correct pattern):** the hook returns
  `$captcha['solution'] = 'draggable_' . $_SESSION['DraggableCaptchaCodes'][$_SESSION['DraggableCaptchaAnswer']]`,
  which the `captcha` module writes to the **`captcha_sessions`** table. On submit,
  `draggable_captcha_custom_validation($solution, $response)` returns
  `$response == $solution`. The hidden `captcha_response` textfield (class `captchaAnswer`)
  is filled by JS with the chosen shape's `draggable_<hash>` id.

`js/draggable_captcha*.js`: jQuery UI `draggable`/`droppable`; on drop or click it sets the
hidden field and POSTs to `/draggable-captcha/{sid}/verify` **only to toggle success/fail
styling** — this AJAX call is UX feedback, not the security gate.

`src/Controller/DraggableCaptchaController.php` (routes in `.routing.yml`, all
`_access: 'TRUE'` so anonymous users can reach them, as a CAPTCHA requires):
- `::verify` — reads `$_REQUEST['captcha']`, compares its hash suffix against session
  codes, returns `{status: success|error}` JSON. Client feedback only.
- `::targetImg` — GD-crops the sprite for the session answer shape, returns `image/png`.
- `::generateRefresh` — regenerates the challenge and updates `captcha_sessions` via
  `_captcha_update_captcha_session()` (AjaxResponse `ReplaceCommand`).

## What to tell users

- **The real gate is server-side** via CAPTCHA's `captcha_sessions` table — good. The
  answer is not leaked as text to the client.
- **Strength is low by design:** only four possible answer shapes, so blind guessing
  passes ~25% per attempt; the project itself says it "isn't suit[able] for high secure
  forms." Fine for low-risk forms; not for high-value ones.
- **Accessibility:** dragging excludes keyboard, screen-reader, tremor and one-handed
  mobile users; the click fallback helps but the challenge is still visual (match a shape
  image), with no text alternative. Weigh an invisible service (Turnstile / reCAPTCHA)
  where accessibility and scale matter.
- **Beta + jQuery UI dependency:** it is a beta release built on `jquery_ui_droppable`,
  a best-effort contrib backport of a library core has dropped.
