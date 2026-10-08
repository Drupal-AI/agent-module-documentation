# The `short_answer` question type

A concrete implementation of Quiz's `quiz.question` plugin (parent contract:
[../../../../../7.1.x/agent/plugins/question-types.md](../../../../../7.1.x/agent/plugins/question-types.md)).
A single-line typed answer, optionally auto-graded against a stored expected value.

## Classes

| Class | Role |
|---|---|
| `ShortAnswerQuestion` (extends `Drupal\quiz\Entity\QuizQuestion`) | `#[QuizQuestion(id: 'short_answer', label: 'Short answer question', handlers: ['response' => ShortAnswerResponse::class])]`. Defines the evaluation-mode constants. |
| `ShortAnswerResponse` (extends `Drupal\quiz\Entity\QuizResultAnswer`) | Stores the typed answer and scores it per the mode. |

## Config entities (config/install)

- `quiz.question.type.short_answer` — the `quiz_question` bundle.
- `quiz.result.answer.type.short_answer` — the `quiz_result_answer` bundle.

## Fields

On the `short_answer` `quiz_question` bundle:

| Field | Type | Req | Purpose |
|---|---|---|---|
| `short_answer_correct` | `string` | no | The expected answer; a full `preg_match` pattern (with delimiters) in regex mode. |
| `short_answer_evaluation` | `list_integer` | no (default `1`) | Grading mode — see table below. |

On the `short_answer` `quiz_result_answer` bundle: `short_answer` (`string`) — the taker's
typed answer (max length 256; the widget also sets `autocomplete=off`).

## Evaluation modes

`ShortAnswerResponse::score()` reads `short_answer_evaluation` and compares the submission to
`short_answer_correct`:

| Const | Value | Behaviour |
|---|---|---|
| `ANSWER_MATCH` | `0` | Exact, case-sensitive `==`. Full points on match. |
| `ANSWER_INSENSITIVE_MATCH` | `1` | `strtolower()` on both sides. Full points on match. |
| `ANSWER_REGEX` | `2` | `preg_match($correct, $answer) > 0`. Full points on match. |
| `ANSWER_MANUAL` | `3` | `setEvaluated(FALSE)`; returns `NULL` — awaits a grader. |

Automatic modes call `setEvaluated()` and return `getMaximumScore()` on a match, else fall
through to `NULL` (recorded as 0 once evaluated). `getMaximumScore()` returns
`quiz_short_answer.settings:default_max_score`.

`getFeedbackValues()` builds the report row: the taker's `attempt`, the `solution`
(`short_answer_correct`), a correct/incorrect icon, the score, and answer feedback (rendered
via `check_markup()`).

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
$q = QuizQuestion::create([
  'type' => 'short_answer',
  'title' => 'Capital of France',
  'short_answer_correct' => 'Paris',
  'short_answer_evaluation' => 1,   // case-insensitive auto grading
]);
$q->save();
```

See the parent [../../../../../7.1.x/agent/api/entities.md](../../../../../7.1.x/agent/api/entities.md)
for attaching questions and reading results.
