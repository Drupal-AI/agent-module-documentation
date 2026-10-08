<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Captcha questions (captcha_questions) — agent index

A **question-and-answer CAPTCHA**: an admin sets one question + accepted answers and picks which
forms (by `form_id`) to protect; anonymous submissions with a wrong answer fail validation.
Package **Spam control**. **No dependencies.** Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 2.0.2. Not affiliated with the CAPTCHA module.

## What it provides

- **No entities, no plugins, no services, no Drush.** All logic is procedural in
  `captcha_questions.module` plus one config form.
- **Hooks** (`captcha_questions.module`): `hook_help`, `hook_form_alter` (injects the challenge
  field for **anonymous users only**, on protected form_ids), and `captcha_questions_form_validate`
  (checks the answer, optional logging).
- **Config form** `CaptchaQuestionsSettingsForm` (`src/Form/`) → config object
  **`captcha_questions.settings`**; route **`captcha_questions_settings`** at
  `/admin/config/people/captcha_questions`, permission **`administer captcha questions settings`**.
  `configure` link declared in info.yml; menu link under *People* admin index.
- **Permission** (`captcha_questions.permissions.yml`): `administer captcha questions settings`
  — holders configure the module **and are not shown the challenge**.
- **No config schema** shipped (`config/install/captcha_questions.settings.yml` only; no
  `config/schema/`).
- **Submodule** `captcha_questions_dblog` — optional logging of failed submissions to a dedicated
  DB table with an admin report. See
  [modules/captcha_questions_dblog/2.0.x/agent/start.md](modules/captcha_questions_dblog/2.0.x/agent/start.md).

## Docs

- **Configuration, config keys, form-protection mechanism, validation & logging** →
  [config/settings.md](config/settings.md)

## Mechanism (from source)

- `captcha_questions_form_alter()` runs only when `\Drupal::currentUser()->isAnonymous()`. If
  `$form_id` is in `captcha_questions_form_ids`, it adds a **required** `captcha_questions_answer_given`
  field (`textfield` on page 1, `hidden` on later pages of multi-page forms). `#title` is the
  question passed through **`Html::escape()`**; `#description` is the description via `t()`. It
  appends `captcha_questions_form_validate` to `$form['#validate']`.
- `captcha_questions_form_validate()` lowercases the given answer (`mb_strtolower`) and the accepted
  answers (`array_map('strtolower', …)`), then `in_array($answer_given, $answers)`. On mismatch it
  sets `Invalid answer` and (if enabled) logs. **Case-insensitive by design.**
- The correct answer is **never sent to the browser** — only the question text is rendered.

## Notes

- A **static** Q&A is weak against targeted/scripted attackers (fixed answers are scriptable);
  best for low-sophistication bot spam. Rotate questions; combine with rate limiting/honeypot for
  serious abuse. The maintainer recommends questions easy enough to embed the answer.
- Answers are stored as an array in config; on save they are `trim`med and `asort`ed.
