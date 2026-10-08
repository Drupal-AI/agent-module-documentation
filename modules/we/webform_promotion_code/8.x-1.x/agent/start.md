<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Promotion Code (webform_promotion_code) — agent index

A single Webform **element** that validates a submitted promotion/voucher/access code against an
admin-entered plaintext list. Requires `webform`. Version **8.x-1.2**. Core `^9 || ^10 || ^11`.
No routes, permissions, hooks, services, Drush commands, config schema, or submodules.

## What it actually is

- **Element plugin** `webform_promotion_code` (`src/Plugin/WebformElement/WebformPromotionCode.php`)
  — a `WebformElementBase` subclass. Its `form()` adds a "Promotion code settings" fieldset with:
  - `codes` (textarea): the valid codes, **one per line**.
  - `amount`, `code_length`, `code_pattern`: inputs for the client-side **Auto generate** button only.
- **Render element** `webform_promotion_code` (`src/Element/WebformPromotionCode.php`) — a
  `FormElement` rendered as `<input type="text">`. Its `validateWebformPromotionCode()` callback
  trims the value, does `explode(PHP_EOL, $element['#codes'])` + `array_map('trim', …)`, then
  `in_array($code, $valid_codes_array)`. Non-empty non-matching value → `setError` with
  "*%name* must be a valid code."; empty value passes.
- **JS** (`js/webform_promotion_code.js`): the "Auto generate" button builds N random strings from
  `code_pattern` of length `code_length` and appends them to the `codes` textarea. Admin-form UX
  only — no bearing on validation.

## Mechanism facts (read these before relying on it)

- **Storage:** codes are a plaintext `#codes` property inside the Webform's element config. No DB
  table, no state, no entity. They live in config export / version control. Codes are NOT sent to
  the browser (validation is server-side), so the client HTML does not leak the list.
- **Comparison:** case-sensitive `in_array()` (plain `==` string match), not `hash_equals()`.
- **Redemption:** the element only validates. It **never marks a code used** — a valid code works on
  unlimited submissions. For single use, enable Webform's built-in **Unique** value constraint on
  the element (per-form, per-submission uniqueness).
- **Rate limiting:** none of its own. Brute-force resistance depends on code length/entropy and on
  Webform/core flood protection, which the module does not configure.

## Solution docs

- `agent/elements/promotion-code-element.md` — configuring the element, the auto-generate helper,
  the validation contract, and how to make codes single-use.
