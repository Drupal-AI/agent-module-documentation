# Quiz - Pages — agent index

Adds the **`page`** question type to Quiz (parent:
[../../../../7.1.x/agent/start.md](../../../../7.1.x/agent/start.md)) for grouping questions
onto one screen. Depends on `quiz`. **Unscored.** No settings/configure/permissions/Drush.

## The type

- Plugin: `QuizPageQuestion` (`#[QuizQuestion(id: 'page')]`), handler
  `response => QuizPageResponse`.
- Config entity: `quiz.question.type.page` (bundle of `quiz_question`); answer bundle
  `quiz.result.answer.type.page`.
- A page is added to a quiz like a normal question; other questions are attached to it by
  setting the `quiz_question_relationship` parent field **`qqr_pid`** to the page's
  relationship, so they render together on one page.
- Pages **do not affect the score** (they are a layout device); `QuizPageResponse` awards no
  points. A page carries the base `title`/`body` fields for a heading/intro.

## Create one in code

```php
use Drupal\quiz\Entity\QuizQuestion;
$page = QuizQuestion::create([
  'type' => 'page',
  'title' => 'Section A',
  'body' => 'Answer the following questions.',
]);
$page->save();
// Then add it to a quiz via QuizQuestionRelationship, and set qqr_pid on the child
// questions' relationships to this page's relationship id (see the parent api/entities doc).
```
