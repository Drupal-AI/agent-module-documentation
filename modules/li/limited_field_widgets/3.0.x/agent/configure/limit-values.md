# Configure the "Limit values" setting

There is **no admin settings page** (`configure: null`). You set the limit per widget on the
entity's *Manage form display* page.

## In the UI

1. The field's **storage cardinality must be Unlimited** (-1). The setting only appears for
   unlimited fields (`FieldStorageDefinitionInterface::CARDINALITY_UNLIMITED`).
2. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
3. Click the field's widget **gear/cog**. A required **"Limit values"** number appears
   (`#min = 0`, `0` = show/allow all values).
4. Enter the maximum and **Update**, then **Save**.

## Where it is stored

The value is written as a third-party setting in two places:

- The **form-display widget component**:
  `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.limited_field_widgets.limit_values`.
- The **field config** (via a custom `#value_callback`,
  `limited_field_widgets_save_limit_setting_callback`):
  `field.field.<entity>.<bundle>.<field>` →
  `third_party_settings.limited_field_widgets.limit_values`.

Schema: `limited_field_widgets.schema.yml` defines
`field.widget.third_party.limited_field_widgets` with an integer `limit_values`
(constraint: Range min 0).

## Via drush / PHP

```php
// Set the widget-component limit on the default form display.
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_tags');
$c['third_party_settings']['limited_field_widgets']['limit_values'] = 3;
$fd->setComponent('field_tags', $c)->save();
// The runtime ItemCount constraint reads the FieldConfig third-party setting:
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_tags');
$field->setThirdPartySetting('limited_field_widgets', 'limit_values', 3)->save();
```

`limit_values = 0` means unlimited (no cap, no constraint added).
