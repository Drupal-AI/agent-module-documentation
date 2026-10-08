# Icon metadata service & alter hooks

## Service `fontawesome.font_awesome_manager`
`\Drupal\fontawesome\FontAwesomeManagerInterface` — reads the bundled icon metadata
(cached in the `font_awesome` cache bin). Methods:
- `getIcons()` — list of all icon names.
- `getIconMetadata($findIcon)` — metadata array for one icon (or FALSE).
- `getMetadata()` — full available icon metadata.
- `getMetadataFilepath()` — path to the metadata file.
- `determinePrefix(array $styles, $default = 'fas')` — resolve the FA prefix (fas/far/fab…)
  for an icon from its valid styles.

```php
$mgr = \Drupal::service('fontawesome.font_awesome_manager');
$meta = $mgr->getIconMetadata('star');
$prefix = $mgr->determinePrefix($meta['styles'] ?? []);
```

## Hooks (`fontawesome.api.php`)
- `hook_fontawesome_metadata_alter(array &$metadata)` — alter the icon metadata (add custom
  icons, remove icons).
- `hook_fontawesome_metadata_categories_alter(array &$metadata)` — alter the category metadata.
