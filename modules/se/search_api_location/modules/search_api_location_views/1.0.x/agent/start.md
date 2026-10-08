<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Location Views — agent index

Adds Views handlers for Search API Location. For every Search API index field of data type
**`location`**, `hook_views_data_alter()` attaches a proximity **filter**, a point **argument**,
and (when the backend exposes a `<field>__distance` pseudo-field, e.g. Solr) a distance **sort**
and radius **argument**. No config UI of its own.

- **The Views handler ids, how they attach, the distance pseudo-field** →
  [plugins/views-handlers.md](plugins/views-handlers.md)

Key facts:
- Trigger: an index field with `->getType() === 'location'`. Handlers land on the field's
  Views table `search_api_index_<index_id>`.
- Handler ids: filter **`search_api_location`**, argument **`search_api_location_point`** (on the
  location field); sort **`search_api_location_distance`**, argument **`search_api_location_radius`**
  (on the `<field>__distance` pseudo-field). The pseudo-field's `filter` is unset.
- The filter reuses Search API Location's Location Input plugins
  (`plugin.manager.search_api_location.location_input`) for its exposed widget.
- Depends on `search_api` + `search_api_location`. Provides config schema
  (`views.filter.search_api_location`). No permissions, no Drush.
- Verify a field triggers integration:
  `\Drupal::service('views.views_data')->get('search_api_index_<id>')['<field>']['filter']['id']`
  === `'search_api_location'`.
