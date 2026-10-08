# Quiz - Directions — agent index

Adds the **`directions`** question type to Quiz (parent:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md)) — an unscored
instructions/context slot. Depends on `quiz`. No settings/configure/permissions/Drush.

## The type

- Plugin: `QuizDirectionsQuestion` (`#[QuizQuestion(id: 'directions')]`), handler
  `response => QuizDirectionsResponse`.
- Config entity: `quiz.question.type.directions` (bundle of `quiz_question`); answer bundle
  `quiz.result.answer.type.directions`.
- A directions item is added to a quiz like a question and shows its **`body`** text to the
  taker. It collects **no answer and awards no points** (purely informational).

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
$d = QuizQuestion::create([
  'type' => 'directions',
  'title' => 'Instructions',
  'body' => 'Read each question carefully. You have 30 minutes.',
]);
$d->save();
// Add it to a quiz via QuizQuestionRelationship (see the parent api/entities doc).
```

## Read it back

```bash
drush php:eval '$l=\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"directions","title"=>"Instructions"]);$q=reset($l);print $q->get("body")->value;'
```
