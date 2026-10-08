<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Reading Rating on a text field

Reading Rating is turned on **per field, per form display** — it is not a field type or a formatter,
it is a third-party setting on the field's **widget**. Enabling it makes a live readability rating
appear below that field in the edit form.

## Steps (UI)
1. Go to the form display: **Structure → (content type / block type / paragraph) → Manage form display**.
2. Click the **gear** icon at the right of a supported text field.
3. Expand **Reading Rating Settings** at the bottom of the widget settings.
4. Check **Enable Reading Rating**. Optionally check **Enable grade level** to also show a
   grade band (Elementary school → College graduate).
5. Click **Update**, then **Save** the form display.
6. Open an edit form containing that field — a "Reading Rating" section now sits below the field and
   updates as you type.

## Supported widgets (out of the box)
Only these core text widgets expose the setting (see `WidgetSettings::getAllowedSettingsForAll()`):

| Widget plugin id | Reading rating | Summary field |
| --- | --- | --- |
| `string_textarea` | yes | no |
| `text_textarea` | yes | no |
| `text_textarea_with_summary` | yes | no (summary rating is a planned feature) |

`text_textarea` / `text_textarea_with_summary` are the CKEditor 5 / formatted long-text widgets;
`string_textarea` is a plain (non-WYSIWYG) long-text widget. Single-line `string_textfield` and
other widgets are **not** supported unless added via the hook (see
[../api/widget-settings-hook.md](../api/widget-settings-hook.md)).

## What happens under the hood
- The two checkboxes are stored as third-party settings `reading_rating.enable_reading_rating` and
  `reading_rating.enable_grade_level` on the widget.
- `hook_field_widget_single_element_form_alter()` copies these onto the element as
  `#enable_reading_rating` / `#enable_grade_level`.
- The `#process` callback `ReadingRatingCallbacks::readingRatingProcess()` then adds the
  `reading-rating` class, attaches the `reading_rating/reading_rating` library, and renders the
  `reading_rating_widget` template as a `#suffix`.
- All scoring is **client-side** (`js/reading-rating.js` + bundled `js/text-statistics.js`).
  There is no server round-trip, no stored score, and no submit-time validation.

## Gotchas
- Nothing appears if the field's widget is not one of the supported ids — check Manage form display.
- After upgrading from 1.1.x you must run `drush updb`, or the rating/grade **labels** render empty
  (updates 10001/10002 seed `reading_rating.settings:text_replacements`).
- Scores are meaningful for **English** text only; the syllable heuristics assume English.
