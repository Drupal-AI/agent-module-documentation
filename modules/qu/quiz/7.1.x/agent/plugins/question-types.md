# Define a question type — the `quiz.question` plugin

Quiz's one plugin type. A question type is **two things that share an id**:

1. A **plugin class** in your module's `Plugin/quiz/QuizQuestion/` namespace, extending
   `Drupal\quiz\Entity\QuizQuestion` and annotated with the `#[QuizQuestion]` attribute.
2. A matching **`quiz_question_type` config entity** at
   `config/install/quiz.question.type.<id>.yml` (bundle of `quiz_question`), so questions of
   that type can be created.

Manager: `plugin.manager.quiz.question` (`QuizQuestionPluginManager`) — scans `Plugin/quiz`
across modules, alter hook `quiz_question_info`, interface `QuizQuestionInterface`, attribute
`Drupal\quiz\Attribute\QuizQuestion`, cache `quiz_question_plugins`.

## The attribute

```php
use Drupal\quiz\Attribute\QuizQuestion as QuizQuestionAttribute;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[QuizQuestionAttribute(
  id: 'truefalse',
  label: new TranslatableMarkup('True/false question'),
  handlers: ['response' => TrueFalseResponse::class],   // the answer/scoring class
)]
class TrueFalseQuestion extends \Drupal\quiz\Entity\QuizQuestion { … }
```

- `id` — the plugin id **and** the `quiz_question_type` id (bundle machine name).
- `handlers['response']` — a `quiz_result_answer` subclass that scores answers.
- `deriver` — optional, for derived types.

## Question class (extends the `quiz_question` entity)

Implement (see `QuizQuestionInterface` / the base `QuizQuestion` entity and existing types):

- `getCreationForm(&$form_state)` — the type-specific fields on the question edit form
  (e.g. the correct-answer radios).
- `getAnsweringForm(FormStateInterface $form_state, QuizResultAnswer $answer)` — the widget
  shown to a taker.
- `getAnsweringFormValidate(&$element, $form_state)` — validate a submitted answer.
- `getMaximumScore()` — max points for one question (e.g. true/false returns `1`).

## Response/answer class (extends `quiz_result_answer`)

Extend `Drupal\quiz\Entity\QuizResultAnswer` and implement:

- `score(array $response): ?int` — store the answer and return points (or `NULL` when it must
  be graded manually; call `setEvaluated(FALSE)` for essay-style manual grading).
- `getResponse()` — the stored answer value.
- `getFeedbackValues(): array` — rows for the per-question feedback table.

## Config the type needs

`quiz.question.type.<id>.yml`:

```yaml
langcode: en
status: true
dependencies:
  enforced:
    module:
      - your_module
id: myqtype
label: 'My question type'
```

Add the answer-type bundle too (`quiz.result.answer.type.<id>.yml`) and any fields your type
stores, via `config/install/field.storage.*` + `field.field.*` on the `quiz_question` /
`quiz_result_answer` bundles (that is exactly how quiz_truefalse, quiz_multichoice, etc. are
built — read one submodule's `config/install/` for a working template).

## Inspect installed types

```bash
drush php:eval 'foreach(array_keys(\Drupal::service("plugin.manager.quiz.question")->getDefinitions()) as $id){print "$id\n";}'
```
