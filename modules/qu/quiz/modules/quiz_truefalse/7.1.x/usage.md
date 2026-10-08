Quiz - True false adds a **True/false** question type to the Quiz module: a single-statement question the taker answers True or False, auto-graded, worth exactly 1 point.

---

The submodule registers a `truefalse` Quiz question plugin (`TrueFalseQuestion` in
`Plugin/quiz/QuizQuestion/`, `#[QuizQuestion(id: 'truefalse')]`) plus its matching
`quiz.question.type.truefalse` config entity (a bundle of `quiz_question`) and a
`quiz.result.answer.type.truefalse` answer bundle. Each truefalse question stores the correct
answer in the `truefalse_correct` field (a `list_integer` with allowed values `1` = True,
`0` = False). The taker sees a radios widget ("Choose one" → True / False); the paired
`TrueFalseResponse` (`quiz_result_answer` subclass) scores the submitted answer, awarding
`getMaximumScore()` (always `1`) for a match and `0` otherwise, and records the response in
`truefalse_answer`. It has no settings form, configure route, permissions, or Drush of its
own — it is a pure question-type provider that depends only on `quiz`.

---

- Add fast, auto-graded True/False questions to any quiz.
- Test recall of simple factual statements ("The Earth is flat" → False).
- Build a quick knowledge-check with only yes/no style items.
- Mix True/False items with multiple-choice and short-answer questions in one quiz.
- Reuse a True/False question across several quizzes from the question bank.
- Auto-score boolean questions without any manual grading.
- Set the correct answer per question via the `truefalse_correct` field (1=True, 0=False).
- Give every True/False item a fixed weight of 1 point in the quiz's max score.
- Create True/False questions programmatically with `QuizQuestion::create(['type'=>'truefalse', …])`.
- Use True/False items for compliance or policy acknowledgement checks.
- Provide per-question feedback on why a statement is true or false.
- Seed a demo quiz with simple True/False content.
- Convert survey-style agree/disagree prompts into gradable True/False questions.
- Assess reading comprehension with statement-verification items.
- Build onboarding quizzes with unambiguous binary answers.
- Randomize a pool that includes True/False questions.
- Keep quiz-taking quick by favouring single-click True/False answers.
- Show the correct True/False solution in the after-quiz review options.
- Use True/False items where multiple choice would give away the answer.
- Add True/False checkpoints between training modules.
