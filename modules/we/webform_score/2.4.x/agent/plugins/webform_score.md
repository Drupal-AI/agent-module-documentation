# `webform_score` plugin type

The scoring algorithm is a plugin, so a Quiz element's *Scoring methodology* dropdown is extensible.

## The type
- Manager service: `plugin.manager.webform_score` → `WebformScoreManager` (extends
  `DefaultPluginManager`).
- Discovery dir: `Plugin/WebformScore`; interface `WebformScoreInterface`; annotation
  `@WebformScore` (`src/Annotation/WebformScore.php`).
- Annotation fields: `id`, `label`, `compatible_data_types` (array of typed-data ids the plugin can
  score; `"*"` = any), `is_aggregation` (bool — aggregation plugins combine a set of sub-scores).
- Alter hook: `hook_webform_score_info_alter(&$definitions)`.
- `WebformScoreManager::pluginOptionsCompatibleWith($data_type_id, $include_aggregation = TRUE)`
  builds the option list shown in the element form (filters by data type + aggregation flag).

## Interface
```php
interface WebformScoreInterface extends PluginInspectionInterface, ConfigurableInterface {
  public function getMaxScore();                       // max points this question can award
  public function score(TypedDataInterface $answer);   // points for the given answer
}
```
`WebformScoreBase` (`Plugin/WebformScore/WebformScoreBase.php`) implements `PluginFormInterface` and
provides the shared **Maximum score** (`max_score`, default 1) config plus `getMaxScore()`.

## Built-in plugins
| id | label | data types | aggregation | config |
|---|---|---|---|---|
| `equals` | Equals | string | no | `expected`, `case_sensitive` |
| `contains` | Contains | string | no | expected substring |
| `sum` | Sum score from a set | `*` | yes | wraps sub-plugins, adds their scores |
| `maximum` | Max score from a set | `*` | yes | best score from a set |
| `set_equals` | Every value in the set is the same | `*` | yes | all values match |

## Writing one
```php
namespace Drupal\my_module\Plugin\WebformScore;

use Drupal\Core\TypedData\TypedDataInterface;
use Drupal\webform_score\Plugin\WebformScore\WebformScoreBase;
use Drupal\webform_score\Plugin\WebformScoreInterface;

/**
 * @WebformScore(
 *   id = "starts_with",
 *   label = @Translation("Starts with"),
 *   compatible_data_types = {"string"},
 * )
 */
class StartsWith extends WebformScoreBase implements WebformScoreInterface {
  public function defaultConfiguration() {
    return parent::defaultConfiguration() + ['prefix' => ''];
  }
  public function score(TypedDataInterface $answer) {
    return str_starts_with((string) $answer->getValue(), (string) $this->configuration['prefix'])
      ? $this->getMaxScore() : 0;
  }
  public function buildConfigurationForm(array $form, $form_state) {
    $form = parent::buildConfigurationForm($form, $form_state);
    $form['prefix'] = ['#type' => 'textfield', '#title' => $this->t('Required prefix'), '#required' => TRUE];
    return $form;
  }
}
```
Clear caches; the plugin then appears as a scoring methodology for compatible Quiz elements.
