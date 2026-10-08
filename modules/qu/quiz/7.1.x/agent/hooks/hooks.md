# Hooks Quiz invites (`quiz.api.php`)

Quiz-specific hooks plus standard entity-API hooks on every Quiz entity.

## Quiz-specific hooks

```php
// Add a feedback/review option administrators can toggle on/off per quiz.
function hook_quiz_feedback_options() {
  return ['percentile' => t('Percentile')];   // keyed by machine name
}

// Alter the available feedback/review options (relabel or remove).
function hook_quiz_feedback_options_alter(&$review_options) {
  $review_options['quiz_feedback'] = t('General feedback from the Quiz.');
  unset($review_options['solution']);          // e.g. never show the correct answer
}

// Relabel feedback options shown to takers (learner-friendly wording).
function hook_quiz_feedback_labels_alter(&$feedback_labels) {
  $feedback_labels['solution'] = t('The answer you should have chosen.');
}

// Access control, including Quiz's extra "take" operation.
function hook_quiz_access(EntityInterface $entity, $operation, AccountInterface $account) {
  if ($operation == 'take') { /* return AccessResult */ }
}
```

The default access logic is `quiz_quiz_access()` in `quiz.module`; the module also alters the
question-plugin list via the `quiz_question_info` alter hook (see the plugins doc).

## Entity-API hooks on Quiz entities

These entity types fire the normal `hook_ENTITY_TYPE_*` hooks (`presave`, `insert`, `update`,
`delete`, `load`, `access`, …):

- `quiz`, `quiz_result`, `quiz_result_answer`, `quiz_question`, `quiz_question_relationship`.

Examples from `quiz.api.php`:

```php
function hook_quiz_result_presave(\Drupal\quiz\Entity\QuizResult $quiz_result) {}          // before a result saves
function hook_quiz_question_relationship_insert($quiz_question_relationship) {}             // when a question is added to a quiz
```

## Prefer Rules where you can

Quiz's entities emit **Rules events**, and feedback types (`quiz_feedback_type`) are Rules
components. For "when a result is saved, do X" style logic, a Rules reaction rule is usually
preferable to a custom hook — no code, and it is what the shipped `end`/`question` feedback
types use.
