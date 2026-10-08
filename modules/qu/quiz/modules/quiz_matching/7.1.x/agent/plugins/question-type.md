# The `matching` question type

A concrete implementation of Quiz's `quiz.question` plugin (see the parent contract:
[../../../../../7.1.x/agent/plugins/question-types.md](../../../../../7.1.x/agent/plugins/question-types.md)).
The taker is shown a list of prompts, each with a select of the pooled answers, and must choose
the correct answer for every prompt.

## Classes

| Class | Role |
|---|---|
| `MatchingQuestion` (extends `Drupal\quiz\Entity\QuizQuestion`) | The question. `#[QuizQuestion(id: 'matching', label: 'Matching question', handlers: ['response' => MatchingResponse::class])]`. |
| `MatchingResponse` (extends `Drupal\quiz\Entity\QuizResultAnswer`) | Stores the taker's pairings and scores them. |

## Config entities (config/install)

- `quiz.question.type.matching` — the `quiz_question` bundle (label "Matching question").
- `quiz.result.answer.type.matching` — the `quiz_result_answer` bundle (label "Matching
  response").
- Two Paragraph types: `quiz_matching` (an author-defined pair) and `quiz_matching_answer`
  (one stored taker pairing).

## Fields

On the `matching` `quiz_question` bundle:

| Field | Type | Req | Purpose |
|---|---|---|---|
| `quiz_matching` | `entity_reference_revisions` → `paragraph` (`quiz_matching`), cardinality −1 | yes | The pairs. Each `quiz_matching` paragraph has `matching_question` (prompt) and `matching_answer` (its correct match). |
| `choice_penalty` | `boolean` | no | When on, a wrong (non-blank) match subtracts one point. |

On the `matching` `quiz_result_answer` bundle: `matching_user_answer` —
`entity_reference_revisions` → `quiz_matching_answer` paragraphs; each stores
`matching_user_question` (the prompt paragraph revision id) and `matching_user_answer` (the
answer paragraph revision id the taker chose).

## Answering + scoring

- `MatchingQuestion::getAnsweringForm()` builds one `select` per prompt whose `#options` are
  the pooled `matching_answer` strings (keyed by answer paragraph revision id). If
  `quiz_matching.settings:shuffle` is on, the answer order is shuffled per render.
- `getMaximumScore()` returns `count()` of the referenced pairs — one point each.
- `MatchingResponse::score()` sets `setEvaluated()` (auto-graded), rebuilds
  `matching_user_answer` paragraphs from the submission, then: `+1` when the chosen answer
  revision id equals the pair's own revision id; `-1` when it is wrong **and** `choice_penalty`
  is set. Returns `max($score, 0)` (never negative overall).
- `getFeedbackValues()` returns one report row per pair with the taker's `attempt`, the
  `solution` (`matching_answer`), a correct/incorrect icon, and the per-row score.
- `MatchingResponse::viewsGetAnswers()` supplies "prompt: answer" strings for the Views
  answer-export field.

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
use Drupal\paragraphs\Entity\Paragraph;
$pairs = [];
foreach ([['France', 'Paris'], ['Italy', 'Rome']] as [$q, $a]) {
  $p = Paragraph::create(['type' => 'quiz_matching', 'matching_question' => $q, 'matching_answer' => $a]);
  $p->save();
  $pairs[] = $p;
}
$question = QuizQuestion::create([
  'type' => 'matching',
  'title' => 'Countries and capitals',
  'quiz_matching' => $pairs,
  'choice_penalty' => 0,
]);
$question->save();   // worth 2 points (2 pairs)
```

Attaching the question to a quiz and reading results is identical for every type — see the
parent [../../../../../7.1.x/agent/api/entities.md](../../../../../7.1.x/agent/api/entities.md).
