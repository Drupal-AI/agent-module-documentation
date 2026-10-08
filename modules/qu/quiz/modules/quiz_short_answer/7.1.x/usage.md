Quiz - Short answer adds a **Short answer** question type to the Quiz module: the taker types a short text response that can be graded automatically (exact match, case-insensitive, or regular expression) or marked for manual grading.

---

The submodule registers a `short_answer` Quiz question plugin (`ShortAnswerQuestion`,
`#[QuizQuestion(id: 'short_answer')]`) with the `quiz.question.type.short_answer` config
entity (bundle of `quiz_question`). A short-answer question stores the expected answer in
`short_answer_correct` (text) and a grading mode in `short_answer_evaluation`
(a `list_integer`: `0` = automatic case-sensitive match, `1` = automatic case-insensitive
match, `2` = match against a regular expression, `3` = manual grading). The taker answers in a
single "Answer" textfield; `ShortAnswerResponse` scores automatic modes against
`short_answer_correct` and leaves manual questions for an evaluator. The maximum score defaults
to the module setting `quiz_short_answer.settings:default_max_score` (shipped as `5`). It
depends only on `quiz`; no configure route, permissions, or Drush of its own.

---

- Ask a question that expects a specific typed word or phrase.
- Auto-grade answers by exact, case-sensitive match.
- Auto-grade answers ignoring capitalisation (case-insensitive).
- Accept several spellings/variants by grading against a regular expression.
- Flag open short answers for manual grading by an evaluator.
- Fill-in-the-blank style questions ("The capital of France is ___").
- Vocabulary or terminology recall checks.
- Numeric/short-code answers validated with a regex pattern.
- Set the default points per short-answer question via `default_max_score` (default 5).
- Mix short-answer with multiple-choice and true/false in one quiz.
- Reuse a short-answer question across quizzes from the question bank.
- Grade language-learning prompts where the exact target word matters.
- Require a precise API name, command, or key term as the answer.
- Provide per-question feedback explaining the expected answer.
- Create short-answer questions in code with `QuizQuestion::create(['type'=>'short_answer', …])`.
- Use regex mode to accept "color"/"colour" or optional punctuation.
- Build partially auto-graded quizzes, sending only ambiguous items to manual review.
- Assess definitions where a keyword must appear.
- Localise the expected answer per language.
- Combine auto short answers with manually graded long-answer essays.
- Seed demo quizzes with quick typed-answer questions.
- Enforce whole-word answers via anchored regular expressions.
