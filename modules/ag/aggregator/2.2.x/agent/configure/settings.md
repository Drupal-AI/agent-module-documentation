# Configure aggregator

## Admin routes (all require `administer news feeds` unless noted)

| Route | Path | Purpose |
|---|---|---|
| `aggregator.admin_overview` | `/admin/config/services/aggregator` | List feeds; per-feed update/delete-items links. Also the `field_ui_base_route` for `aggregator_feed`. |
| `aggregator.admin_settings` | `/admin/config/services/aggregator/settings` | Global settings form (**the `configure` route**). |
| `aggregator.feed_add` | `/aggregator/sources/add` | Add a feed. |
| `aggregator.opml_add` | `/admin/config/services/aggregator/add/opml` | Import feeds from an OPML file. |
| `aggregator.feed_refresh` | `/admin/config/services/aggregator/update/{aggregator_feed}` | Manually refresh one feed (CSRF-protected). |
| `aggregator.feed_items_delete` | `/admin/config/services/aggregator/delete/{aggregator_feed}` | Delete all stored items of a feed. |
| `aggregator.page_last` | `/aggregator` | Public listing (requires `access news feeds`). |

Feed entities have their own routes: `entity.aggregator_feed.canonical`
(`/aggregator/sources/{aggregator_feed}`), `.edit_form` (`/…/configure`), `.delete_form`.

## Config object: `aggregator.settings`

Defaults from `config/install/aggregator.settings.yml`:

```yaml
fetcher: aggregator            # active fetcher plugin id (single)
parser: aggregator             # active parser plugin id (single)
processors: [aggregator]       # active processor plugin ids (multiple)
items:
  expire: 9676800             # discard items older than N seconds (here 16 weeks); use FeedStorageInterface::CLEAR_NEVER to keep forever
source:
  list_max: 3                  # items shown per feed on listing pages
normalize_post_dates: false    # if true, item post date = import time
```

The settings form (`\Drupal\aggregator\Form\SettingsForm`) shows fetcher/parser radios
and processor checkboxes **only when more than one plugin of that type exists**; with the
default plugins alone only the processor settings appear. `items.expire` and
`source.list_max` are actually contributed by the **default processor's**
`buildConfigurationForm()`, so they show only while the `aggregator` processor is active.

Set values with Drush:

```bash
drush config:set aggregator.settings source.list_max 10 -y
drush config:set aggregator.settings items.expire 2419200 -y   # 4 weeks
```

## Adding a feed in code / Drush

Feeds are `aggregator_feed` content entities (base fields: `title`, `url`,
`refresh` [interval in seconds], plus derived `description`, `link`, `image`,
`checked`, `queued`, `etag`, `modified`, `hash`).

```php
$feed = \Drupal::entityTypeManager()->getStorage('aggregator_feed')->create([
  'title' => 'Drupal Planet',
  'url' => 'https://www.drupal.org/planet/rss.xml',
  'refresh' => 3600,
]);
$feed->save();
```

## Bundled config

- `filter.format.aggregator_html` — restricted text format used to render item bodies.
- Views `aggregator_rss_feed` and `aggregator_sources` (config/optional; installed if Views is enabled).
- Summary view modes/displays for `aggregator_feed` and `aggregator_item`.
- Block `aggregator_feed_block` (`block.settings.aggregator_feed_block`: `block_count`, `feed`).
