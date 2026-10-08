# Quiz - Long answer — agent index

Adds the **`long_answer`** (essay / multi-paragraph) question type to Quiz. The taker writes a
free-text response that a **human grades manually** against an optional rubric. Parent engine:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md) (shared `quiz.question`
plugin contract:
[../../../../7.1.x/agent/plugins/question-types.md](../../../../7.1.x/agent/plugins/question-types.md)).
Depends only on `quiz`. No configure route, no permissions, no Drush.

- **The `long_answer` question type — plugin, response class, fields, manual grading** →
  [plugins/question-type.md](plugins/question-type.md)
- **The one module setting (`quiz_long_answer.settings:default_max_score`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Plugin: `LongAnswerQuestion` (`#[QuizQuestion(id: 'long_answer')]`), response handler
  `LongAnswerResponse`. Namespace `Drupal\quiz_long_answer\Plugin\quiz\QuizQuestion`.
- Config bundles: `quiz.question.type.long_answer`, `quiz.result.answer.type.long_answer`.
- Question fields: `long_answer_rubric` (`text_long`), `answer_text_processing` (`boolean`).
  Answer field `long_answer` (`text_long`) on the answer bundle.
- **Not auto-scored**: `LongAnswerResponse::score()` returns `NULL` and calls
  `setEvaluated(FALSE)` — answers wait in Quiz's unevaluated-results queue for a grader.
- Config object `quiz_long_answer.settings` (`default_max_score`, default `10`).
