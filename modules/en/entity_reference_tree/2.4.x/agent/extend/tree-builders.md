<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tree builders (extension point)

The tree JSON is produced by services tagged **`entity_reference_tree_builder`**, each
implementing `Drupal\entity_reference_tree\Tree\TreeBuilderInterface`. Two ship with the
module (`entity_reference_tree.services.yml`):

| Service | Class | Handles |
|---|---|---|
| `entity_reference_taxonomy_term_tree_builder` | `TaxonomyTreeBuilder` | `taxonomy_term` (real vocabulary hierarchy) |
| `entity_reference_entity_tree_builder` | `EntityTreeBuilder` | any other entity type (general/flat) |

Both are tagged `{ name: entity_reference_tree_builder, priority: 1000 }`. The controller
(`EntityReferenceTreeController::treeJson`, route `entity_reference_tree.json` at
`/admin/entity_reference_tree/json/{entity_type}/{bundles}`) selects a builder for the
target entity type and returns the jsTree node list; access is validated per-widget with a
CSRF token.

## Add a custom builder

Provide a service that implements `TreeBuilderInterface` and carries the tag, e.g. to build
a bespoke hierarchy for your own entity type:

```yaml
# my_module.services.yml
services:
  my_module.my_tree_builder:
    class: Drupal\my_module\Tree\MyEntityTreeBuilder
    tags:
      - { name: entity_reference_tree_builder, priority: 2000 }
```

```php
namespace Drupal\my_module\Tree;

use Drupal\entity_reference_tree\Tree\TreeBuilderInterface;

class MyEntityTreeBuilder implements TreeBuilderInterface {
  // Implement the interface methods that load the tree and build node rows
  // for your entity type (see TaxonomyTreeBuilder / EntityTreeBuilder for the shape).
}
```

This is a **service-tag** extension point, not a Drupal plugin type — there is no plugin
manager/annotation. To customize taxonomy term **labels** in the tree without a new builder,
use `hook_entity_reference_tree_create_term_node_alter()`
([../hooks/term-label.md](../hooks/term-label.md)).
