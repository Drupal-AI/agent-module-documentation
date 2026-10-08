# Quiz - True false — agent index

Adds the **`truefalse`** question type to Quiz (see the parent module
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md)). Auto-graded, 1 point.
No settings, no configure route, no permissions, no Drush.

## The type

- Plugin: `TrueFalseQuestion` (`#[QuizQuestion(id: 'truefalse')]`), handler
  `response => TrueFalseResponse`.
- Config entity: `quiz.question.type.truefalse` (bundle of `quiz_question`); answer bundle
  `quiz.result.answer.type.truefalse`.
- Correct answer field: **`truefalse_correct`** — `list_integer`, allowed values `1` = True,
  `0` = False (cardinality 1, required).
- Answering widget: radios True/False; response stored in `truefalse_answer`.
- Scoring (`TrueFalseResponse::score()`): 1 point if the answer equals `truefalse_correct`,
  else 0. `getMaximumScore()` is always `1`.

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
$q = QuizQuestion::create([
  'type' => 'truefalse',
  'title' => 'The sky is blue',
  'truefalse_correct' => 1,   // 1 = True, 0 = False
]);
$q->save();
```

## Read it back

```bash
drush php:eval '$l=\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"truefalse","title"=>"The sky is blue"]);$q=reset($l);print $q->get("truefalse_correct")->value;'
```
