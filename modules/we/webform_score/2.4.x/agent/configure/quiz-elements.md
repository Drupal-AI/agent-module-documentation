# Quiz elements & configuration

There is no global settings page. You make a form scorable by adding **Quiz** elements and
configuring each one's scoring.

## The four Quiz elements
`src/Plugin/WebformElement/` (category "Quiz"), each a scoring-aware subclass of the corresponding
core element, sharing `QuizTrait`:

| Element id | Based on | Answer data type |
|---|---|---|
| `webform_score_textfield` | Textfield | string |
| `webform_score_radios` | Radios | (single option value) |
| `webform_score_select` | Select | (single option value) |
| `webform_score_checkboxes` | Checkboxes | (multi-value set) |

At render time `QuizTrait::prepare()` strips the `webform_score_` prefix so the element behaves
exactly like its core equivalent for the respondent.

## Configuring scoring (the *Quiz answer* section)
When editing a Quiz element, `QuizTrait::form()` adds a **Quiz answer** details section with:
- **Scoring methodology** (`webform_score_plugin`, required select) — options are the
  `webform_score` plugins compatible with the element's answer data type
  (`WebformScoreManager::pluginOptionsCompatibleWith()`). AJAX-driven.
- **Plugin configuration** (`webform_score_plugin_configuration`) — the chosen plugin's own
  settings form (e.g. `equals` → *Expected answer* + *Case sensitive*; all plugins → *Maximum score*).

These are stored as element properties in the webform config (`getDefaultProperties()` seeds
`webform_score_plugin` = '' and `webform_score_plugin_configuration` = []).

## How a submission is scored
On save, `webform_score_webform_submission_presave()` → `HookService::webformSubmissionPreSave()`
iterates all flattened elements; for each one implementing `QuizInterface` it adds
`getMaxScore($element)` to the denominator and `score($element, $submission)` to the numerator,
writing both to the `webform_score` fraction field. Non-Quiz elements contribute nothing. A form
with no configured Quiz element yields denominator 0 (score field is then hidden — see permissions).

## Displaying the score
The `webform_score` base field ships a `fraction_percentage` view display (precision 0). Add it to
the submission view display, a View, or use the tokens (see api/score.md).
