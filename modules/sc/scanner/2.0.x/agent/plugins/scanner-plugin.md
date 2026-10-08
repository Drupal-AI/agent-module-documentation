# scanner — add support for a new entity type (Scanner plugin)

Scanner discovers one plugin per supported entity type. Plugin type:

- Manager service: `plugin.manager.scanner` (`ScannerPluginManager`), subdir `Plugin/Scanner`.
- Annotation: `@Scanner` (`\Drupal\scanner\Annotation\Scanner`) with **required** properties
  `id` and `type` (the entity type id). Id convention: `scanner_<type>`.
- Interface: `\Drupal\scanner\Plugin\ScannerPluginInterface`
  (`search()`, `replace()`, `undo()`).
- Base class: `\Drupal\scanner\Plugin\ScannerPluginBase`; the concrete
  `\Drupal\scanner\Plugin\Scanner\Entity` base implements the full search/replace/undo/query
  logic for any content entity, so most plugins just extend it.

Built-in plugins (`src/Plugin/Scanner/`): `Node` (`scanner_node`), `Paragraph`, `Entity`
(abstract), `CommerceProduct`, `CommerceProductVariation`. Node is literally:

```php
namespace Drupal\mymodule\Plugin\Scanner;

use Drupal\scanner\Plugin\Scanner\Entity;

/**
 * @Scanner(
 *   id = "scanner_my_entity",
 *   type = "my_entity",
 * )
 */
class MyEntity extends Entity {
  // Extend Entity to inherit search/replace/undo for a standard content entity.
  // Override handleParentRelationship() if replacing a child (e.g. paragraph) must
  // also re-save its parent — see Paragraph.php for the pattern.
}
```

Notes:
- Uses the legacy `@Scanner` **annotation** (not a PHP attribute) — keep the docblock form.
- The entity type must be a fieldable content entity with `type`/bundle support; `Entity`
  scans `text*`, `string*`, and `link` fields.
- After adding the plugin, clear caches (`drush cr`); the field will appear on the settings
  form once you enable that entity type/bundle there.
