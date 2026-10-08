# Enable "Add more" on a capped field

The module has **no configure route** and no settings page. You turn it on per field, per form
mode, on **Manage form display** (or directly in the `entity_form_display` config).

## Where the setting is stored

Config entity `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`, within the field's
component:

```yaml
content:
  <field_name>:
    type: <any widget>
    third_party_settings:
      field_widget_add_more:
        add_more: true
```

Schema: `field.widget.third_party.field_widget_add_more` (a single boolean `add_more`, label
"Show add more button").

## When the checkbox is available

Only for fields whose **storage cardinality is a fixed integer greater than 1**. The
third-party-settings form returns nothing (no checkbox) when cardinality is `1` or
**unlimited** (`-1`). So it targets capped multi-value fields like cardinality 2, 3, 4, ….

## Via the UI

1. Go to the bundle's **Manage form display** (e.g. Article:
   `/admin/structure/types/manage/article/form-display`).
2. Click the cog on the capped multi-value field's row.
3. Tick **Show add more button**.
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$c  = $fd->getComponent('field_phones');            // a cardinality-N (N>1) field
$c['third_party_settings']['field_widget_add_more']['add_more'] = TRUE;
$fd->setComponent('field_phones', $c)->save();
```

Turn it off by setting `add_more` to `FALSE` (or unsetting the `field_widget_add_more`
third-party settings key) and saving.

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_phones
# look for third_party_settings.field_widget_add_more.add_more: true
```
