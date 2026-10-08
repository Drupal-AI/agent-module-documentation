# hook_addtocal_links_alter()

Alter the render array of Add to Cal links before they are themed (per field delta).

```php
/**
 * @param array $links   The render array (#theme => 'addtocal_links').
 * @param array $context ['items' => FieldItemListInterface, 'langcode' => string, 'delta' => int]
 */
function mymodule_addtocal_links_alter(array &$links, array $context) {
  $items = $context['items'];
  if ($items->getEntity()->getEntityTypeId() !== 'node') {
    return;
  }

  /** @var \Spatie\CalendarLinks\Link $link */
  $link = $links['#addtocal_link'];
  $link->description('Custom description');   // mutate the shared Link object

  // Remove the ics option:
  unset($links['#items']['ics']);

  // Add a custom generator (implements \Spatie\CalendarLinks\Generator):
  $links['#items']['your_calendar'] = [
    'title'      => t('Your Calendar'),
    'aria-label' => t('Add to Your Calendar'),
    'generator'  => new \Your\Generator(),
  ];
}
```

## What you get in `$links`

- `#addtocal_link` — the `Spatie\CalendarLinks\Link` for this delta (title, start/end, address,
  description already applied from the formatter settings).
- `#items` — keyed list of calendar targets, each `['title', 'aria-label', 'generator']`. Default
  keys: `google`, `yahoo`, `web_outlook`, `web_office`, `ics`. The theme layer calls
  `Link::formatWith($generator)` to produce each URL.
- `#button_text`, `#button_attributes`, `#menu_attributes`, `#attributes`, `#id`, `#access`.

Generators live in `Spatie\CalendarLinks\Generators\*` (`Google`, `Yahoo`, `WebOutlook`,
`WebOffice`, `Ics`). Add your own by implementing `Spatie\CalendarLinks\Generator`. The same
`#items` structure powers the `addtocal-url` token replacements.
