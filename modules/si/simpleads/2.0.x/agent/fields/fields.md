# Field types, widgets, and formatters

The module defines three field types. Two of them (`simpleads_stats`, `simpleads_advertisement`) are computed
base fields already attached to the ad entity; the third (`simpleads_reference`) is one you add yourself to
other entities to hand-pick ads.

## `simpleads_reference` — pick specific ads on any entity

- Field type `Plugin\Field\FieldType\SimpleAdsReferenceItem` — single column `target_id` (int, main property),
  `default_widget = simpleads_reference`, `default_formatter = simpleads_reference`. Cardinality is up to you.
- Widget `Plugin\Field\FieldWidget\SimpleAdsReferenceWidget` (id `simpleads_reference`) — autocomplete text
  input backed by route `simpleads.autocomplete` (`Controller\SimpleAdsAutocomplete`, permission
  `add simpleads entities`), which searches published ad titles.
- Formatter `Plugin\Field\FieldFormatter\SimpleAdsReferenceFormatter` (id `simpleads_reference`, label
  "Reference") — renders the referenced ads as a rotating unit. Settings: `rotation` (`loop`/`refresh`),
  `rotation_speed`, `rotation_pauseonhover`, `rotation_impressions`, `show_in_modal` + modal options. At runtime
  it emits the `simpleads_reference` theme and lets `simpleads.reference.js` fetch the ads from the
  `simpleads_reference` REST resource (`/simpleads/reference/{entity_type}/{field_name}/{entity_id}`).

Add it with Field UI, or:

```php
FieldStorageConfig::create([
  'field_name' => 'field_ads', 'entity_type' => 'node', 'type' => 'simpleads_reference',
  'cardinality' => -1,
])->save();
FieldConfig::create(['field_name' => 'field_ads', 'entity_type' => 'node', 'bundle' => 'article'])->save();
```

## `simpleads_stats` — statistics display (computed)

- Field type `SimpleAdsStatsItem` (computed, item class `Plugin\Field\SimpleAdsFieldItem`), attached to the ad
  as the base field `stats`.
- Widget `SimpleAdsStatsWidget` (id `simpleads_stats`).
- Formatters:
  - `SimpleAdsStatsFormatter` (id `simpleads_stats`) — the tabbed statistics table.
  - `SimpleAdsStatsChartFormatter` (id `simpleads_stats_chart`, label "Charts") — Chart.js graphs; settings are
    per-metric colours `clicks`, `clicks_unique`, `impressions`, `impressions_unique`, `ctr`, plus `default_tab`
    (schema `field.formatter.settings.simpleads_stats_chart`). Tabs come from `simpleads_graph_reports()`
    (All Time / Last 30 days / Last Week / Today / Table).

## `simpleads_advertisement` — rendered ad markup (computed)

- Field type `SimpleAdsItem` (computed, item class `SimpleAdsFieldItem`), attached to the ad as the base field
  `advertisement`.
- Widget `SimpleAdsWidget` (id `simpleads_advertisement`), formatter `SimpleAdsFormatter` (id
  `simpleads_advertisement`) — outputs the ad body per its `type` (image / responsive image / html5 iframe).

All field-type / widget / formatter ids above are the exact machine names to use in `entity_form_display` /
`entity_view_display` config.
