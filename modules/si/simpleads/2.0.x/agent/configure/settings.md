# Configure SimpleAds

All settings live in one config object, `simpleads.config` (`BaseSettingsForm::CONFIG_NAME`). Three admin
forms edit different subsets of it, all under `/admin/config/simpleads/advertisement` and all gated by
`administer simpleads entities`.

| Route | Path | Form class | Sets keys |
|---|---|---|---|
| `simpleads.advertisement` | `/admin/config/simpleads/advertisement` | `Form\SettingsForm` | `ads_view_mode` |
| `simpleads.advertisement.responsive` | `.../advertisement/responsive` | `Form\ResponsiveSettingsForm` | `desktop_media_query`, `tablet_media_query`, `mobile_media_query` |
| `simpleads.advertisement.stats` | `.../advertisement/stats` | `Form\StatisticSettingsForm` | `stats_view_mode`, `stats_date_format` |

`simpleads.advertisement` is the `configure` route declared in `simpleads.info.yml`. `simpleads.admin`
(`/admin/config/simpleads`) is just the menu landing page. Group and Campaign lists are `simpleads.group`
and `simpleads.campaign` (gated by `administer simpleads_group entities` / `administer simpleads_campaign entities`).

## Config keys (`config/schema/simpleads.schema.yml`, type `simpleads.config`)

| Key | Type | Default (`config/install`) | Meaning |
|---|---|---|---|
| `ads_view_mode` | string | `advertisement` | View mode used to render an ad in blocks/REST (`SimpleAdsBase::getRenderedHtml()`). |
| `stats_view_mode` | string | `statistics` | View mode used on the ad statistics tab. |
| `stats_date_format` | string | `advertisement_statistics` | `date_format` entity id used to format stat dates (`SimpleAdsStats::getDateTimeFormat()`). |
| `desktop_media_query` | string | `(min-width: 992px)` | Media query for the desktop responsive image. |
| `tablet_media_query` | string | `(min-width: 768px)` | Media query for the tablet responsive image. |
| `mobile_media_query` | string | `(max-width: 767px)` | Media query for the mobile responsive image. |

The view-mode selects are populated from `getViewModeOptionsByBundle('simpleads', 'simpleads')`; install
ships view modes `advertisement` and `statistics` plus their `entity_view_display` config. Install also
creates the `advertisement_statistics` date format (removed on uninstall).

## Set via Drush / PHP

```bash
drush config:set simpleads.config ads_view_mode advertisement -y
drush config:set simpleads.config stats_date_format advertisement_statistics -y
```

```php
\Drupal::configFactory()->getEditable('simpleads.config')
  ->set('mobile_media_query', '(max-width: 640px)')
  ->save();
```

Read a value: `\Drupal::config('simpleads.config')->get('ads_view_mode');`
