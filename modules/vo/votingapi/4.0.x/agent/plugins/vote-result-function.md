# VoteResultFunction plugins

Plugin type that computes an aggregate result from a set of votes. This is the
one plugin type Voting API defines.

- **Manager service:** `plugin.manager.votingapi.resultfunction`
  (`\Drupal\votingapi\VoteResultFunctionManager`, extends `DefaultPluginManager`).
- **Discovery directory:** `src/Plugin/VoteResultFunction/`.
- **Attribute:** `\Drupal\votingapi\Attribute\VoteResultFunction` (also supports
  the legacy annotation `\Drupal\votingapi\Annotation\VoteResultFunction`).
- **Interface:** `\Drupal\votingapi\VoteResultFunctionInterface`;
  **base class:** `\Drupal\votingapi\VoteResultFunctionBase`.
- **Alter hook:** `hook_vote_result_info_alter(&$results)`.

## Built-in plugins

| id | Class | Result |
|---|---|---|
| `vote_count` | Count | number of votes |
| `vote_average` | Average | mean of `value` |
| `vote_sum` | Sum | total of `value` |
| `vote_maximum` | Maximum | highest `value` |
| `vote_minimum` | Minimum | lowest `value` |
| `vote_median` | Median | median `value` |

Every defined plugin runs for every recalculation; each produces one row in
`votingapi_result` keyed by its plugin id in the `function` column.

## Add your own

```php
namespace Drupal\my_module\Plugin\VoteResultFunction;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\votingapi\Attribute\VoteResultFunction;
use Drupal\votingapi\VoteResultFunctionBase;

#[VoteResultFunction(
  id: "vote_weighted",
  label: new TranslatableMarkup("Weighted score"),
  description: new TranslatableMarkup("A custom weighted aggregate."),
)]
class WeightedScore extends VoteResultFunctionBase {

  public function calculateResult(array $votes): float {
    // $votes is an array of \Drupal\votingapi\VoteInterface for one entity
    // and one vote type. Return a single float.
    $total = 0;
    foreach ($votes as $vote) {
      $total += $vote->getValue();
    }
    return $votes ? $total / count($votes) : 0;
  }
}
```

`calculateResult(array $votes): float` is the only required method.
`getLabel()` / `getDescription()` come from the base class and read the
attribute. After adding a plugin, clear caches; results are recalculated on the
next vote or via `recalculateResults()` / `drush voting:recalculate`.
