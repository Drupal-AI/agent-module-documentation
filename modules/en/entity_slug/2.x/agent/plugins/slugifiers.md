<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Slugifier plugin type

Entity Slug defines a custom plugin type, **Slugifier**, that performs one string transformation in
the slug pipeline. A field runs its enabled slugifiers in **weight order** (ascending), passing each
one's output into the next.

## Discovery & manager

- Namespace: **`Plugin/Slugifier`** (`src/Plugin/Slugifier/`).
- Manager: `SlugifierManager` (`src/SlugifierManager.php`), service **`plugin.manager.slugifier`**
  (`entity_slug.services.yml`, `parent: default_plugin_manager`). Alter hook: **`slugifier_info`**.
  Cache key: `slugifier_info_plugins`.
- Annotation: `@Slugifier` (`src/Annotation/Slugifier.php`) with `id`, `name`
  (`@Translation`), and integer `weight`.
- Interface: `SlugifierInterface` (extends `ConfigurableInterface`, `DependentPluginInterface`) —
  `slugify($input, FieldableEntityInterface $entity): string` and `information(): string[]`.
- Base class: `SlugifierBase` (empty `information()`, `defaultConfiguration()`,
  `calculateDependencies()`; standard get/set configuration).

> Note: `SlugifierManager` passes the interface FQN as
> `Drupal\entity_slug\Slugifier\SlugifierInterface`, but the actual interface is
> `Drupal\entity_slug\Plugin\Slugifier\SlugifierInterface`. Discovery works because plugins are found
> by annotation, and each shipped plugin extends `SlugifierBase` directly.

## Shipped slugifiers (weight order)

| id | Name | Weight | What it does |
|---|---|---|---|
| `token` | Token replacer | -50 | `\Drupal::token()->replace($input, [entityType => entity])`, then strips any leftover `[...]` tokens with `preg_replace('/\[[^\]]+\]/','')`. Resolves tokens against the **host entity** (and global tokens). **Enabled by default.** |
| `pathauto` | Pathauto cleaner | 50 | `pathauto.alias_cleaner->cleanString($input)` — applies Pathauto's site-wide cleaning (case, punctuation, separators) to make the string URL-safe. **Enabled by default.** |
| `entity_token` | Entity token replacer | -60 | Replaces `[entity_token:TYPE:ID:FIELD]` by loading that entity and resolving `[TYPE:FIELD]` on it. |
| `entity_alias` | Entity alias replacer | -60 | Replaces `[entity_alias:TYPE:ID]` with the URL alias of that entity (falls back to default language, then empty). Uses `path_alias.manager`. |
| `term_parent_token` | Term parent token replacer | -60 | Replaces `[term_parent:FIELD:TERM_FIELD]` with `TERM_FIELD` on the **top-most** parent term of the first term referenced by `FIELD` (walks `TermStorage::loadParents`). Requires taxonomy. |
| `short_circuit` | Short circuit | 20 | Given `{{a}{b}{c}}`, outputs the **first non-empty** inner `{...}` value. Used to build fallback chains, e.g. `{{[node:field_headline]}{[node:title]}}`. |

Only **`token`** and **`pathauto`** are on by default (`SlugItemBase::defaultFieldSettings()`); the
rest are opt-in per field via the field settings checkboxes.

### Typical composition

A common pattern combines negative-weight replacers (they run first, expanding tokens/aliases into
literal text) with the positive-weight `pathauto` cleaner (runs last, normalizing the whole thing).
Example enabled set for a node: `token` + `pathauto` with input `[node:title]` → the title text →
cleaned slug. Add `short_circuit` for fallbacks, or `entity_token`/`term_parent_token` to pull in
values from related entities.

## Writing a custom slugifier

```php
namespace Drupal\my_module\Plugin\Slugifier;

use Drupal\Core\Entity\FieldableEntityInterface;
use Drupal\entity_slug\Plugin\Slugifier\SlugifierBase;

/**
 * @Slugifier(
 *   id = "my_upper",
 *   name = @Translation("Uppercase"),
 *   weight = 0,
 * )
 */
class UppercaseSlugifier extends SlugifierBase {
  public function slugify($input, FieldableEntityInterface $entity) {
    return strtoupper($input);
  }
  public function information() {
    return [$this->t('Uppercases the slug.')];
  }
}
```

Place it in `src/Plugin/Slugifier/`, clear caches, and it becomes selectable in every slug field's
settings. Choose a `weight` relative to `token` (-50) and `pathauto` (50) to control when it runs.
`information()` lines are shown to editors under the widget.

## Operating notes

- The `token` slugifier removes **unresolved** tokens entirely, so a typo like `[node:no_such]`
  disappears rather than showing literally.
- `short_circuit` matches nested-brace groups iteratively; combine it with token replacers so each
  `{...}` alternative resolves before selection.
- `entity_alias` is **language-aware**: it uses the host entity's language first, then the site
  default language, then falls back to empty if no alias exists.
