Quiz lets you build graded, interactive quizzes in Drupal — assessments and surveys made of reusable questions, taken online, scored (auto or manual), with per-attempt results and configurable feedback. It needs at least one question-type submodule (multichoice, true/false, short/long answer, matching) enabled to be usable.

---

Quiz 7.x is a full entity-based rewrite for Drupal 10/11. It defines its own content entities — `quiz` (the quiz, a bundle-able entity with a `quiz` type), `quiz_question` (a reusable question, bundled by `quiz_question_type`), `quiz_question_relationship` (which questions belong to which quiz, with weight/parent for pages), `quiz_result` (one attempt) and `quiz_result_answer` (one answered question in an attempt), plus config-entity bundles `quiz_type`, `quiz_result_type`, `quiz_result_answer_type` and `quiz_feedback_type`. Question types are **plugins**: the `plugin.manager.quiz.question` manager discovers classes in each module's `Plugin/quiz/QuizQuestion/` namespace carrying the `#[QuizQuestion]` attribute, each paired with a `quiz_question_type` config entity of the same id. Global behaviour lives in `quiz.settings` (revisioning, timer, result pruning, review/feedback options) edited at `/admin/quiz/config/quiz`; per-quiz behaviour (randomization, attempts, pass rate, backwards navigation, resume, jumping, time limit) lives as base fields on each quiz entity. Taking a quiz runs through `entity.quiz.take` / `quiz.question.take` controllers backed by the `quiz.session` service, and feedback types are Rules components so administrators can build conditional feedback. Quiz integrates Views (question bank, results, unevaluated results, per-user results), Rules events on its entities, and Views Bulk Operations. It ships no Drush commands.

---

- Build a graded multiple-choice quiz for a training course and score attempts automatically.
- Create a certification exam with a pass rate and pass/fail result messaging.
- Assemble a reusable **question bank** and pull random questions into different quizzes.
- Add true/false, short-answer, long-answer (essay) and matching questions to one quiz.
- Manually grade essay (long answer) responses from an "unevaluated results" queue.
- Limit the number of attempts a user may take a quiz, and show remaining attempts.
- Put a time limit on a quiz and display a countdown timer to the taker.
- Randomize question order, or pull N random questions from a pool for each attempt.
- Group questions into pages (via quiz_page) so takers answer several per screen.
- Insert directions/instructions between questions (via quiz_directions), unscored.
- Allow or forbid backwards navigation, skipping, jumping, resuming, and changing answers.
- Show conditional feedback based on score using Rules-powered feedback types.
- Configure exactly what a taker sees after each question and after the whole quiz (review options).
- Keep only the best/last/all results per user and auto-prune partial or invalid attempts.
- Report per-user and per-quiz results through the shipped Views (quiz_results, quiz_user_results).
- Let quiz authors view, score, and delete results for their own quizzes via granular permissions.
- Require questions to be repeated until answered correctly.
- Build "each attempt builds on the last" quizzes that only re-ask previously wrong questions.
- Run assessments as surveys where feedback and scoring are de-emphasised.
- Clone an existing quiz or question set (with the suggested Replicate module).
- Trigger custom actions on quiz/answer save via Rules events and Quiz entity hooks.
- Add an AJAX single-page quiz-taking experience (via ajax_quiz).
- Expose custom feedback options to administrators with `hook_quiz_feedback_options()`.
- Restrict who can take, author, score, or administer quizzes with per-bundle permissions.
- Embed quiz results and question banks in dashboards using the provided Views.
- Auto-generate question titles from the question text (with an optional permission to edit titles).
- Bulk-manage questions in a quiz with Views Bulk Operations (add from bank, reorder).
