Quiz - Matching adds a **matching** question type to the Quiz module: the taker pairs each prompt with its correct answer from a set of question/answer pairs, scored one point per correct match.

---

The submodule registers a `matching` Quiz question plugin (`MatchingQuestion`,
`#[QuizQuestion(id: 'matching')]`) with the `quiz.question.type.matching` config entity
(bundle of `quiz_question`). Each matching question references its pairs through the
**required** `quiz_matching` field — a Paragraphs reference to `quiz_matching` paragraphs, each
holding a `matching_question` (the prompt) and a `matching_answer` (its correct match). An
optional `choice_penalty` field subtracts points for wrong matches. The module setting
`quiz_matching.settings:shuffle` controls whether the answer options are shuffled when
presented. `MatchingQuestion::getMaximumScore()` returns the **number of pairs**, so a question
with four pairs is worth four points. It depends on `quiz` and `paragraphs`; no configure
route, permissions, or Drush of its own.

---

- Ask the taker to match terms to their definitions.
- Pair countries with their capitals, authors with books, etc.
- Build vocabulary matching exercises for language learning.
- Match causes to effects or events to dates.
- Score one point per correctly matched pair automatically.
- Penalise incorrect matches with the `choice_penalty` option.
- Shuffle answer options per attempt via `quiz_matching.settings:shuffle`.
- Author pairs as structured `quiz_matching` Paragraphs (question + answer).
- Reuse a matching question across quizzes from the question bank.
- Mix matching with multiple-choice and short-answer questions in one quiz.
- Create image-label or symbol-meaning matching tasks.
- Assess relationships between concepts rather than isolated recall.
- Build "match the code to its output" style developer quizzes.
- Weight a matching question by its number of pairs (max score = pair count).
- Provide per-question feedback after a matching attempt.
- Create matching questions in code with `QuizQuestion::create(['type'=>'matching','quiz_matching'=>[…]])`.
- Localise prompts and answers per language.
- Assemble large matching question banks for reuse.
- Combine matching with essay questions in a mixed assessment.
- Use matching for compliance training (map policy to scenario).
- Grade term/definition pairing without manual review.
- Present a set of prompts and a shuffled pool of answers to choose from.
