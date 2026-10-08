# Quiz - Matching — agent index

Adds the **`matching`** question type to Quiz: the taker pairs each prompt with its correct
answer from a set of question/answer pairs. Parent engine:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md) (the shared
`quiz.question` plugin type is documented there —
[../../../../7.1.x/agent/plugins/question-types.md](../../../../7.1.x/agent/plugins/question-types.md)).
Depends on `quiz` and `paragraphs`. No configure route, no permissions, no Drush.

- **The `matching` question type — plugin, response/scoring class, fields, create in code** →
  [plugins/question-type.md](plugins/question-type.md)
- **The one module setting (`quiz_matching.settings:shuffle`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Plugin: `MatchingQuestion` (`#[QuizQuestion(id: 'matching')]`), response handler
  `MatchingResponse`. Both under `Drupal\quiz_matching\Plugin\quiz\QuizQuestion`.
- Config bundles: `quiz.question.type.matching` (bundle of `quiz_question`),
  `quiz.result.answer.type.matching` (bundle of `quiz_result_answer`).
- Question field `quiz_matching` (required, `entity_reference_revisions` → `quiz_matching`
  paragraphs) holds the pairs; `choice_penalty` (boolean) subtracts a point per wrong match.
- Max score = number of pairs (one point per correct match). Auto-graded.
- Config object: `quiz_matching.settings` (`shuffle`). Schema in
  `config/schema/quiz_matching.schema.yml`.
