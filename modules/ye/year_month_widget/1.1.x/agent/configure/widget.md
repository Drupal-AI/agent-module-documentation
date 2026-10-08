<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Year/Month widget

No global settings page. You pick the widget per field on an entity's **Manage form display** tab
(`admin/structure/…/form-display`), then set its two options via the widget cog.

## Select it

The **Year/month** widget (id `year_month_widget`) is offered for any field of type **`datetime`**
(core Date/time). It is not available for `daterange`, `datetime` with a date-only setting still
works — the widget always shows year + month selects in a fieldset.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `part_order` | string | `YM` | Dropdown order: `YM` = Year then Month, `MY` = Month then Year. Maps to the `datelist` `#date_part_order` (`['year','month']` / `['month','year']`). |
| `year_range` | string | `''` | A `datelist` `#date_year_range`. Empty = core default. Formats: relative `-3:+1`, absolute `2000:2010`, or mixed `2000:+3`. Validated by `YearMonthWidget::validateYearRange()` against `/^[+-]?\d{1,4}:[+-]?\d{1,4}$/`; an invalid string sets a form error. |

Schema: `field.widget.settings.year_month_widget` (`part_order`, `year_range`). Settings are stored
in the form-display component, e.g. `core.entity_form_display.<entity>.<bundle>.<mode>` →
`content.<field>.settings`.

## How the element is built (`formElement()`)

Calls the parent `DateTimeWidgetBase::formElement()`, adds a `fieldset` theme wrapper, then
overlays a `#type => 'datelist'` with `#date_part_order` from `part_order` and (if set)
`#date_year_range` from `year_range`. Because it rides on the core datetime widget, value
parsing/storage stays standard — the saved field value remains a full datetime with day/time
defaulted by the datelist.

## Set the widget with Drush

```php
// drush php:eval — put the Year/month widget on node.article field_period, Month/Year order, 2000..now+1
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_period', [
  'type' => 'year_month_widget',
  'region' => 'content',
  'settings' => ['part_order' => 'MY', 'year_range' => '2000:+1'],
])->save();
```
