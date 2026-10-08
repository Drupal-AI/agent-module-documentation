<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reading Rating scores the readability of a text field and shows the result to the editor, live, as they type. Enabled per field in the form display; the whole calculation runs client-side in JavaScript.

---

The mechanism is deliberately small. You enable it per field on a form display (the field's widget gear → "Reading Rating Settings" → "Enable Reading Rating", optionally "Enable grade level"), which stores a third-party widget setting. At render time the module's `#process` callback tags the textarea with a `reading-rating` class, attaches its library, and appends a themed widget below the field. From there everything is browser-side: a bundled copy of TextStatistics.js (`js/text-statistics.js`) computes the **Flesch Reading Ease** score and the **Flesch–Kincaid grade level** on `keyup`/`change`/`paste`, for both plain textareas and CKEditor 5 instances, and the widget highlights one bucket — Easy / Moderate / Difficult, and optionally an Elementary-through-College-graduate grade band. Nothing is submitted, stored, or validated: no score is written to the entity, no request is made, and submission is never blocked. Version **1.2.1** on core `^10 || ^11`, depending on core `field_ui`; the only permission, `manage reading rating`, gates a settings form at `/admin/config/content/reading-rating` where the bucket labels are made **configurable and translatable** (via core `config_translation`). Three things to be honest about when recommending it. **The formulas are English-specific** — syllable counting assumes English orthography, so a score on German, Finnish or Welsh text is arithmetic without meaning, and a multilingual site needs a per-language answer or none. **They measure form, not sense** — a passage of short sentences full of undefined jargon scores well and communicates nothing, the exact failure mode of writing to a score. And **a target is guidance, not a gate** — this module wisely only displays the number and leaves the judgement with the writer. Supported widgets out of the box: `string_textarea`, `text_textarea`, and `text_textarea_with_summary`; other widgets can opt in via `hook_reading_rating_widget_settings()`.

---

- Show editors a live readability score as they write.
- Meet a plain-language requirement on public-sector content.
- Support a government style guide's target reading age.
- Improve the clarity of health information.
- Give editors objective, actionable feedback on sentence and word length.
- Encourage shorter sentences and simpler words.
- Support an accessibility programme's plain-language goals.
- Add a grade-level band (Elementary → College graduate) alongside the Easy/Moderate/Difficult rating.
- Improve overall public-sector content quality.
- Review readability in the edit form before publishing.
- Back an editorial standards policy with a visible metric.
- Score help text and instructional copy for clarity.
- Improve a dense policy page's readability.
- Train new editors on writing to a readability target.
- Relabel the rating buckets ("Easy", "Moderate", …) to house wording via the settings form.
- Translate the rating and grade labels with `config_translation`.
- Enable readability scoring on a CKEditor 5 body field.
- Enable it on a plain (non-WYSIWYG) long-text field.
- Flag overly complex passages to the author without blocking save.
- Extend support to a custom text widget via `hook_reading_rating_widget_settings()`.
- Support a content-design practice with in-form feedback.
- Meet a charity or NGO's accessibility commitment on written content.
