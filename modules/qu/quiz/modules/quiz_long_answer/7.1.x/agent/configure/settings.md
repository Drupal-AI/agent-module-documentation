# Configure — `quiz_long_answer.settings`

No settings form of its own (`configure` is null). One config object, one key.

| Config object | Key | Type | Default | Effect |
|---|---|---|---|---|
| `quiz_long_answer.settings` | `default_max_score` | integer (min 0) | `10` | The maximum points a long-answer question is worth; returned by `LongAnswerQuestion::getMaximumScore()`. |

Schema: `config/schema/quiz_long_answer.schema.yml`. Install default:
`config/install/quiz_long_answer.settings.yml` (`default_max_score: 10`).

`quiz_long_answer_form_quiz_question_type_edit_form_alter()` exposes this as a "Default max
score" textfield on the **long_answer** `quiz_question_type` edit form.

```bash
drush cget quiz_long_answer.settings default_max_score
drush cset quiz_long_answer.settings default_max_score 20 -y
```

```php
\Drupal::configFactory()->getEditable('quiz_long_answer.settings')
  ->set('default_max_score', 20)->save();
```
