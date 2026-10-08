# Quiz entity model + programmatic use

Quiz is entity-based. Nothing lives in nodes. There are **no Drush commands** — script with
`drush php:eval` or the entity API.

## Entities

| Entity | Kind | id / bundle key | Purpose |
|---|---|---|---|
| `quiz` | content | bundle = `type` (`quiz_type`) | A quiz. Behaviour fields per [configure/settings.md](../configure/settings.md). Editorial/revisionable/owner. `base_table = quiz`. |
| `quiz_question` | content | bundle = `type` (`quiz_question_type`) | A reusable question. Base fields incl. `title`, `body`, `max_score`, `feedback`; each type adds its own fields. |
| `quiz_question_relationship` | content | — | Links a `quiz_question` to a `quiz`. Fields: `quiz_id`, `quiz_vid`, `question_id`, `question_vid`, `qqr_pid` (parent, for pages), `weight`, `max_score`, `auto_update_max_score`, `question_status`. |
| `quiz_result` | content | bundle = string `type` | One attempt. Fields: `qid` (quiz), `time_start`, `time_end`, `released`, `score`, `is_invalid`, `is_evaluated`, `attempt`. |
| `quiz_result_answer` | content | bundle (`quiz_result_answer_type`) | One answered question inside an attempt. Subclassed per question type (e.g. `TrueFalseResponse`) to implement scoring. |

Config bundles: `quiz_type`, `quiz_question_type`, `quiz_result_type`,
`quiz_result_answer_type`, `quiz_feedback_type` (see configure/settings.md).

## Create a quiz

```php
use Drupal\quiz\Entity\Quiz;
$quiz = Quiz::create([
  'type' => 'quiz',
  'title' => 'My quiz',
  'randomization' => 0,          // required (list_integer)
  'keep_results' => 2,           // required: 0 none / 1 best / 2 all
  'build_on_last' => 'all',      // required (list_string)
  'result_type' => 'quiz_result',// required (entity_reference to quiz_result_type)
  'pass_rate' => 75,
  'takes' => 0,                  // 0 = unlimited attempts
]);
$quiz->save();
```

## Create a question (type-specific fields come from the submodule)

```php
use Drupal\quiz\Entity\QuizQuestion;
$q = QuizQuestion::create([
  'type' => 'truefalse',              // a quiz_question_type / plugin id
  'title' => 'The sky is blue',
  'truefalse_correct' => 1,           // field provided by quiz_truefalse
]);
$q->save();
```

Each question-type submodule documents its own fields (e.g. multichoice `alternatives`
paragraphs, short_answer `short_answer_correct`, long_answer `long_answer_rubric`, matching
`quiz_matching`). See the submodule docs.

## Attach a question to a quiz

```php
use Drupal\quiz\Entity\QuizQuestionRelationship;
QuizQuestionRelationship::create([
  'quiz_id' => $quiz->id(),
  'quiz_vid' => $quiz->getRevisionId(),
  'question_id' => $q->id(),
  'question_vid' => $q->getRevisionId(),
  'weight' => 0,
  'max_score' => 1,
])->save();
```

## Taking a quiz (routes + session)

- `entity.quiz.take` → `/quiz/{quiz}/take` (`QuizController::take`) starts/continues an attempt.
- `quiz.question.take` → `/quiz/{quiz}/take/{question_number}` (`QuizQuestionController::take`)
  renders one question's `QuizQuestionAnsweringForm`.
- `quiz.question.feedback` → `.../feedback` shows per-question feedback.
- Service **`quiz.session`** (`Drupal\quiz\Services\QuizSession`, wraps `@session`) tracks the
  current attempt/question: `getTemporaryResult()`, `getCurrentQuestion($quiz)`,
  `setQuestion($n)`, etc. Used by the take flow and by ajax_quiz.

## Handy services / helpers

- `plugin.manager.quiz.question` — the question-type plugin manager (see plugins doc).
- `quiz.quiz_route_context` — a context provider exposing the current quiz.
- `quiz_get_question_types()` / `quiz_get_feedback_options()` — procedural helpers in
  `quiz.module`. `QuizUtil::getQuizName()` returns the configurable "Quiz" label.
