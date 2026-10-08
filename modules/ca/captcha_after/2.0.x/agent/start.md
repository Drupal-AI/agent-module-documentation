<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA After (captcha_after) — agent index

Add-on to the **CAPTCHA** module that keeps the CAPTCHA element **hidden on a protected form until a
flood threshold is crossed**, then reveals and enforces it. Package `Spam control`. Depends on
`captcha:captcha`. Core `^8.8 || ^9 || ^10 || ^11`. PHP `>=7.3`. License GPL-2.0-or-later.
Version 2.0.0. No entities, no plugins, no services, no permissions of its own, no Drush.

- **Global defaults form, per-CAPTCHA-point overrides, the five thresholds, config/schema, and the
  full show/hide + flood mechanism** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- All behavior is in **`captcha_after.module`** (procedural hooks) plus one settings form
  `src/Form/CaptchaAfterSettingsForm.php` and a constants holder `src/CaptchaAfterConstants.php`.
- It attaches to any form where a CAPTCHA element already exists (`isset($form['captcha'])`), set up
  by the CAPTCHA module's `captcha_point` entity for that form id.
- Gating uses **Drupal's flood service** (`\Drupal::flood()`), which is DB-backed and server-side.
  Counters are keyed on hostname/IP (flood default), `session_id()`, or a fixed global identifier
  `_global_` — never a client-supplied counter, cookie, or JS value.

## Routes / config

- Route **`captcha_after.settings`** → `/admin/config/people/captcha_after`, form
  `CaptchaAfterSettingsForm`, permission **`administer CAPTCHA settings`** (from the CAPTCHA module).
  Menu link under *Configuration → People* (`captcha_after.links.menu.yml`).
- Config object **`captcha_after.settings`** holds the five global default thresholds; install
  defaults are all `'0'` (disabled). Per-form overrides are **third-party settings** on the
  `captcha_point` entity (key namespace `captcha_after`), added via
  `hook_form_captcha_point_add_form_alter` / `_edit_form_alter`.

## The five thresholds (per form, one-hour window)

`submit_threshold` (invalid submits by IP), `session_submit_threshold` (invalid submits by session),
`global_submit_threshold` (invalid submits, all visitors), `flooding_threshold` (all submits by IP),
`global_flooding_threshold` (all submits, all visitors). `0` = disabled; empty per-point = use module
default. Constants and event names in `CaptchaAfterConstants` (`THRESHOLD_DISABLED='0'`,
`THRESHOLD_DEFAULT=''`, `FLOOD_EXPIRATION=3600`).

## Mechanism in one line

`hook_form_alter` computes whether any flood is already exceeded → `#after_build`
(`_captcha_after_after_build`) hides the CAPTCHA element when not exceeded → `#validate`
(`_captcha_after_form_validate`) registers flood events, re-checks thresholds on error and reveals the
CAPTCHA if now exceeded, and **clears** the IP/session invalid-submit floods on a successful submit.
Details in [config/settings.md](config/settings.md).
