<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting a delimiter

There is **no admin settings page** (`configure = null`). You set the delimiter per field, per
view mode, on the entity's *Manage display* page.

## In the UI

1. Go to the entity's **Manage display** (e.g. *Structure → Content types → Article → Manage
   display*), for the relevant view mode.
2. The field must be **multi-value** (cardinality > 1 or unlimited) — the option only appears then.
3. Click the field's formatter **cog**. A **Field Delimiter** textfield (5 chars) appears.
4. Enter the delimiter (e.g. `, ` or `<br>`), **Update**, then **Save**. The formatter summary
   then shows *"Delimited by: …"*.

## Where it is stored

As a third-party setting on the formatter component of the `entity_view_display` config entity:

```yaml
# core.entity_view_display.node.article.default
content:
  field_tags:
    third_party_settings:
      field_delimiter:
        delimiter: ', '
```

Schema: `field.formatter.third_party.field_delimiter` (`delimiter: string`).

## In code / for deployment

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$component = $vd->getComponent('field_tags');
$component['third_party_settings']['field_delimiter']['delimiter'] = ', ';
$vd->setComponent('field_tags', $component)->save();
```

Inspect: `drush config:get core.entity_view_display.node.article.default content.field_tags`.
Allowed HTML in the delimiter: only `br, hr, span, img, wbr` (everything else is stripped).
