# Configure Intl date formats

A format is the config entity `intl_date_format` (class `Drupal\intl_date\Entity\IntlDateFormat`,
implements `DateFormatInterface`). It stores three exported keys and nothing else:

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string | machine name; the reserved word `custom` is disallowed |
| `label` | label | human name shown in the list and formatter option lists |
| `pattern` | label | a single **ICU** date/time pattern string (see the ICU datetime guide) |

Config schema: `intl_date.intl_date_format.*` in `config/schema/intl_date.schema.yml`.
The entity has no `settings` route in info.yml (`configure` is null); it is managed as an
entity collection instead.

## Admin UI

Routes (all in `intl_date.routing.yml`), menu link under Configuration › Regional and language:

| Route | Path | Access |
|-------|------|--------|
| `entity.intl_date_format.collection` | `/admin/config/regional/intl-date-time` | perm `administer site configuration` |
| `intl_date.date_format_add` | `/admin/config/regional/intl-date-time/formats/add` | perm `administer site configuration` |
| `entity.intl_date_format.edit_form` | `/admin/config/regional/intl-date-time/formats/manage/{intl_date_format}` | `_entity_access: intl_date_format.update` |
| `entity.intl_date_format.delete_form` | `.../manage/{intl_date_format}/delete` | `_entity_access: intl_date_format.delete` |

The entity's `admin_permission` is `administer site configuration` and it reuses core's
`Drupal\system\DateFormatAccessControlHandler` for access. The add/edit form
(`DateFormatFormBase`) collects `label`, machine `id`, `pattern`, and a `langcode`
(config language) select. The collection list (`IntlDateFormatListBuilder`) previews each
pattern against the current request time.

## Shipped formats (config/install)

These are installed with the module and can be edited or deleted:

| id | label | pattern |
|----|-------|---------|
| `short` | Default short date | `MM/dd/yyyy - HH:mm` |
| `medium` | Default medium date | `eee, MM/dd/yyyy - HH:mm` |
| `long` | Default long date | `eeee, MMMM dd, yyyy - HH:mm` |
| `fallback` | Fallback date format | `eee, MM/dd/yyyy - HH:mm` |
| `html_date` | HTML Date | `yyyy-MM-d` |
| `html_datetime` | HTML Datetime | `yyyy-MM-d'T'HH:mm:ssxx` |
| `html_time` | HTML Time | `HH:mm:ss` |
| `html_week` | HTML Week | `yyyy-'W'ww` |
| `html_month` | HTML Month | `yyyy-MM` |
| `html_year` | HTML Year | `yyyy` |
| `html_yearless_date` | HTML Yearless date | `MM-d` |

ICU pattern note: lowercase `LLLL` is the *standalone* month name, `MMMM` the month name in a
full date — some languages (e.g. Mongolian) translate them differently, which is the module's
core reason to exist over core date formats.

## Create a format without the UI

Drush:

```
drush config:set intl_date.intl_date_format.iso_month label 'ISO month' -y
drush config:set intl_date.intl_date_format.iso_month id iso_month -y
drush config:set intl_date.intl_date_format.iso_month pattern 'yyyy-MM' -y
```

PHP:

```php
\Drupal::entityTypeManager()
  ->getStorage('intl_date_format')
  ->create([
    'id' => 'iso_month',
    'label' => 'ISO month',
    'pattern' => 'yyyy-MM',
  ])
  ->save();
```

Because these are config entities they export and deploy through the normal configuration
sync workflow, just like core's date formats.
