# Configure — `quiz_multichoice.settings`

No settings form of its own (`configure` is null). One config object, one key.

| Config object | Key | Type | Default | Effect |
|---|---|---|---|---|
| `quiz_multichoice.settings` | `scoring` | integer (min 0) | `0` | Default scoring model applied by `MultichoiceQuestion::forgive()` when a multi-answer alternative has no explicit score: `0` = minus one point for an incorrect chosen option; `1` = one point for each incorrect option left un-chosen. |

Schema: `config/schema/quiz_multichoice.schema.yml`. Install default:
`config/install/quiz_multichoice.settings.yml` (`scoring: 0`).

`quiz_multichoice_form_quiz_question_type_edit_form_alter()` exposes this as a "Default scoring
method" radios control on the **multichoice** `quiz_question_type` edit form. The value is also
passed to `js/helper.js` via `drupalSettings.quiz_multichoice.scoring` so the edit form can
auto-fill per-choice scores as the author toggles the "correct" checkboxes.

```bash
drush cget quiz_multichoice.settings scoring
drush cset quiz_multichoice.settings scoring 1 -y
```

```php
\Drupal::configFactory()->getEditable('quiz_multichoice.settings')
  ->set('scoring', 1)->save();
```
