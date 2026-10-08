<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Draggable CAPTCHA adds a drag-and-drop / click challenge type to the CAPTCHA module: the form shows four small shape buttons (heart, "bwm", star, diamond) and a target image of one of them, and the visitor drags or clicks the shape that matches the target into a drop area.

---

The module registers two CAPTCHA types through `hook_captcha()` — **"Draggable Captcha"** and **"Draggable Captcha Mini"** (a smaller variant) — which you then attach to any protected form on CAPTCHA's admin screen (`/admin/config/people/captcha`, the module's `configure` route is `captcha_settings`); it has no settings page of its own. When a form renders, `_draggable_captcha_setup()` builds four random per-challenge hash codes (`Crypt::hmacBase64(mt_rand(), hash_salt)`, one per shape), picks one shape at random as the answer, and stores both the code map and the chosen key in `$_SESSION`. The four shapes are rendered as CSS-sprite `div`s (each `id="draggable_<hash>"`), shuffled in position, and the answer is shown only as a **server-rendered PNG crop** at `/draggable-captcha/target-img`, generated with GD from the session's answer key. jQuery UI Droppable powers the drag; a click path is also wired. On drop/click the JS writes the chosen shape's hash into a hidden `captcha_response` field and fires an AJAX call to `/draggable-captcha/{sid}/verify` **purely for visual success/fail feedback**. The real gate is server-side: CAPTCHA records the solution `'draggable_' . <answer-hash>` in the `captcha_sessions` table, and on submit `draggable_captcha_custom_validation()` checks `$response == $solution`. A "Refresh" link regenerates the challenge via an AJAX controller that calls `_captcha_update_captcha_session()`. Dependencies are the **captcha** module and **jquery_ui_droppable** (jQuery UI was removed from Drupal core; this rides on the contrib backport). Current release is **2.2.0-beta4** (a beta) on core `^10 || ^11`, GPL-2.0-or-later. Two caveats to weigh: **accessibility** — a drag interaction is hostile to keyboard, screen-reader, tremor and one-handed-mobile users; the click fallback softens but does not fully solve this — and **strength** — with only four possible answer shapes, blind guessing passes roughly 25% of the time, so it suits low-risk forms, not high-security ones (the project page says as much).

---

- Add a drag-or-click shape CAPTCHA to a Drupal form via the CAPTCHA module.
- Offer a friendlier, mobile-oriented alternative to a distorted-text CAPTCHA.
- Reduce casual spam on a site-wide contact form.
- Protect a user registration form from low-effort bots.
- Protect an anonymous comment form.
- Add a challenge to a newsletter / mailing-list signup.
- Guard a webform submission with a visual challenge.
- Add the compact "Mini" variant where vertical space is tight.
- Replace an existing image or math CAPTCHA challenge type.
- Provide a click-only path for users who cannot drag.
- Reduce moderation workload from automated submissions.
- Add spam control to a booking or enquiry form.
- Protect a password-reset request form.
- Deter scripted abuse of a search or feedback form.
- Offer a non-reading challenge (no mangled characters to decipher).
- Combine with CAPTCHA's per-form placement to challenge only specific forms.
- Let a challenge be refreshed in place without reloading the page.
- Prototype a lightweight bot deterrent on a low-risk internal form.
- Evaluate drag-based CAPTCHA UX before committing to it.
- Pair with CAPTCHA's wrong-response logging to monitor bot pressure.
- Serve as a stopgap where an invisible service (e.g. Turnstile/reCAPTCHA) is undesirable.
- Add visual variety to a form's anti-spam step.
- Challenge a survey or poll submission form.
- Protect an "email to a friend" or share form.
