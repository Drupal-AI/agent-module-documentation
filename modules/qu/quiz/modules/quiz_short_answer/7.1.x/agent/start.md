# Quiz - Short answer — agent index

Adds the **`short_answer`** question type to Quiz: the taker types a short text response that is
graded automatically (exact / case-insensitive / regex match against a stored answer) or left
for manual grading. Parent engine:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md) (shared `quiz.question`
plugin contract:
[../../../../7.1.x/agent/plugins/question-types.md](../../../../7.1.x/agent/plugins/question-types.md)).
Depends only on `quiz`. No configure route, no permissions, no Drush.

- **The `short_answer` question type — plugin, response class, evaluation modes, fields** →
  [plugins/question-type.md](plugins/question-type.md)
- **The one module setting (`quiz_short_answer.settings:default_max_score`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Plugin: `ShortAnswerQuestion` (`#[QuizQuestion(id: 'short_answer')]`), response handler
  `ShortAnswerResponse`. Namespace `Drupal\quiz_short_answer\Plugin\quiz\QuizQuestion`.
- Config bundles: `quiz.question.type.short_answer`, `quiz.result.answer.type.short_answer`.
- Question fields: `short_answer_correct` (`string`, the expected answer/regex),
  `short_answer_evaluation` (`list_integer`, grading mode, default `1`). Answer field
  `short_answer` (`string`).
- Evaluation modes (constants on `ShortAnswerQuestion`): `0` match, `1` case-insensitive match,
  `2` regex (`preg_match`), `3` manual.
- Config object `quiz_short_answer.settings` (`default_max_score`, default `5`).
