Quiz - Directions provides an informational "directions" slot you can drop into a quiz to show instructions or context to the taker, either for the whole quiz or before a sub-portion of it. Directions are not scored.

---

Directions are implemented as a **question type**: the submodule registers a `directions`
Quiz question plugin (`QuizDirectionsQuestion`, `#[QuizQuestion(id: 'directions')]`) with the
`quiz.question.type.directions` config entity (bundle of `quiz_question`). A directions item is
added to a quiz like any other question and displays its `body` text to the taker, but it
collects no answer and awards no points — `QuizDirectionsResponse` is purely informational.
Use it to introduce a quiz, explain a section, or set context before a group of questions
(often combined with quiz_page). It depends only on `quiz`; no settings, configure route,
permissions, or Drush of its own.

---

- Show overall instructions at the start of a quiz.
- Explain the rules or scoring before the first question.
- Introduce a new section partway through a quiz.
- Give context (a scenario, passage, or diagram) before related questions.
- Add a "read carefully" notice without it counting toward the score.
- Provide time-limit or navigation guidance to takers.
- Insert a non-question informational step between question groups.
- Combine with quiz_page to head a page of questions with directions.
- Reuse a standard instructions block across multiple quizzes.
- Present accessibility or accommodation notes before an exam.
- Add a legal/consent statement before a survey-style quiz.
- Break a long quiz into labelled parts with directions between them.
- Set expectations (number of questions, passing grade) up front.
- Display translated instructions per language.
- Create directions items in code with `QuizQuestion::create(['type'=>'directions', …])`.
- Provide worked-example guidance before practice questions.
- Show a rubric or grading note for upcoming essay questions.
- Add encouragement or closing remarks mid-quiz.
- Give device-specific instructions (e.g. mobile) to takers.
- Keep directions unscored so they never affect pass/fail.
- Structure onboarding quizzes with clear step-by-step directions.
