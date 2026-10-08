Quiz - Long answer adds an **essay / long answer** question type to the Quiz module: the taker writes a multi-paragraph response that a human grades manually against an optional rubric.

---

The submodule registers a `long_answer` Quiz question plugin (`LongAnswerQuestion`,
`#[QuizQuestion(id: 'long_answer')]`) with the `quiz.question.type.long_answer` config entity
(bundle of `quiz_question`). The question offers an optional grading `long_answer_rubric`
(text_long) and an `answer_text_processing` boolean (whether the answer uses a filtered text
format). Because essays cannot be auto-scored, `LongAnswerResponse::score()` calls
`setEvaluated(FALSE)` — the answer lands in Quiz's *unevaluated results* queue until an
evaluator (with the appropriate scoring permission) awards points up to the maximum, which
defaults to the module setting `quiz_long_answer.settings:default_max_score` (shipped `10`).
It depends only on `quiz`; no configure route, permissions, or Drush of its own.

---

- Ask open-ended essay questions that require a written response.
- Collect multi-paragraph answers for later human grading.
- Provide a grading rubric to the evaluator via `long_answer_rubric`.
- Route long answers into Quiz's "unevaluated results" queue for manual scoring.
- Set the default points for essay questions with `default_max_score` (default 10).
- Combine auto-graded questions with manually graded essays in one quiz.
- Assess reasoning, explanation, or argumentation that has no single correct answer.
- Let subject-matter experts score responses after the quiz is taken.
- Allow rich-text (filtered format) answers via `answer_text_processing`.
- Reuse an essay question across multiple quizzes from the question bank.
- Give partial credit on a 0–max scale when grading essays.
- Provide per-question feedback alongside the awarded essay score.
- Build take-home or reflective assessments with long-form answers.
- Grade case-study or scenario responses against a shared rubric.
- Create long-answer questions in code with `QuizQuestion::create(['type'=>'long_answer', …])`.
- Support language exams that require written composition.
- Use rubrics to standardise grading across multiple evaluators.
- Keep essays unreleased until a grader finalises the score.
- Mix short auto-graded answers with deeper essay questions in the same quiz.
- Assess coding explanations or design write-ups as free text.
- Seed a demo quiz with an essay prompt.
- Present writing prompts that build on earlier quiz questions.
