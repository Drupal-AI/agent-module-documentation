AJAX Quiz makes a Quiz load successive questions in the same page via AJAX, without a full page reload, for users who hold the "access ajax quiz" permission. Note: the maintainers explicitly warn it does not degrade gracefully and is not recommended for production yet.

---

The submodule adds **no entities, question types, or settings** — it is a pure behaviour
add-on. `ajax_quiz_form_alter()` targets the Quiz answering flow forms
(`quiz_question_answering_form` and `quiz_report_form`) and, only when the current user has the
**`access ajax quiz`** permission, wraps the form in an `#ajax-quiz-wrapper` div and attaches
an `#ajax` callback (`ajax_quiz_navigate_quiz`) to each submit button in the form's navigation.
That callback advances the quiz using the `quiz.session` service (temporary result, current
question, layout) and returns AJAX commands that replace the wrapper with the next question's
answering form (or feedback), updates the progress counter, and redirects to the result page
when the quiz completes. It depends only on `quiz`; no configure route, config schema, or Drush.

---

- Load the next quiz question in place without a full page reload.
- Give quiz-taking a smoother, single-page feel for eligible users.
- Gate the AJAX experience behind the `access ajax quiz` permission per role.
- Keep the quiz progress counter updated as questions advance via AJAX.
- Reduce perceived latency between questions on a quiz.
- Offer AJAX quiz-taking only to authenticated users (or a specific role).
- Advance through question feedback without reloading the page.
- Redirect to the results page automatically when the AJAX quiz finishes.
- Layer AJAX behaviour onto existing quizzes without changing their content.
- Turn the enhancement on/off simply by granting or revoking the permission.
- Prototype a single-page quiz UX on a staging site.
- Combine with standard question types (all still work as questions).
- Keep the non-AJAX flow for users without the permission.
- Wrap the answering and report forms in an AJAX container automatically.
- Use `quiz.session` to track the current attempt during AJAX navigation.
- Evaluate whether AJAX quiz-taking suits your audience before wider rollout.
- Provide a snappier experience for short, low-stakes quizzes.
- Avoid full reloads on mobile connections during a quiz.
- Restrict the experimental behaviour to testers via a dedicated role.
- Disable instantly by unassigning the permission if issues appear.
