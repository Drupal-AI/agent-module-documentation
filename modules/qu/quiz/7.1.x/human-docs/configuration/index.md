# Configuration

Quiz has two layers of settings: **global** options that act as site‑wide defaults
and behaviour, and **per‑quiz** options set on each individual quiz. On top of that
there are permissions that control who can take, author, and score quizzes.

## Global settings

Go to **`/admin/quiz/config/quiz`** (Administer quiz configuration permission). The
main options:

- **Revisioning** — create a new revision whenever a quiz or question is edited.
  (Off by default; note the warning that changing this can affect reporting.)
- **Delete results on user delete** — remove a user's attempts when their account is
  deleted (on by default).
- **Enable pass/fail** — turn on pass‑rate behaviour and pass/fail messaging.
- **Result pruning** — how long partial and invalid attempts are kept before being
  cleaned up automatically (on cron).
- **Timer** — whether quizzes show a countdown timer, and the format it's displayed
  in, plus a grace period at the end of a timed quiz.
- **Auto‑title length** — how long automatically generated question titles are.
- **Review options** — two sets of checkboxes controlling what a taker is shown
  **after each question** and **after the whole quiz**: for example whether they see
  their choice, the correct answer, the score, per‑answer or per‑question feedback,
  and the solution. You can also let per‑quiz feedback override these defaults.

## Per‑quiz options

When you create or edit a quiz (**Add quiz** / the quiz edit form), you set how that
specific quiz behaves. The most useful options:

- **Randomisation** — none, random order, a random selection of questions from the
  quiz, or categorised‑random — plus how many random questions to pull and their
  maximum score.
- **Pass rate** and the **pass / default result text** shown to takers.
- **Attempts allowed** (`0` = unlimited) and whether to show attempt statistics.
- **Time limit** (in seconds).
- **Navigation** — allow going backwards, skipping questions, jumping between
  questions, changing answers, and resuming a started attempt.
- **Repeat until correct** and **build on last** — whether each attempt re‑asks
  previously wrong questions.

The quiz's maximum score is calculated automatically from its questions.

## Quiz, result, and feedback types

Under **`/admin/quiz/config/structure`** you can manage the config‑entity bundles:

- **Quiz types** — bundles of the quiz entity (ships one, `quiz`); add fields to
  them via Field UI.
- **Question types** — one bundle per enabled question‑type submodule (multichoice,
  truefalse, …).
- **Result types** and **result answer types** — bundles for stored attempts.
- **Feedback types** — Rules‑powered conditional feedback. Two ship by default
  (shown at the end of the quiz and after each question); you can edit their
  conditions to show different messages based on score.

## Creating a quiz, step by step

1. Build a few **questions** first — go to the question bank and add questions of
   your enabled types, marking the correct answers.
2. **Add a quiz**, set the per‑quiz options above, and add questions to it (from the
   bank, optionally as a random pool).
3. Grant the **take** permission (below) to the roles who should attempt it.
4. Takers go to `/quiz/{quiz}/take` and answer question by question.

## Reading and grading results

Auto‑scored question types (multiple choice, true/false, matching, short answer) are
graded immediately. **Long answer (essay)** responses are held in an *unevaluated
results* queue for a human to score by hand. Per‑user and per‑quiz results are
available through the Views the module ships, and what each taker sees afterwards is
governed by the review options above.

## Permissions

Grant these at **People → Permissions**:

| Permission | Allows |
|------------|--------|
| `access quiz` | Take (attempt) available quizzes. |
| `administer quiz configuration` | The global settings form and overall behaviour. |
| `administer quiz result types` | Manage result types and their fields. |
| `view results for own quiz` | Quiz authors view results for quizzes they created. |
| `delete results for own quiz` | Quiz authors delete results for their own quizzes. |
| `score own quiz` | Quiz authors grade/update results for their own quizzes. |
| `view any quiz question correct response` | See the correct answer when a question is viewed outside a quiz. |
| `edit question titles` | Set question titles by hand (otherwise auto‑generated). |
| `override quiz revisioning` | Edit without creating revisions (can affect reporting). |

Quiz and question entities also use **bundle‑level** permissions, so Drupal
generates the usual per‑type create/edit/delete permissions (for example "create
quiz content", "edit any … quiz") in addition to those above.
