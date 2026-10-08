<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: alter the candidate file paths

The only hook the module invites (`critical_css.api.php`):

```php
/**
 * Alter the possible paths to search for critical CSS files.
 *
 * @param array $file_paths
 *   The ordered critical CSS candidate file paths (most specific first). Add,
 *   remove, or reorder entries; the first existing, non-empty file wins.
 * @param \Drupal\Core\Entity\ContentEntityInterface|null $entity
 *   The current entity (node/taxonomy term), or NULL off an entity route.
 */
function hook_critical_css_file_paths_suggestion_alter(array &$file_paths, ?ContentEntityInterface $entity) {
  // Example: prefer a per-language critical file.
  if ($entity) {
    $lang = $entity->language()->getId();
    array_unshift($file_paths, \Drupal::theme()->getActiveTheme()->getPath()
      . '/css/critical/' . $entity->id() . '-' . $lang . '.css');
  }
}
```

Invoked as `moduleHandler->alter('critical_css_file_paths_suggestion', $file_paths, $entity)`
at the end of `CriticalCssProvider::calculateFilePaths()`, after the built-in candidates
(entity id, path variants, bundle, `default-critical`) are assembled. Use it to inject
additional lookups (per language, per role, per query arg, etc.) or to change precedence.
Each path is an absolute-in-theme file path string.
