# NodeRevisionDelete plugin type

The plugin type that decides which revisions of a node are candidates for deletion.

- Manager: `plugin.manager.node_revision_delete`
  (`Plugin/NodeRevisionDeletePluginManager`)
- Base: `Plugin\NodeRevisionDeleteBase`; interfaces `NodeRevisionDeleteInterface`,
  `NodeRevisionDeleteQueryInterface`, `NodeRevisionDeleteTimeBasedInterface`
- Attribute: `#[NodeRevisionDelete(id: '…', label: new TranslatableMarkup('…'))]`
  (`src/Attribute/NodeRevisionDelete.php`; legacy annotation in `src/Annotation/`)
- Namespace: `Plugin/NodeRevisionDelete`

Built-in strategies:

| id | Deletes |
|---|---|
| `amount` | Revisions beyond a kept maximum count. |
| `created` | Revisions older than a specified time period. |
| `drafts` | Revisions newer than the current (default) revision. |
| `only_drafts` | Unpublished revisions older than the active revision. |

Implement one:
```php
namespace Drupal\my_module\Plugin\NodeRevisionDelete;

use Drupal\node_revision_delete\Plugin\NodeRevisionDeleteBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[NodeRevisionDelete(
  id: 'my_strategy',
  label: new TranslatableMarkup('My pruning strategy'),
)]
class MyStrategy extends NodeRevisionDeleteBase {
  // Return the candidate revision IDs for a node per the interface(s).
}
```
