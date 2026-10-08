<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Quiz Elements adds scored quiz elements to Webform — radio questions with a correct answer and per-answer feedback, a per-question result, and a total-score element — so a quiz is just a webform.

---

Install with `composer require drupal/webform_quiz_elements` and enable it; it requires the **Webform** module (`^6`) and targets Drupal `^10.1 || ^11`. Everything is configured per element inside the Webform builder — there is no module settings page. Add a **Radios (quiz element)** (`quiz_element_radios`) for each question: fill in the normal radio **Options**, then fill the required **Quiz options** field, a YAML map with one entry per option value giving `is_correct` (true/false) and a `feedback` message — the keys and count must match the options exactly. Add one **Quiz total score** (`webform_quiz_elements_score`) element, set its **Passing score percentage** and the pass/fail messages; the score is `correct / total × 100` computed server-side and the pass/fail message is chosen against your threshold. Add a **Result (per quiz element)** (`webform_quiz_elements_result`) element per question and point its **Show results for** (`source`) at the matching question. By default the score and result elements are set to **Display on: view**, so they appear after submission — e.g. on the confirmation page (set the confirmation message to `[webform_submission:values:html]`) or on a later wizard page in a multi-page quiz. The token `[webform:quiz_elements_count]` prints the number of quiz questions (useful for "Question 1 of N"). Import the module's `docs/example.yml` to see a full working quiz. Because a quiz is a webform, all of Webform's conditional logic, multi-step wizards, access control, handlers, emailing and exports apply unchanged.

---

- Add a knowledge check to the end of an article.
- Build a short quiz using the Webform builder.
- Score a compliance or training test.
- Mark correct answers on radio questions.
- Give per-answer feedback (why an option is right or wrong).
- Show a total score with a pass/fail message.
- Set a passing-score percentage threshold.
- Show a per-question result element after submission.
- Display quiz results on the confirmation page.
- Build a multi-page quiz (question, then result on the next page).
- Reuse Webform's conditional logic in a quiz.
- Reuse Webform's access control for who can take the quiz.
- Email quiz results to a participant via a Webform handler.
- Export quiz submissions with Webform's exporters.
- Build an onboarding or induction assessment.
- Add a self-assessment to a course page.
- Print "Question 1 of N" with the quiz-count token.
- Run a fun engagement or trivia quiz.
- Store quiz attempts as normal webform submissions.
- Avoid installing a full quiz/LMS platform for a simple check.
- Translate questions, options, feedback and score messages.
- Report on quiz outcomes using Webform submission views.
