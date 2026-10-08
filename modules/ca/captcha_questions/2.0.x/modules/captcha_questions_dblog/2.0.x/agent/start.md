<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Captcha questions dblog (captcha_questions_dblog) — agent index

Optional submodule of **captcha_questions**. Logs **failed** captcha submissions to a dedicated DB
table and shows an admin report. Package **Spam control**. Depends on
`captcha_questions:captcha_questions`. Core `^8 || ^9 || ^10 || ^11`. GPL-2.0-or-later. Version 2.0.2.

## What it provides

- **Schema** (`captcha_questions_dblog.install`, `hook_schema`): table **`captcha_questions_dblog`**
  with columns `dblogid` (serial PK), `timestamp` (int), `ip` (varchar 40), `form_id` (varchar 40),
  `question_asked` (varchar 255), `answer_given` (varchar 255), `answer_correct` (varchar 255);
  indexes on `dblogid` and `timestamp`. `hook_install` shows a message linking to the settings page.
- **Route** `captcha_questions_settings.failed_submissions` →
  `/admin/config/people/captcha_questions/failed_submissions`, controller
  `CaptchaQuestionsDblogController::captchaQuestionsDblogView`, permission
  **`administer captcha questions settings`** (the parent module's permission). Local task tab under
  the settings page (`captcha_questions_dblog.links.task.yml`).
- **Controller** `src/Controller/CaptchaQuestionsDblogController.php` (`ControllerBase`, DI:
  `date.formatter`, `database`). No entities, plugins, services, permissions of its own, or config.

## Mechanism (from source)

- **Writes** happen in the *parent* module's `captcha_questions_form_validate()`: when a wrong answer
  is given **and** `captcha_questions_dblog` config is on **and** the submodule is enabled, it
  `\Drupal::database()->insert('captcha_questions_dblog')` a row via the parameterized fields()
  builder. `question_asked` and `answer_given` are stored through `Html::escape()`; `answer_correct`
  is `implode(",", $answers)` (the accepted answers, lowercased).
- **Read/report**: `captchaQuestionsDblogView()` builds a `select('captcha_questions_dblog')` with
  the seven fields, extended by `TableSortExtender->orderByHeader($header)` and
  `PagerSelectExtender->limit(5)`. Rows render via `#theme => 'table'` (core escapes cells);
  `question_asked` is truncated with `Unicode::truncate(…, 30, …)`; timestamps formatted `Y-m-d H:m:s`.
  Shows a "Found a total of N failed submissions" count plus a pager.

## Notes

- Parent doc: [../../../../agent/start.md](../../../../agent/start.md);
  parent config keys incl. `captcha_questions_dblog` toggle: [../../../../agent/config/settings.md](../../../../agent/config/settings.md).
- Enable the submodule, then tick "Enable logging internal database table" on the parent settings
  form for rows to be written; uninstalling drops the table.
- Report and writes both use parameterized queries (no string-concatenated SQL); report access is
  gated by the parent admin permission.
