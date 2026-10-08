# Configure the "Address Display" formatter

`address_display_formatter` (label "Address Display") is a field formatter for `address` fields.
There is **no configure route** — you set it per field, per view mode, on the entity's
**Manage display** page, or directly in the `entity_view_display` config.

## Where the settings are stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: address_display_formatter
    label: hidden
    settings:
      address_display:
        organization:   { display: true,  glue: '',  weight: -1 }
        address_line1:   { display: true,  glue: '',  weight: 0 }
        address_line2:   { display: true,  glue: ',', weight: 1 }
        locality:        { display: true,  glue: ',', weight: 3 }
        postal_code:     { display: true,  glue: '',  weight: 4 }
        country_code:    { display: true,  glue: '',  weight: 5 }
        administrative_area: { display: false, glue: ',', weight: 100 }
        given_name:      { display: true,  glue: '',  weight: 100 }
        family_name:     { display: true,  glue: ',', weight: 100 }
        # ... address_line3, dependent_locality, sorting_code, langcode
```

Per component:
- **display** (bool) — whether the component is rendered at all.
- **glue** (string) — a separator string appended after the component's value (skipped for the last
  displayed component). E.g. `','` or `', '`.
- **weight** (int) — render order; lower weights come first.

Components: `organization`, `address_line1`, `address_line2`, `address_line3`, `locality`,
`postal_code`, `country_code`, `langcode`, `administrative_area`, `dependent_locality`,
`sorting_code`, `given_name`, `family_name`. `country_code` renders as the full country name.

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. For the address field, choose **Address Display** in the Format column.
3. Click the gear/cog; a draggable table appears with Label / Display / Glue / Weight per component.
4. Tick the components to show, set glue separators, drag to reorder, **Update**, then **Save**.
   The summary reads "Display: <listed components>".

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_location', [
  'type' => 'address_display_formatter',
  'label' => 'hidden',
  'region' => 'content',
  'settings' => ['address_display' => [
    'locality'     => ['display' => TRUE,  'glue' => ', ', 'weight' => 0],
    'country_code' => ['display' => TRUE,  'glue' => '',   'weight' => 1],
    'postal_code'  => ['display' => FALSE, 'glue' => '',   'weight' => 2],
  ]],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_location
# type: address_display_formatter, settings.address_display.<component>.display/glue/weight
```

## Config schema

Ships `field.formatter.settings.address_display_formatter` — a mapping with an `address_display`
sequence, each item a mapping of `glue` (string), `weight` (integer), `display` (boolean).
