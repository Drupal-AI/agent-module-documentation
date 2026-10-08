<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# reading_rating — agent start

Shows editors a **readability rating** of a text field, live in the edit form, as they type.
The score is **Flesch Reading Ease** plus an optional **Flesch–Kincaid grade level**, computed
entirely **client-side** by a bundled copy of TextStatistics.js. Nothing is stored, submitted, or
validated — it only displays a rating below the field; save is never blocked. Depends on core
`field_ui`. Version **1.2.1**, core `^10 || ^11`.

## How it wires together
- Enabled **per field** on a form display via a third-party widget setting (`enable_reading_rating`,
  optional `enable_grade_level`). Set in `hook_field_widget_third_party_settings_form()`.
- At render, `ReadingRatingCallbacks::readingRatingProcess()` (a `#process` on `textarea`/`textfield`,
  added by `hook_element_info_alter()`) adds the `reading-rating` class, attaches the
  `reading_rating/reading_rating` library, and appends the `reading_rating_widget` theme below the field.
- `js/reading-rating.js` reads the field value (or CKEditor 5 data) on `keyup`/`change`/`paste`,
  runs `js/text-statistics.js`, and highlights the matching bucket. Thresholds:
  Reading Ease `<50` → Difficult, `<60` → Moderate, else Easy; grade `≤5/≤8/≤12/≤16/≤17`.
- Bucket + grade **labels** are configurable and translatable via `reading_rating.settings`
  (config schema + `config_translation`), edited at the settings form.

## Solution-type docs
- Turn it on for a text field, supported widgets, grade level → [fields/enable-on-field.md](fields/enable-on-field.md)
- Extend to a custom widget with the settings hook → [api/widget-settings-hook.md](api/widget-settings-hook.md)

## Config & permission
- Settings form: `/admin/config/content/reading-rating` (route `reading_rating.settings`),
  gated by the `manage reading rating` permission. Edits the 11 rating/grade label strings in
  `reading_rating.settings:text_replacements`. Strings are translatable via core `config_translation`.
- Upgrading from 1.1.x: **run `drush updb`** — updates 10001/10002 seed the default label config;
  without them the widget renders empty labels (a deprecated pre-render logs a warning to run updb).

## Honest limitations (for recommendations)
1. **English-specific.** Syllable counting assumes English orthography; a score on German, Finnish
   or Welsh text is arithmetic without meaning. Multilingual sites need a per-language answer or none.
2. **Measures form, not sense.** Short sentences full of undefined jargon score well and say nothing.
3. **Guidance, not a gate.** The module only displays the number and leaves judgement with the writer.
