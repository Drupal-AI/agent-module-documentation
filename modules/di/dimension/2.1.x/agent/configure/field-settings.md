# Dimension — field & storage settings

Dimension fields have **no module settings page**; everything is configured on the field
itself under *Manage fields* (storage settings + field settings), or in the field's config
entities. Settings exist per component **and** for the computed `value`.

## Storage settings (per component + `value`)

Set on the field storage (*field storage settings*, editable only while the field has no
data — `#disabled` once data exists):

| Setting | Range | Default | Meaning |
|---|---|---|---|
| `<key>_precision` | 10–32 | 10 | Total digits stored (incl. decimals). |
| `<key>_scale` | 0–10 | 2 | Digits to the right of the decimal. |

where `<key>` is each component (`width`, `height`, `length`) **and** `value`. E.g. an Area
field has `width_precision`, `width_scale`, `height_precision`, `height_scale`,
`value_precision`, `value_scale`.

## Field settings (per component + `value`)

| Setting | Applies | Meaning |
|---|---|---|
| `factor` | each component + `value` | Multiplier used in the dimension calculation. Component factors default to 1; the `value` factor is hidden in the UI. |
| `min` | each component | Minimum allowed (Range constraint). Blank = none. |
| `max` | each component | Maximum allowed (Range constraint). Blank = none. |
| `prefix` | each component + `value` | String prefixed to the value (e.g. `cm `). `singular|plural` supported. |
| `suffix` | each component + `value` | String suffixed (e.g. ` m²`). `singular|plural` supported. |

The `value` component's `prefix`/`suffix` are what the value formatters print around the
computed total (the `Dimension` formatter base copies `value.prefix`/`value.suffix` up to
`prefix`/`suffix`).

## Config shape

FieldConfig `settings` looks like (Area example):

```yaml
settings:
  width:  { factor: 1, min: '', max: '', prefix: '', suffix: '' }
  height: { factor: 1, min: '', max: '', prefix: '', suffix: '' }
  value:  { factor: 1, min: '', max: '', prefix: '', suffix: ' m²' }
```

Set programmatically:

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_dim_length');
$fc->setSetting('length', ['factor' => 10, 'min' => '', 'max' => '', 'prefix' => '', 'suffix' => ' mm']);
$fc->save();
```

(Here a Length field with `length.factor = 10` converts an entered value in cm to a stored
value in mm.)
