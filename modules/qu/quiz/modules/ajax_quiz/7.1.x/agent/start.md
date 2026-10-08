# AJAX Quiz — agent index

A behaviour add-on for Quiz that loads successive questions in-page via AJAX (no full page
reload), for users holding the `access ajax quiz` permission. **No entities, question types,
config schema, or Drush.** Parent engine:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md). Depends only on `quiz`.
The maintainers warn it does not degrade gracefully and is not recommended for production.

- **How it hooks the quiz forms (form_alter + AJAX callback + `quiz.session`)** →
  [hooks/behavior.md](hooks/behavior.md)
- **The one permission (`access ajax quiz`)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `ajax_quiz_form_alter()` targets the forms `quiz_question_answering_form` and
  `quiz_report_form`, only when the current user has `access ajax quiz`.
- AJAX callback `ajax_quiz_navigate_quiz()` drives navigation via the `quiz.session` service
  (`Drupal\quiz\Services\QuizSessionInterface`), replacing `#ajax-quiz-wrapper` /
  `#quiz-progress` or issuing a `RedirectCommand` to the result page when finished.
- Pure procedural module (`ajax_quiz.module`) — no `src/`, services, or routes.
