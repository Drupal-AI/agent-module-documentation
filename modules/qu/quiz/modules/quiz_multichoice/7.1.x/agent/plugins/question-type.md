# The `multichoice` question type

A concrete implementation of Quiz's `quiz.question` plugin (parent contract:
[../../../../../7.1.x/agent/plugins/question-types.md](../../../../../7.1.x/agent/plugins/question-types.md)).
Radio (single) or checkbox (multiple) selection over a set of alternative Paragraphs.

## Classes

| Class | Role |
|---|---|
| `MultichoiceQuestion` (extends `Drupal\quiz\Entity\QuizQuestion`) | `#[QuizQuestion(id: 'multichoice', label: 'Multiple choice question', handlers: ['response' => MultichoiceResponse::class])]`. |
| `MultichoiceResponse` (extends `Drupal\quiz\Entity\QuizResultAnswer`) | Records the chosen alternative revision ids and computes the score. |

## Config entities (config/install)

- `quiz.question.type.multichoice` — the `quiz_question` bundle.
- `quiz.result.answer.type.multichoice` — the `quiz_result_answer` bundle.
- Paragraph type `multichoice` — one alternative.

## Fields

On the `multichoice` `quiz_question` bundle:

| Field | Type | Purpose |
|---|---|---|
| `alternatives` | `entity_reference_revisions` → `paragraph` (`multichoice`) | The choices. |
| `choice_multi` | `boolean` | Allow more than one selection (checkboxes vs radios). |
| `choice_boolean` | `boolean` | Simple scoring: all-or-nothing, worth 1 point. |
| `choice_random` | `boolean` | Shuffle alternatives per attempt (order stored so the report matches). |

Each `multichoice` **Paragraph** (alternative) carries: `multichoice_answer` (text),
`multichoice_correct` (boolean), `multichoice_score_chosen` / `multichoice_score_not_chosen`
(integer), `multichoice_feedback_chosen` / `multichoice_feedback_not_chosen` (text).

On the `multichoice` `quiz_result_answer` bundle: `multichoice_answer` (`integer`,
multi-value) — the revision ids of the alternatives the taker selected.

## Answering + scoring

- `getAnsweringForm()` builds a `tableselect` (`#multiple` follows `choice_multi`) whose
  options are the alternatives' `multichoice_answer` markup (run through `check_markup()`). When
  `choice_random` is on, a hidden `choice_order` field records the shuffled order.
- `getMaximumScore()`: `1` when `choice_boolean`; otherwise the sum (multi) or max (single) of
  each alternative's best of chosen/not-chosen score.
- `MultichoiceResponse::score()` (always `setEvaluated()`): simple mode returns 0 on any
  wrong/missing selection else the point value; single-answer returns the chosen alternative's
  `multichoice_score_chosen`; multi-answer sums `multichoice_score_chosen` for selected and
  `multichoice_score_not_chosen` for unselected alternatives.
- On save, `MultichoiceQuestion::save()` runs `forgive()` (repairs inconsistent per-choice
  scores from the `multichoice_correct` flags and the `scoring` setting) and `warn()` (flashes a
  warning when the number of correct answers does not match `choice_multi`).
- `getFeedbackValues()` returns one row per alternative with `choice` (the answer markup),
  whether the taker chose it, a correct icon, the per-choice score, chosen/not-chosen feedback
  (`check_markup()`), and a solution icon.

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
use Drupal\paragraphs\Entity\Paragraph;
$a1 = Paragraph::create(['type' => 'multichoice', 'multichoice_answer' => 'Paris', 'multichoice_correct' => 1, 'multichoice_score_chosen' => 1]);
$a1->save();
$a2 = Paragraph::create(['type' => 'multichoice', 'multichoice_answer' => 'Rome', 'multichoice_correct' => 0]);
$a2->save();
$q = QuizQuestion::create([
  'type' => 'multichoice',
  'title' => 'Capital of France',
  'choice_multi' => 0, 'choice_boolean' => 1, 'choice_random' => 1,
  'alternatives' => [$a1, $a2],
]);
$q->save();
```

See the parent [../../../../../7.1.x/agent/api/entities.md](../../../../../7.1.x/agent/api/entities.md)
for attaching questions and reading results.
