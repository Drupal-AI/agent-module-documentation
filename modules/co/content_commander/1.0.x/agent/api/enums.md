<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authoring Content Commander enums

Place enums in a custom module's `src/ContentCommander/` (namespace segment `ContentCommander`; override the scanned list with the `content_commander.namespaces` parameter in a site `services.yml`).

An enum case implements `Drupal\content_commander\ContentInterface`:

```php
namespace Drupal\my_module\ContentCommander;

use Drupal\content_commander\ContentInterface;
use Drupal\content_commander\ContentContext;
use Drupal\content_commander\Attribute\DependsOn;
use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\node\Entity\Node;

enum Articles: string implements ContentInterface {
  case First = 'b1f2...uuid...';

  public function uuid(): ?string { return $this->value; } // or return NULL to auto-map
  public function entityClass(): string { return Node::class; }
  public function createContent(ContentContext $c, ContentEntityInterface $entity): void {
    $entity->set('type', 'article')->set('title', 'First');
  }
  public function entity(): ?ContentEntityInterface { /* usually delegate to ContentRepository */ }
}
```

## Dependencies
Attach `#[DependsOn(self::Other)]` (add `optional: true` if usage is conditional) to a case constant. The referenced entity is created first and retrieved inside `createContent()` via `$c->getDependency(self::Other)`. Every non-optional declared dependency **must** be used or the run fails with "Unused entity dependency". Circular chains abort with a `CircularDependencyException`.

## UUID handling
- Return a fixed string from `uuid()` to pin the entity identity across environments (recommended for exportable content).
- Return `NULL` to let the module generate a UUID and store `uuid => Enum::Case` in `content_commander.content_mapping`. Export that config to share the map, or add it to ignored config if per-environment drift is acceptable.

## Running
- `dex content-commander:create-all` — create all discovered content.
- Per-enum commands are auto-registered too.
- Add `-d`/`--delete` to delete any existing same-UUID entity before recreating (destructive; not for production).
- On a normal run existing entities are skipped (idempotent).

## Reading back
Inject `Drupal\content_commander\ContentRepositoryInterface` and call `getEntity($enumCase)` to load the entity a fixture produced (resolves via `uuid()` or the stored mapping).
