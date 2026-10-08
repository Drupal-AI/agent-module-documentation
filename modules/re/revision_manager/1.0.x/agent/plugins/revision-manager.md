<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RevisionManager plugin type

Revision Manager defines a plugin type for **retention rules**. Implement one to add a custom
way of deciding which revisions to delete.

## Discovery

- Namespace: `Plugin/RevisionManager` in any module.
- Annotation: `@RevisionManager` (`Drupal\revision_manager\Annotation\RevisionManager`) with
  `id` and `label` (annotation-based discovery; the manager is not attribute-based).
- Interface: `Drupal\revision_manager\Plugin\RevisionManagerInterface` (extends
  `ConfigurableInterface`, `PluginFormInterface`, `ContainerFactoryPluginInterface`).
- Base class: `Drupal\revision_manager\Plugin\RevisionManagerBase`.
- Manager service: `plugin.manager.revision_manager` (class `RevisionManagerPluginManager`),
  alter hook `hook_revision_manager_info_alter()`, cache key `revision_manager_plugins`.

## The one method you must implement

```php
public function deleteRevisions(RevisionableInterface $entity): array;
```

It returns the list of **revision IDs that are safe to delete** for `$entity` (it does not
delete them itself — the queue worker does). The base class gives you helpers:

- `buildRevisionQuery($entity)` / `collectRevisionIds($query)` — chunked (500) all-revisions
  query, newest first.
- `getRevisionIds($entity, $conditions)` — revision IDs per langcode, honoring
  `revision_translation_affected` for multilingual entities.
- `getRemovableRevisionIds($entity, $buckets, $keep)` — slices per language while **always
  protecting the current revision**; `$keep` = how many newest to retain.

## The two shipped plugins

| id | Setting | `deleteRevisions()` logic |
|---|---|---|
| `amount` | `settings.amount` (int, default 3) | keep the newest `amount` revisions older than current; delete the rest. |
| `age` | `settings.age` (int months, default 6) | delete revisions older than current whose `changed` timestamp is beyond the cutoff; `keep = 0`. |

Both add a config form (`buildConfigurationForm`) and cast their value to int in
`setConfiguration`. Their schema is `revision_manager.plugin.settings.amount` /
`revision_manager.plugin.settings.age`.

## Conservative combination

The engine intersects the deletion decisions of all **enabled** plugins for the type/bundle: a
revision is deleted only if every enabled plugin's `deleteRevisions()` returned it. So enabling
more plugins deletes *fewer* revisions. Forward/pending and current revisions are never
returned as deletable.

## Minimal custom plugin

```php
namespace Drupal\my_module\Plugin\RevisionManager;

use Drupal\Core\Entity\RevisionableInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\revision_manager\Plugin\RevisionManagerBase;

/**
 * @RevisionManager(id = "keep_published", label = @Translation("Keep published only"))
 */
final class KeepPublished extends RevisionManagerBase {
  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    return $form; // no settings
  }
  public function deleteRevisions(RevisionableInterface $entity): array {
    $buckets = $this->getRevisionIds($entity, [
      ['field' => $entity->getEntityType()->getKey('revision'),
       'value' => (int) $entity->getRevisionId(), 'operator' => '<'],
    ]);
    return $this->getRemovableRevisionIds($entity, $buckets, 0);
  }
}
```
