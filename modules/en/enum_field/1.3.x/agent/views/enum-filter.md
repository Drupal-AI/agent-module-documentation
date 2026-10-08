<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter for enum fields

## The filter plugin

Plugin id **`enum_field`** — `Drupal\enum_field\Plugin\views\filter\EnumField` (annotation
`@ViewsFilter("enum_field")`), `extends ManyToOne` and uses `FieldAPIHandlerTrait`. In `init()` it
reads the column's field storage, calls `EnumStringItem::getOptions($storage->getSetting('enum_class'))`,
and assigns the result to `$this->valueOptions`. So the exposed/admin filter shows the enum's cases
as selectable options (a proper select of allowed values) instead of a free-text numeric/string
match.

## How it gets applied

`enum_field.module` `hook_views_data_alter()` finds every `field_config` whose type is
`enum_integer` or `enum_string`, and for each one's `<entity>__<field>` table `.<field>_value`
column, if the existing `filter.id` is `numeric` or `string`, it rewrites it to `enum_field`. This
happens automatically for enum fields — you do not add the filter by hand.

## Update hook for existing views

`enum_field_update_80012()` (in `enum_field.install`) retrofits views created before this behavior:
it scans all `views.view.*` config, and for filters whose `table` maps to an enum field storage it
sets `operator` to `or` and normalizes the stored `value` into the array shape the `ManyToOne`
filter expects. Run `drush updatedb` after upgrading to pick this up; it reports how many views were
updated.
