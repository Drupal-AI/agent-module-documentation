<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Textfield Counter provides drop-in replacement field widgets for core's text fields and text areas that show a live character counter (counting down remaining characters as the user types) and can enforce a maximum length on submission.

---

The module ships five field widgets, each extending the matching core widget and adding a counter: `string_textfield_with_counter` (string), `string_textarea_with_counter` (string_long), `text_textfield_with_counter` (text), `text_textarea_with_counter` (text_long) and `text_textarea_with_summary_and_counter` (text_with_summary). You select one on a field's *Manage form display* page; there is no global settings form (`configure` is null). Each widget adds settings stored on the entity-form-display component: `maxlength` (the character limit; **0 disables the counter**), `counter_position` (`before`/`after`, default `after`), `js_prevent_submit`, `count_only_mode`, `count_html_characters`, and a customizable `textcount_status_message` using the tokens `@maxlength`, `@current_length` and `@remaining_count`. The textfield widgets additionally offer `use_field_maxlength` to reuse the field's storage max-length; the summary widget adds `enable_summary`/`summary_maxlength`. A JS library (`textfield_counter/counter`) drives the live count via `drupalSettings`. Server-side validation (`validateFieldFormElement`) blocks form submission with a form error when the value exceeds `maxlength`, unless `count_only_mode` is on (count without enforcing). `count_html_characters` decides whether markup/tags are included in the length (uncheck it for CKEditor fields). Reusable logic lives in `TextFieldCounterWidgetTrait` for building your own counter widget.

---

- Show a live "characters remaining" counter under a Title-like plain-text field.
- Enforce a hard 280-character limit on a "tweet"/social-post text field, blocking over-limit submissions.
- Add a counter to a formatted (CKEditor) body field while excluding HTML markup from the count.
- Limit a meta-description field to 160 characters with a visible countdown.
- Put the counter *before* the field instead of after it via `counter_position`.
- Let editors see the count but never block submission by enabling `count_only_mode`.
- Add client-side (JS) submission prevention on top of server validation with `js_prevent_submit`.
- Reuse the field's configured storage max-length as the counter limit via `use_field_maxlength`.
- Add a counter to a "summary" textarea and its main body independently (summary widget).
- Customize the counter message wording/markup with `textcount_status_message` and its `@remaining_count` token.
- Count HTML characters (including tags) for a raw-HTML field by enabling `count_html_characters`.
- Disable the counter on a specific field by setting `maxlength` to 0 while keeping the widget.
- Give content authors immediate feedback so they trim text before hitting a database column limit.
- Apply a character limit to a taxonomy term or media entity text field via that entity's form display.
- Standardize character limits across content types by configuring each field's widget.
- Constrain a plain long-text field (`string_long`) such as an SMS body.
- Prevent editors from exceeding a downstream API's field-length constraint.
- Build a custom counter widget for a contrib field type by using `TextFieldCounterWidgetTrait`.
- Show the maximum, current and remaining counts inline using the three status tokens.
- Warn editors approaching the limit while the counter counts down in real time.
- Keep the counter accurate for multi-value fields (each delta gets its own counter).
- Enforce a summary-length cap separately from the body with `summary_maxlength`.
- Export the widget configuration as config for repeatable deployment across environments.
