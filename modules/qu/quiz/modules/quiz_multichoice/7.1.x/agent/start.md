# Quiz - Multichoice — agent index

Adds the **`multichoice`** question type to Quiz: a list of alternatives (each with its own
correct flag, per-choice score, and per-choice feedback), supporting single- or multiple-answer
selection and optional shuffling. Parent engine:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md) (shared `quiz.question`
plugin contract:
[../../../../7.1.x/agent/plugins/question-types.md](../../../../7.1.x/agent/plugins/question-types.md)).
Depends on `quiz` and `field_group`. No configure route, no permissions, no Drush.

- **The `multichoice` question type — plugin, response class, fields, scoring** →
  [plugins/question-type.md](plugins/question-type.md)
- **The one module setting (`quiz_multichoice.settings:scoring`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Plugin: `MultichoiceQuestion` (`#[QuizQuestion(id: 'multichoice')]`), response handler
  `MultichoiceResponse`. Namespace `Drupal\quiz_multichoice\Plugin\quiz\QuizQuestion`.
- Config bundles: `quiz.question.type.multichoice`, `quiz.result.answer.type.multichoice`.
- Alternatives are `multichoice` Paragraphs referenced by the `alternatives` field; toggles
  `choice_multi`, `choice_boolean`, `choice_random`.
- JS library `quiz_multichoice/helper` (`js/helper.js`) assists score/correct entry on the
  question edit form.
- Config object `quiz_multichoice.settings` (`scoring`, default `0`).
