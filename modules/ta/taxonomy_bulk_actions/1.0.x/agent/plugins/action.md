# `taxonomy_bulk_actions` plugin type

Define a bulk action offered on the taxonomy term overview page.

- Manager: `plugin.manager.taxonomy_bulk_actions` (`TaxonomyBulkActionsManager`, dir
  `Plugin/TaxonomyBulkActions`).
- Annotation: `@TaxonomyBulkActions` (`src/Annotation/TaxonomyBulkActions.php`):
  - `id` (string) — plugin id; also the value stored in the action `<select>`.
  - `description` — the option label shown in the dropdown.
  - `vids` (array, optional) — vocabulary ids this action applies to; empty/omitted = all.
- Interface: `TaxonomyBulkActionsInterface`; base: `TaxonomyBulkActionsManagerBase` (provides
  `vids()`, `description()`, `executeMultiple()`, default `access() => TRUE`,
  `actionFinishedMessage()`).

## Methods to implement

- `execute(TermInterface $term)` — the operation applied to one term (base `executeMultiple`
  loops `execute` over the selection).
- `access(AccountProxyInterface $account): bool` — checked twice (when building the dropdown and
  before running the batch). Return your permission check here; the current
  `taxonomy_vocabulary` is available via `\Drupal::routeMatch()`.
- `actionFinishedMessage()` — status message shown when the batch finishes.

## Skeleton

```php
namespace Drupal\my_module\Plugin\TaxonomyBulkActions;

use Drupal\Core\Session\AccountProxyInterface;
use Drupal\taxonomy\TermInterface;
use Drupal\taxonomy_bulk_actions\TaxonomyBulkActionsManagerBase;

/**
 * @TaxonomyBulkActions(
 *   id = "my_term_action",
 *   description = "Do the thing to selected terms",
 *   vids = {"tags"}
 * )
 */
class MyTermAction extends TaxonomyBulkActionsManagerBase {

  public function access(AccountProxyInterface $account) {
    return $account->hasPermission('administer taxonomy');
  }

  public function execute(TermInterface $term) {
    // mutate + $term->save(); or $term->delete();
  }

  public function actionFinishedMessage() {
    return $this->t('Done.');
  }
}
```

Reference: `TaxonomyBulkActionsDelete` (per-vocabulary delete permission),
`TaxonomyBulkActionsPublish` / `...Unpublish` (`status` field + save).
