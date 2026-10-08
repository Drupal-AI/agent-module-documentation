# Configuration

Quiz Maker has no single global settings page. Instead, you configure each quiz as
you build it, and you control who can do what through permissions. This page walks
through both.

## Set permissions first

Go to **People → Permissions** (`/admin/people/permissions`) and grant the Quiz
Maker permissions to the appropriate roles. Decide carefully:

- Who may **create and edit** quizzes and questions (usually editors or trainers).
- Who may **take** quizzes (this can include anonymous users — Quiz Maker supports
  anonymous respondents).
- Who may **view results** and run **exports**.

Because responses and scores are personal data, restrict result viewing and exports
so respondents cannot see other people's answers or scores.

## Build a quiz

Create a new quiz from the Quiz Maker content management area, then add questions to
it. On the 1.x branch you can mix these question types:

- **Boolean** — true/false.
- **Single choice** — one correct option from a list.
- **Multiple choice** — one or more correct options.
- **Direct** — a free‑text answer.
- **Matching** — pair items from two columns.

Answers that the module cannot score automatically (typically direct/free‑text
answers) can be graded by hand later in the manual review mode.

## Per‑quiz settings

Each quiz has its own settings so you can tune behaviour per assessment:

- **Quiz timer** — a time limit, enforced on the server side.
- **Pass rate** — the score needed to pass.
- **Attempts limit** — how many times a user may take the quiz.
- **Allow jumping between questions** — let respondents move freely, or force a
  fixed order.
- **Allow backwards navigation** — whether users can return to earlier questions.
- **Allow skipping a question** — whether a question may be left unanswered.
- **Allow changing an answer** — whether a submitted answer can be revised.
- **Randomized question sequence** — shuffle the order for each attempt.
- **Quiz access by date** — a start/end window during which the quiz is available.

## Feedback and results

Quiz Maker evaluates responses automatically and shows results to respondents. With
**per‑score feedback** you can display a different message depending on the outcome
— for example a congratulatory note for a 90% pass and an encouraging one for a 50%
fail. If you enabled the **Quiz Maker Export** submodule, you can export results to
PDF or a spreadsheet from the results screens.

## Multilingual quizzes

Quizzes and their questions are fully translatable and integrate with Drupal's
multilingual system, so a single quiz can be offered in several languages. Enable
Drupal's language and content translation features first, then translate each quiz
and question as you would any other translatable entity.
