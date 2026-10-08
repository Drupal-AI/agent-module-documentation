# Apply the Add to Cal formatter

There is **no settings page**. Configure it per field on the entity's **Manage display**
(`core.entity_view_display.*`) by choosing an Add to Cal formatter.

## Formatters

| Formatter id | Label | Renders |
|---|---|---|
| `addtocal_view` | Add to Cal | Button that opens a menu of calendar links |
| `addtocal_grouped_view` | Add to Cal grouped button | Grouped-button variant |

**Supported field types:** `date`, `datestamp`, `datetime`, `daterange`, `daterange_timezone`,
`date_recur`, `smartdate`. (Both extend core `DateTimeCustomFormatter`.)

## Settings (`field.formatter.settings.addtocal_view`)

| Setting | Type | Meaning |
|---|---|---|
| `event_title` | string | Calendar event title; token-aware. Empty ⇒ entity label. |
| `location` | string | Event location; token-aware. |
| `description` | string | Event description; token-aware. |
| `separator` | string | Start/end separator — shown only for range types (`daterange`, `daterange_timezone`, `date_recur`). |
| `past_events` | bool | If FALSE, the widget is hidden for events whose start is in the past. |
| (inherited) | — | `date_format` / `custom_date_format` / `timezone_override` from `datetime_custom`. |

## Set it in code

```php
\Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default')
  ->setComponent('field_event_date', [
    'type' => 'addtocal_view',
    'label' => 'hidden',
    'settings' => [
      'event_title' => '[node:title]',
      'location'    => '[node:field_venue]',
      'description' => 'Join us!',
      'past_events' => TRUE,
      'date_format' => 'medium',
    ],
  ])->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_event_date`.

## `addtocal-url` token

With `token` enabled, the module adds an `addtocal-url` token type. On a date field token you can
request a single calendar URL, e.g. `[node:field_event_date:addtocal-url:google]`
(sub-tokens: `google`, `yahoo`, `web_outlook`, `web_office`, `ics`). The token builds the field
using an existing `addtocal_view` display component if present, otherwise a default one with
`past_events = TRUE`.
