<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Captcha questions — configuration & form protection

## Install / enable

`drush en captcha_questions`. No dependencies. Optional: also enable `captcha_questions_dblog`
for DB-table logging, and core `dblog` for watchdog logging. Configure at
**`/admin/config/people/captcha_questions`** (permission `administer captcha questions settings`;
menu link under *People*).

## Config object `captcha_questions.settings`

Defaults ship in `config/install/captcha_questions.settings.yml`. **No config schema** is provided
(`config/schema/` absent), so values are untyped.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `captcha_questions_question` | string | `'What is Mickeys last name? Its Mouse.'` | The question shown as the field label. |
| `captcha_questions_answers` | array | `['Mouse']` | Accepted answers, one per line in the UI; compared case-insensitively. |
| `captcha_questions_answer` | string | `'Mouse'` | Legacy single-answer value; still deleted on empty save but not used for validation. |
| `captcha_questions_description` | string | `'Please answer the question'` | Field description under the question. |
| `captcha_questions_form_ids` | array | `[]` | The `form_id`s to protect. |
| `captcha_questions_watchdog` | int/bool | `0` | Log failed submissions to Drupal log (watchdog). |
| `captcha_questions_dblog` | int/bool | `0` | Log failed submissions to the submodule's DB table. |
| `webform_node_types` | array | `['webform']` | Present in install config; not read by current code. |

## Settings form (`CaptchaQuestionsSettingsForm`, `src/Form/`)

`ConfigFormBase` (form id `captcha_questions_settings_form`), DI: `config.factory`, `module_handler`,
`database`, `messenger`.

- **Logging options**: "Log to watchdog" (disabled unless core `dblog` enabled), "Enable logging
  internal database table" (disabled unless `captcha_questions_dblog` enabled).
- **CAPTCHA**: question (required, maxlength 256), accepted answers (required textarea, one per
  line), description (maxlength 256).
- **Form protection**: a checkboxes list built by `captchaQuestionsGetFormIds()` — a hard-coded set
  (`contact_site_form`, `contact_personal_form`, `user_register_form`, `user_pass`,
  `user_login_form`, `user_login_block`, `forum_node_form`), plus `comment_node_<type>_form` for
  each node type, plus discovered Webform forms (`captchaQuestionsGetWebforms()` →
  `webform_submission_<id>_form`), plus previously-saved custom ids. An AJAX "Add custom form_id"
  button (`captchaQuestionsAddForm` / `captchaQuestionsAddFormCallback`) appends a typed form_id.
- **`validateForm()`**: requires question+answer together (error if one is set without the other).
- **`submitForm()`**: deletes question/answer/description config when emptied; splits the answers
  textarea on `\n`, `trim`s and `asort`s into `captcha_questions_answers`; counts selected forms
  and messages "N forms protected" / "No forms selected"; saves all keys.

## How protection works at runtime

`captcha_questions.module`:
- `captcha_questions_form_alter()` acts **only for anonymous users** and only when `$form_id` is in
  `captcha_questions_form_ids`. It adds a **required** `captcha_questions_answer_given` field
  (`textfield` on page 1, `hidden` on later pages via `$form['details']['page_num']['#value']`),
  with `#title => Html::escape($question)` and a `t()` description, and registers
  `captcha_questions_form_validate` as a validate handler.
- `captcha_questions_form_validate()` lowercases the submitted answer (`mb_strtolower`) and every
  accepted answer (`array_map('strtolower', …)`) and checks `in_array()`. On mismatch it sets
  `setErrorByName('captcha_questions_answer_given', 'Invalid answer')`.
- **Logging on failure** (only when a wrong answer is given): if `captcha_questions_watchdog` is on
  and `dblog` present, logs form_id + answer given via `logger('captcha_questions')->error()`; if
  `captcha_questions_dblog` is on and the submodule is enabled, inserts a row into the
  `captcha_questions_dblog` table (see the submodule doc).

## Routes & permissions

- `captcha_questions_settings` → `/admin/config/people/captcha_questions`, `_form` =
  `CaptchaQuestionsSettingsForm`, `_permission: administer captcha questions settings`.
- Permission `administer captcha questions settings` (`captcha_questions.permissions.yml`): grants
  configuration access; holders are **not** shown the challenge (the alter runs for anonymous only).

## Config export example

```yaml
# config/sync/captcha_questions.settings.yml
captcha_questions_question: 'What is 1+1?'
captcha_questions_answers:
  - '2'
  - 'two'
captcha_questions_description: 'Type the answer as a number or word'
captcha_questions_form_ids:
  user_register_form: user_register_form
  contact_site_form: contact_site_form
captcha_questions_watchdog: 1
captcha_questions_dblog: 0
```
