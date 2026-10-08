# Configure — `quiz_matching.settings`

The submodule has **no settings form of its own** (`configure` is null). It ships one config
object with a single key.

| Config object | Key | Type | Default | Effect |
|---|---|---|---|---|
| `quiz_matching.settings` | `shuffle` | boolean | `false` | When true, `MatchingQuestion::getAnsweringForm()` shuffles the pooled answer options each time a matching question is rendered. |

Schema: `config/schema/quiz_matching.schema.yml` (`quiz_matching.settings` → `shuffle`).

The value is surfaced in the UI as a "Shuffle matching questions" checkbox added by
`quiz_matching_form_quiz_question_type_edit_form_alter()` onto the **matching**
`quiz_question_type` edit form; saving that type mirrors the checkbox back into config via
`quiz_matching_entity_update()`.

Set it directly:

```bash
drush cset quiz_matching.settings shuffle true -y
drush cget quiz_matching.settings shuffle
```

```php
\Drupal::configFactory()->getEditable('quiz_matching.settings')->set('shuffle', TRUE)->save();
```
