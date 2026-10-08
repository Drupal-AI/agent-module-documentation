Quiz - Multichoice adds a **Multiple choice** question type to the Quiz module: a question with a list of alternatives (each with its own correct/incorrect flag, per-choice score and feedback), supporting single-answer or multiple-answer selection and optional answer shuffling.

---

The submodule registers a `multichoice` Quiz question plugin (`MultichoiceQuestion`,
`#[QuizQuestion(id: 'multichoice')]`) with its `quiz.question.type.multichoice` config entity
(bundle of `quiz_question`). A multichoice question carries the fields `alternatives`
(a Paragraphs reference to `multichoice` paragraphs — each holding `multichoice_answer`,
`multichoice_correct`, `multichoice_score_chosen`, `multichoice_score_not_chosen`,
`multichoice_feedback_chosen`, `multichoice_feedback_not_chosen`), `choice_multi` (allow more
than one answer), `choice_boolean` (simple correct/incorrect scoring), and `choice_random`
(shuffle the alternatives per attempt). The answering widget is radios or checkboxes depending
on `choice_multi`; `MultichoiceResponse` scores by summing the chosen/not-chosen scores of the
alternatives. A module-level setting `quiz_multichoice.settings:scoring` selects the default
scoring model. It depends on `quiz` and `field_group` (used to group the alternative fields on
the question form). No configure route, permissions, or Drush of its own.

---

- Add classic single-answer multiple-choice questions to a quiz.
- Build "select all that apply" questions with `choice_multi` enabled (checkboxes).
- Give each alternative its own points for being chosen or not chosen.
- Attach per-alternative feedback shown when that option is (or isn't) selected.
- Shuffle answer order every attempt with `choice_random` to deter memorisation.
- Use simple correct/incorrect scoring via `choice_boolean` for straightforward questions.
- Create graded knowledge checks with 3-5 plausible distractors.
- Penalise wrong selections with negative not-chosen scores.
- Reuse a multiple-choice question across quizzes from the question bank.
- Mix multiple-choice with true/false and short-answer items in one quiz.
- Author alternatives as Paragraphs so choices are structured, orderable content.
- Randomly pull multiple-choice questions from a pool into each quiz attempt.
- Provide "best answer" questions where one option scores higher than others.
- Build survey-style multi-select questions where all selections score.
- Show the correct alternative(s) in the after-quiz review/solution.
- Auto-grade multiple-choice answers without manual review.
- Set the default scoring model site-wide via `quiz_multichoice.settings:scoring`.
- Create multichoice questions in code with `QuizQuestion::create(['type'=>'multichoice', …])`.
- Group the alternative sub-fields cleanly on the edit form using field_group.
- Warn authors when the correct-answer count does not match the single/multiple setting.
- Support partial credit across several correct alternatives.
- Build exam questions with weighted, feedback-rich options.
- Localise/translate alternatives per language.
- Assemble large multiple-choice question banks for reuse.
