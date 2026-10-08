<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API common fields — agent index

Adds one Search API **processor**, `common_field`, that merges identically-named properties
from multiple datasources into a single index field (like Aggregated Fields, but across
datasources). No settings page, no permissions, no Drush, no config schema — all state is
in the `search_api.index.<id>` config entity. Requires `search_api`.

- **Enable the processor and add a common field to an index (config shape, `property_name`)** →
  [configure/common-field.md](configure/common-field.md)
- **The `common_field` processor + `CommonFieldProperty`: how values are merged at index time** →
  [plugins/processor.md](plugins/processor.md)

Key facts:
- Processor id `common_field` (`locked`, `hidden`): it is enabled implicitly when you add a
  Common field, not from the Processors tab.
- UI flow: index *Fields* tab → **Add fields** → **Common field** → pick a property that
  exists on 2+ datasources. Only cross-datasource properties are offered.
- A common field stores `datasource_id: null`, `property_path: common_field`, and its chosen
  source under `configuration.property_name` in the index's `field_settings`.
