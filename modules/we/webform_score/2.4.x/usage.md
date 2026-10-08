Adds automatic scoring to Webform submissions: special "Quiz" form elements carry a correct-answer/scoring configuration, and each submission gets a computed score (points and percentage) stored on a base field.

---

Webform Score turns webforms into quizzes/assessments. It ships four scorable "Quiz" webform elements — `webform_score_checkboxes`, `webform_score_radios`, `webform_score_select`, `webform_score_textfield` (category "Quiz") — that behave like their core counterparts but expose an extra *Quiz answer* section where the author picks a **scoring methodology** (a `webform_score` plugin) and its configuration (e.g. expected answer, max score). On submission save, `hook_webform_submission_presave` (via `HookService`) walks every element implementing `QuizInterface`, sums each element's awarded points and maximum, and writes the result to a `fraction` base field `webform_score` on the submission (numerator = scored, denominator = maximum). The score is exposed as a `fraction_percentage` display, three tokens (`[webform_submission:webform_score]` as a percentage, plus `webform_score_numerator`/`webform_score_denominator`), and can be shown on the submission page or in a View. The scoring logic itself is a pluggable `webform_score` plugin type (`@WebformScore` annotation, manager `plugin.manager.webform_score`); built-ins are `equals`, `contains` (string match), and the aggregation plugins `sum`, `maximum`, and `set_equals` for multi-value answers. Visibility of the score field is governed by two permissions — *view any submission score* and *view own submission score* — enforced through `hook_entity_field_access` (the field is never directly editable; it is calculated). Depends on Webform and Fraction.

---

- Build graded quizzes and knowledge checks with Webform's authoring UI.
- Auto-score multiple-choice questions (radios/select) against a correct option.
- Auto-score multi-answer checkbox questions (all-correct / partial via aggregation plugins).
- Score free-text answers by exact match (`equals`) or substring match (`contains`).
- Award custom point values per question via each element's max score.
- Show a submission's total as "X/Y" points and as a percentage.
- Display the score on the webform submission page.
- Surface scores in a View of submissions for a leaderboard or gradebook.
- Insert the score into confirmation messages/emails via the `[webform_submission:webform_score]` token.
- Track point-based progress across submissions.
- Restrict who can see scores using "view any" vs "view own" submission-score permissions.
- Hide scores entirely for forms where no element is configured to score (denominator 0 → forbidden).
- Case-sensitive or case-insensitive text grading via the `equals` plugin option.
- Aggregate several sub-answers with `sum` (add points) or `maximum` (best of a set).
- Require every value in a multi-value answer to match with `set_equals`.
- Add a brand-new scoring algorithm by writing a `webform_score` plugin.
- Alter or extend discovered scoring plugins via `hook_webform_score_info_alter`.
- Combine scored and non-scored elements in one form (only Quiz elements contribute to the score).
- Grade assessments without custom code by configuring existing plugins in the element form.
- Compute pass/fail downstream by comparing the numerator/denominator tokens.
