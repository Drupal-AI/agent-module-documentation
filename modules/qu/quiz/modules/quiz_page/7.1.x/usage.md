Quiz - Pages lets you group several Quiz questions onto a single page so takers answer a batch of questions per screen instead of one at a time. A "page" is itself a special, unscored question type.

---

Pages are implemented as a **question type**: the submodule registers a `page` Quiz question
plugin (`QuizPageQuestion`, `#[QuizQuestion(id: 'page')]`) with the `quiz.question.type.page`
config entity (bundle of `quiz_question`). A page is added to a quiz like any other question,
and subsequent questions placed under it (via the `quiz_question_relationship` parent field
`qqr_pid`) are shown together on that page. Pages **do not affect the score** — they are purely
a layout/grouping device — so `QuizPageResponse` contributes no points. It depends only on
`quiz`; no settings, configure route, permissions, or Drush of its own.

---

- Group related questions onto one screen (a "page") within a quiz.
- Reduce clicks by letting takers answer several questions before advancing.
- Organise a long quiz into logical sections/pages.
- Put all questions for a reading passage on the same page as the passage.
- Combine multiple question types on a single page.
- Keep context (e.g. a scenario) visible while answering its follow-up questions.
- Add an unscored structural element to a quiz without affecting grading.
- Build survey sections where several items belong together.
- Control quiz pacing by batching questions per page.
- Parent questions to a page via the `qqr_pid` relationship field.
- Reuse a page structure across quizzes from the question bank.
- Present a group of matching/multiple-choice items together.
- Reduce page reloads for takers on slow connections.
- Create page questions in code with `QuizQuestion::create(['type'=>'page', …])`.
- Insert section headings (as page titles/bodies) between question groups.
- Mix paged and single-question sections in one quiz.
- Improve UX for mobile takers by grouping short questions.
- Keep a shared image/diagram on the page with all its questions.
- Structure exams into timed sections by page.
- Order pages and their child questions with relationship weights.
- Combine with quiz_directions to add instructions above a page of questions.
