# Quiz — agent index

Entity-based quiz/assessment engine for Drupal 10/11. **Requires at least one question-type
submodule** (quiz_multichoice, quiz_truefalse, quiz_short_answer, quiz_long_answer,
quiz_matching) to be usable. Config UI at `/admin/quiz` (`configure: quiz.admin`); global
settings form at `/admin/quiz/config/quiz` (`quiz.admin.settings` → `QuizAdminForm`).

- **Global settings (`quiz.settings`) + per-quiz fields + quiz/result/feedback types** →
  [configure/settings.md](configure/settings.md)
- **The entity model + creating quizzes/questions/results in code + `quiz.session` service** →
  [api/entities.md](api/entities.md)
- **Define a new question type (the `quiz.question` plugin) — attribute, handlers, base class** →
  [plugins/question-types.md](plugins/question-types.md)
- **Hooks Quiz invites (`quiz.api.php`): feedback options/labels, `hook_quiz_access`, entity hooks** →
  [hooks/hooks.md](hooks/hooks.md)
- **Permissions (take/author/score/administer)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Content entities: `quiz`, `quiz_question`, `quiz_question_relationship`, `quiz_result`,
  `quiz_result_answer`. Config bundles: `quiz_type`, `quiz_question_type`, `quiz_result_type`,
  `quiz_result_answer_type`, `quiz_feedback_type`.
- Question types are plugins in `Plugin/quiz/QuizQuestion/` with `#[QuizQuestion(id=…)]`; each
  needs a matching `quiz.question.type.<id>` config entity (bundle of `quiz_question`).
- **No Drush commands.** Rules + Views + Views Bulk Operations + Paragraphs are dependencies.
- Take a quiz: `/quiz/{quiz}/take` (`entity.quiz.take`) → per-question `/quiz/{quiz}/take/{n}`.
