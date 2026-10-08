# `hook_footnotes_upgrade_3x4x_build_alter()`

The single hook Footnotes invites (declared in `footnotes.api.php`). It fires while the Drush
`footnotes:upgrade-3-to-4` command rebuilds each footnote from 3.x to 4.x markup, letting you
adjust an individual footnote's render array before it is serialized back into the field.

```php
/**
 * @param array $build    Render array for one upgraded footnote item.
 * @param array $context  Options passed to the drush command (e.g. use-data-text).
 * @see \Drupal\footnotes\Upgrade\FootnotesUpgradeBatchManager::replaceCallback()
 */
function mymodule_footnotes_upgrade_3x4x_build_alter(array &$build, array $context) {
  // Example: decode already-escaped HTML depending on how notes were authored.
  if (empty($context['use-data-text'])) {
    $build['#value'] = html_entity_decode($build['#value']);
  }
  else {
    $build['#attributes']['data-text'] = html_entity_decode($build['#attributes']['data-text']);
  }
}
```

- Only relevant during the 3→4 upgrade command; it is not called on normal display.
- `$context` carries the command options (notably `use-data-text`), so you can branch on how
  the site's legacy footnotes were written.
- Modify `$build['#value']` (the note content) or `$build['#attributes']` (e.g. `data-text`,
  `data-value`) as needed.
