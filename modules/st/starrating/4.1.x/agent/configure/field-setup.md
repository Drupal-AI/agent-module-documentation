# Add & configure a Star rating field

There is **no module settings page**. You add a `starrating` field to any fieldable bundle
through Field UI (*Manage fields*), or in config/code, then pick a widget and formatter.

## Field type, widget, formatters

| Plugin id | Kind | Notes |
|---|---|---|
| `starrating` | field type | tiny `int` `value` column; `default_widget`/`default_formatter` both `starrating` |
| `starrating` | widget | a `select` of `0…max_value` (`0` = "Not selected", the empty value) |
| `starrating` | formatter | renders the score as icons (theme `starrating_formatter`) |
| `starrating_value` | formatter | renders the raw integer |
| `starrating_value_rating` | formatter | renders `rate/max_value`, e.g. `8/10` |

## Field setting

- **`max_value`** (integer, 1–10, default 10) — the top of the rating scale, set on the field
  instance (*Manage fields → field settings*, "Maximum rating value"). Stored under
  `field.field.<entity>.<bundle>.<field>.settings.max_value`.

## Icon formatter settings (`starrating` formatter only)

| Setting | Values | Meaning |
|---|---|---|
| `icon_type` | `star`, `starline`, `check`, `heart`, `dollar`, `smiley`, `food`, `coffee`, `movie`, `music`, `human`, `thumbsup`, `car`, `airplane`, `fire`, `drupalicon`, `custom` | which icon set (each maps to CSS library `starrating/<icon_type>`) |
| `icon_color` | `1`–`8` | color variant |
| `fill_blank` | `0`/`1` | also draw empty icons from the score up to `max_value` |

## Create in code / drush

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_rating', 'entity_type' => 'node', 'type' => 'starrating',
])->save();
FieldConfig::create([
  'field_name' => 'field_rating', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Rating', 'settings' => ['max_value' => 5],
])->save();

// Display as heart icons:
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_rating', [
  'type' => 'starrating',
  'settings' => ['icon_type' => 'heart', 'icon_color' => 2, 'fill_blank' => 1],
])->save();

// …or as text "8/10":
$vd->setComponent('field_rating', ['type' => 'starrating_value_rating', 'settings' => []])->save();
```

## Read it back

```bash
drush cget field.field.node.article.field_rating settings          # -> max_value: 5
drush cget core.entity_view_display.node.article.default content.field_rating
```

Config schema keys: `field.field_settings.starrating` (`max_value`) and
`field.formatter.settings.starrating` (`fill_blank`, `icon_type`, `icon_color`).
