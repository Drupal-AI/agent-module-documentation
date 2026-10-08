<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, translations & config keys

All configuration lives in one config object: **`dga_feedback.settings`**
(schema `config/schema/dga_feedback.schema.yml`, defaults `config/install/dga_feedback.settings.yml`,
re-seeded by `hook_install`). There is no `configure` link in `*.info.yml`; two forms edit it.

## Two admin forms

- **Settings** — `/admin/config/dga-feedback/settings`, `DgaFeedbackSettingsForm`
  (`ConfigFormBase`), permission `administer dga feedback settings`. Edits the **default
  English** strings plus the numeric behavior/limit settings.
- **Translations** — `/admin/content/dga-feedback/translations`, `FeedbackTranslationForm`
  (`ConfigFormBase`), permission `administer dga feedback settings`. Edits every EN/AR
  string pair side by side (widget, reasons, validation, API/back-end messages, menu titles).

Both write to the same config object, so changes apply immediately (no `.po` files, no
locale/interface-translation dependency).

## String keys (each has `_en` and `_ar`)

Roughly 30 bilingual pairs, grouped:

- Closed state: `question_text`, `yes_button_text`, `no_button_text`, `stats_text_template`
  (uses `@percentage` and `@count` placeholders).
- Form: `close_button_text`, `reasons_title`, `reasons_instruction`, `reasons_yes`,
  `reasons_no` (newline-separated lists — one reason per line), `feedback_label`,
  `feedback_placeholder`, `gender_label`, `gender_male`, `gender_female`,
  `gender_prefer_not_to_say`, `submit_button_text`.
- Submitted state: `submitted_success_text`.
- Validation: `validation_yes_no_required`, `validation_reason_required`,
  `validation_reason_invalid`, `validation_feedback_required`, `validation_gender_required`,
  `validation_submission_failed`, `validation_unknown_error`, `button_submitting_text`.
- API/back-end: `api_method_not_allowed`, `api_invalid_json`, `api_invalid_useful`,
  `api_rate_limit`, `api_save_failed`, `api_success_message`.
- Menu titles: `menu_title_dga_feedback`, `menu_title_dashboard`, `menu_title_settings`,
  `menu_title_translations`.

Language resolution (in the block, controller, edit/admin code) prefers the AR value in
Arabic context, then AR default, then EN value/default; EN context prefers the EN value.
Reason lists are split on `\n` and trimmed; the reasons instruction should NOT include
parentheses (the template adds them).

## Numeric behavior / limit keys (single value, `integer`)

- `rate_limit_max_submissions` (default 20) — max submissions per identity in the window;
  `0` disables rate limiting.
- `rate_limit_time_window` (default 3600) — rate-limit window in seconds.
- `feedback_max_length` (default 5000) — feedback text is truncated to this length.
- `reason_max_length` (default 200) — reasons longer than this are dropped.
- `reason_max_count` (default 10) — extra reasons beyond this are ignored.
- `data_retention_days` (default 0) — cron purge age in days; `0` = keep indefinitely.
- `refresh_delay` (default 3000) — widget reset delay, stored in **ms** but the Settings form
  displays/accepts **seconds** (multiplied by 1000 on save).

These limits are read in `DgaFeedbackController::submitFeedback` and
`DgaFeedbackService::saveFeedback`/`updateSubmission` to bound and sanitize input.
