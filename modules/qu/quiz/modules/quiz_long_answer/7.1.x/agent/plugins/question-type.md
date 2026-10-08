# The `long_answer` question type

A concrete implementation of Quiz's `quiz.question` plugin (parent contract:
[../../../../../7.1.x/agent/plugins/question-types.md](../../../../../7.1.x/agent/plugins/question-types.md)).
Essay / long-form answers that must be scored by a person.

## Classes

| Class | Role |
|---|---|
| `LongAnswerQuestion` (extends `Drupal\quiz\Entity\QuizQuestion`) | `#[QuizQuestion(id: 'long_answer', label: 'Long answer question', handlers: ['response' => LongAnswerResponse::class])]`. |
| `LongAnswerResponse` (extends `Drupal\quiz\Entity\QuizResultAnswer`) | Stores the essay text; forces manual grading. |

## Config entities (config/install)

- `quiz.question.type.long_answer` — the `quiz_question` bundle.
- `quiz.result.answer.type.long_answer` — the `quiz_result_answer` bundle.

## Fields

On the `long_answer` `quiz_question` bundle:

| Field | Type | Req | Purpose |
|---|---|---|---|
| `long_answer_rubric` | `text_long` | no | Grading criteria shown to the evaluator (via `getCreationForm()`, rendered as a `text_format` element). |
| `answer_text_processing` | `boolean` | no | `0` = plain-text answer (`textarea`), `1` = filtered text (`text_format`; taker picks a text format). |

On the `long_answer` `quiz_result_answer` bundle: `long_answer` (`text_long`) — the stored
essay.

## Answering + grading

- `getCreationForm()` adds the `rubric` (`text_format`) and `answer_text_processing` (radios)
  controls to the question edit form.
- `getAnsweringForm()` renders a 15-row answer area — a `textarea` when
  `answer_text_processing` is off, a `text_format` element when it is on.
  `getAnsweringFormValidate()` requires a non-empty answer.
- `getMaximumScore()` returns `quiz_long_answer.settings:default_max_score`.
- `LongAnswerResponse::score()` stores `long_answer` from the submission, calls
  `setEvaluated(FALSE)`, and returns `NULL` — so the response is **never auto-scored**. It sits
  in Quiz's unevaluated-results list until a user with the score permission awards `0..max`
  points on the report form.
- `getFeedbackValues()` builds the report row: the taker's `attempt`, the `solution` (the
  rubric, for grader reference), the awarded score (or "This answer has not yet been scored."),
  and answer feedback. Stored/filtered text is rendered through `check_markup()` with its saved
  text format.

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
$q = QuizQuestion::create([
  'type' => 'long_answer',
  'title' => 'Explain photosynthesis',
  'long_answer_rubric' => 'Award points for mentioning light, water and CO2.',
  'answer_text_processing' => 0,
]);
$q->save();
```

See the parent [../../../../../7.1.x/agent/api/entities.md](../../../../../7.1.x/agent/api/entities.md)
for attaching questions to a quiz and reading results.
