<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: dga_rating.settings

Source: `config/schema/dga_rating.schema.yml`, `config/install/dga_rating.settings.yml`,
`dga_rating.install` (`hook_install`), `src/Form/DgaRatingSettingsForm.php`,
`src/Form/RatingTranslationForm.php`.

## Config object

A single `config_object` `dga_rating.settings`. The shipped `config/install/dga_rating.settings.yml`
only sets the three security limits (`rate_limit_max_submissions: 20`, `rate_limit_time_window:
3600`, `feedback_max_length: 5000`); **all the bilingual text defaults and menu titles are written
in `dga_rating_install()`** instead (the install file notes translation keys use `_en`/`_ar`
suffixes). Re-running install (module reinstall) restores those defaults.

## Schema groups (`config/schema/dga_rating.schema.yml`)

- **English text** (`*_en`, type `string`): `average_text`, `reviews_text`, `rate_button_text`,
  `form_title`, `form_description`, `close_button_text`, `rating_question`, `rating_instructions`,
  `rating_aria_label`, `feedback_label`, `submit_button_text`, `submitted_rating_text`,
  `submitted_success_text`, `star_singular`, `star_plural`, `thank_you`, `error_message`.
- **Arabic text** (`*_ar`, type `string`): the same set with Arabic defaults.
- **Validation messages** (`string`): `validation_rating_required_en/_ar`,
  `validation_feedback_required_en/_ar`, `validation_feedback_too_long_en/_ar`.
- **Security / behavior** (`integer`):
  - `rate_limit_max_submissions` (default 20) — max anonymous submissions per IP per window;
    `0` disables anonymous rate limiting.
  - `rate_limit_time_window` (default 3600) — window in seconds.
  - `feedback_max_length` (default 5000) — max stored feedback characters (over-length is rejected
    on the endpoint and truncated in the service).
  - `refresh_delay` (default 3000) — widget auto-refresh delay in milliseconds.
- **Menu titles** (`string`): `menu_title_dga_rating_en/_ar`, `menu_title_dashboard_en/_ar`,
  `menu_title_settings_en/_ar`, `menu_title_translations_en/_ar`.

## Which keys the widget reads

`DgaRatingBlock::build()` and `DgaRatingController::submitRating()` read the **`_en`/`_ar`** keys
(chosen by current interface language, with EN fallback). The **`RatingTranslationForm`**
(`/admin/content/dga-rating/translations`) is the form that writes those `_en`/`_ar` keys from a
two-column EN/AR table — use it to change front-end text and validation messages.

Note: `DgaRatingSettingsForm` (`/admin/content/dga-rating/settings`) also declares
`dga_rating.settings` as its editable config but its text fields set unsuffixed keys (e.g.
`average_text`) that the widget does not read; the numeric behavior/limit fields it sets
(`rate_limit_*`, `feedback_max_length`, `refresh_delay`) are the effective ones. Prefer the
Translations form for widget text and the Settings form for the numeric limits.

## Operating the limits

- Tighten anti-spam: lower `rate_limit_max_submissions` and/or raise `rate_limit_time_window`.
  Anonymous submissions are counted per client IP (`Request::getClientIp()`).
- Bound stored feedback with `feedback_max_length`.
- Set `refresh_delay` (ms) to control how quickly the widget re-pulls stats after a submit.

Config schema is provided (`provides_config_schema: true`); the object is fully exportable via
the normal config-sync workflow.
