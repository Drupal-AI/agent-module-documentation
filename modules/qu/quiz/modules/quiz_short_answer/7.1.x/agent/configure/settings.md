# Configure — `quiz_short_answer.settings`

No settings form of its own (`configure` is null). One config object, one key.

| Config object | Key | Type | Default | Effect |
|---|---|---|---|---|
| `quiz_short_answer.settings` | `default_max_score` | integer (min 0) | `5` | Maximum points a short-answer question is worth; returned by `ShortAnswerQuestion::getMaximumScore()`. |

Schema: `config/schema/quiz_short_answer.schema.yml`. Install default:
`config/install/quiz_short_answer.settings.yml` (`default_max_score: 5`).

`quiz_short_answer_form_quiz_question_type_edit_form_alter()` exposes this as a "Default max
score" textfield on the **short_answer** `quiz_question_type` edit form.

```bash
drush cget quiz_short_answer.settings default_max_score
drush cset quiz_short_answer.settings default_max_score 10 -y
```

```php
\Drupal::configFactory()->getEditable('quiz_short_answer.settings')
  ->set('default_max_score', 10)->save();
```

The per-question grading mode is **not** a module setting — it lives on each question's
`short_answer_evaluation` field (see [../plugins/question-type.md](../plugins/question-type.md)).
